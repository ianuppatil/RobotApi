*** Settings ***    
Resource     config_Enviroment.robot  

*** Variables ***
${Login_LOC}            //h2[text()='Login']/ancestor::div[1]
${Login_Uname_LOC}      //input[@id="username"] 
${Login_Uname_PASS}     //input[@id="password"]
${Login_Uname_BUTTON}   //input[@id="login_button"]


*** Keywords *** 
Create Request Token
    [Documentation]    This method creting request token for read and wirte access to user for creating updating Movie list   
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${apiReadAccessToken}
    ${headers}=        Set To Dictionary   ${headerParams}    
       
    ${request_body}    Set Variable    {"redirect_to":"${redirectUrl}"}
    ${json_data}       To Json    ${request_body}         
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Post Request        baseurl    auth/request_token    headers=${headers}     data=${json_data}
    
    Verify User Access     ${response.status_code}    200

    ${response}=       To Json      ${response.content}  
    ${request_token}=    Get Value From Json   ${response}    request_token 
    
    [Return]   ${request_token}
     
   
Verify User Access    [Arguments]         ${status}      ${Code} 
    [Documentation]    This method validating access code for APIs
   Should Be Equal As Strings    ${status}    ${Code}  
 
Approve Access Token    [Arguments]         ${request_token}         ${jsession}
    [Documentation]    This method Approving request token ti give read wite access to user
    ${Session}=    Set variable     tmdb.session=${jsession}
    ${headerParams}=   Create Dictionary    Content-Type=application/x-www-form-urlencoded        cookie=${Session}
    ${headers}=        Set To Dictionary   ${headerParams}    
       
    ${requestBody}=   Create Dictionary    request_token=${request_token}[0]   submit=Approve 
    ${requestBody}=   Set To Dictionary   ${requestBody} 
     
    Create Session     baseurl    ${approveReuestBaseUrl}
    ${response}=       Post Request        baseurl    auth/access/approve   data=${requestBody}      headers=${headers}    
    
    Verify User Access     ${response.status_code}            200
  
Request Access Token    [Arguments]         ${request_token} 
    [Documentation]      This method Create access token after Approve Request Token
    ${headerParams}=   Create Dictionary   Content-Type=application/json;charset=utf-8    Authorization=Bearer ${apiReadAccessToken}
    ${headers}=        Set To Dictionary   ${headerParams} 
    
    ${request_body}    Set Variable    {"request_token":"${request_token}[0]"}
    ${json_data}       To Json    ${request_body}    
    
    Create Session     baseurl    ${baseUrl}
    ${response}=       Post Request        baseurl    auth/access_token    headers=${headers}     data=${json_data}
    
    Verify User Access     ${response.status_code}            200

    ${response}=       To Json      ${response.content}  
    ${access_token}=    Get Value From Json   ${response}    access_token 
    
    [Return]   ${access_token}
    

Login Token   
        [Documentation]    This method Login to UI and getting tmdb.session from cookies 
        ${request_token}=    Create Request Token
        initilize system
        go to             ${Approve_URL}=${request_token}[0]
        Click Element     ${Login_LOC}    
        sleep    2s
        input text        ${Login_Uname_LOC}      ${Uname}
        input text        ${Login_Uname_PASS}       1988
        click element     ${Login_Uname_BUTTON}
        ${Session}=       Get Cookies    
        ${Session}=       split string     ${Session}     tmdb.session=
        ${Session}=       split string     ${Session}[1]    ;
       
  [Return]        ${Session}[0]
        
     
Generate Common Access Token 
    [Arguments]         ${request_token}
    [Documentation]    This method contains 4 keywords which helps us to create access token to creare moview list
    
    ###Login to get jsession time id
    ${jsession}=             Login Token
    
    ###Generate  Request token 
    ${request_token}=       Create Request Token
    Log To Console          requestTokenGenerated!!!
    Set Suite Variable      ${request_token}      
          
    Log To Console        requestToken=${request_token}
    Log To Console        Approve Request Token
    
    ###Approve Request Token
    Approve Access Token    ${request_token}               ${jsession}
    
    ###Create access token after Approve Request Token
    ${access_token}=        Request Access Token           ${request_token}
    Log To Console          accesstoken=${access_token}
    Set Global Variable     ${access_token} 

  [Return]    ${access_token}
  

initilize system
       [Documentation]    This method Initialize browser   
    Run Keyword If      '${OS}'=='windows'    Append To Environment Variable               PATH                  ${EXECDIR}//drivers//   
    Run Keyword If      '${OS}'=='mac'        Append To Environment Variable               PATH                  ${EXECDIR}/drivers/
    Chromedriver       
      

Chromedriver
   [Documentation]  This method Initialize chrome browser
   ${Browser}=    Set Variable     Chrome
    
    ${chrome options}=  Evaluate                 sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method          ${chrome_options}        add_argument    test-type
    Call Method          ${chrome_options}        add_argument    --disable-extensions
    Call Method          ${chrome_options}        add_argument    --disable-dev-shm-usage    
    Call Method          ${chrome_options}        add_argument    --no-sandbox
    ${HeadlessFalse}=    Run Keyword And Return Status       Should Contain      ${TEST TAGS}           HeadlessFalse       
    Run Keyword If    "${Headless}"=="True"    Call Method          ${chrome_options}         add_argument    headless
    Create Webdriver     ${Browser}     chrome_options=${chrome options}
    

  

Update json      [Arguments]            ${TestData}        ${JsonFilename}
    [Documentation]        This method updating The json as per properties file 
    ${CURDIR1}=    Replace String    ${CURDIR}    Utils\\Global_Resources    Resource
    ${Mapping}          Get File   ${CURDIR1}\\Json\\${JsonFilename}
    ${json_data}        To Json    ${Mapping}  
     
    FOR    ${element}    IN    @{TestData.keys()}
        
        ${json}=    Update Value To Json    ${json_data}    ${element}   ${TestData}[${element}]
        
    END
        
        
    [Return]         ${json}


#Tried Login throgh API and if we get session id 
     # ${headerParams}=   Create Dictionary    Content-Type=application/x-www-form-urlencoded      authority=www.themoviedb.org            origin=https://www.themoviedb.org
    # ${headers}=        Set To Dictionary   ${headerParams}    
       
    # ${requestBody}=   Create Dictionary    username=ianuppatil   password=password 
    # ${requestBody}=   Set To Dictionary   ${requestBody} 
     
    # Create Session     baseurl    ${approveReuestBaseUrl}
    # ${response}=       Post Request        baseurl    login  data=${requestBody}      headers=${headers}    
    # ${jsession} =     Get Value From Json   ${response.headers}  Set-Cookie
    # log to console      ${jsession}
    # Verify User Access     ${response.status_code}            200
     # [Return]        ${jsession}

