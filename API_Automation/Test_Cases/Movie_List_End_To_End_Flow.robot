*** Settings ***
Resource     ../Utils/Global_Resources/common_api.resource
Resource     ../Utils/Global_Resources/config_Enviroment.robot
Resource     ../Resource/MovieListResource.resource

Documentation       This suite contains end to end flow of create List ,Update list,Add Item, Update Item,Remove Item,
Suite Setup     Run Keyword If    "${AccessGeneratePerTestcase}"=="False"         Generate Common Access Token     ${apiReadAccessToken}
##If you need to run perticular case you need to Set AccessGeneratePerTestcase==True And need to provide list_id
Test Setup    Run Keyword If    "${AccessGeneratePerTestcase}"=="True"    Generate Common Access Token     ${apiReadAccessToken}

Suite Teardown     close browser
Default Tags        API_Automation
   
*** Variables ***
${request_token}
${access_token}
${list_id}

*** Test Cases ***    
Create New List
    [Tags]            Sanity
    ${list_id}=           Create List For Movie           ${access_token}         CreateNewllistDemo.properties
    Set Suite Variable    ${list_id} 
    Log To Console      ListId=${list_id}      


update New List
    [Tags]            Sanity
    Log To Console  accesstoken=${access_token}
    Update List For Movie       ${access_token}         ${list_id}   
    


Add item In List For Movie
    [Tags]            Sanity
       
    Add item In List For Movie         ${access_token}         ${list_id}


Update item In List For Movie
       [Tags]            Sanity
   Update item In List For Movie      ${access_token}         ${list_id}


Remove item In List For Movie
       [Tags]            Sanity
   Remove item In List For Movie      ${access_token}         ${list_id}

Check Item Status For Movie    
    [Tags]            Sanity  
     ${status_message}=    Check item Status For Movie      ${access_token}         ${list_id}      550     movie   
     Log To Console   ${status_message}       

Clear item In List For Movie
    [Tags]            Sanity
    Clear item In List For Movie        ${access_token}         ${list_id}
  

Deleted New List
    [Tags]            Sanity
    Log To Console  requesttoken=${access_token}
    Delete List For Movie    ${access_token}      ${list_id} 