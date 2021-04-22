*** Settings ***
Resource     ../Utils/Global_Resources/common_api.resource
Resource     ../Utils/Global_Resources/config_Enviroment.robot
Resource     ../Resource/MovieListResource.resource

Documentation       This suite contains end to end flow of create List ,Update list,Add Item, Update Item,Remove Item,
...    
Suite Setup     Run Keyword If    "${AccessGeneratePerTestcase}"=="False"         Generate Common Access Token     ${apiReadAccessToken}

Test Setup    Run Keyword If    "${AccessGeneratePerTestcase}"=="True"    Generate Common Access Token     ${apiReadAccessToken}

Default Tags        API_Automation
   
Suite Teardown     Run Keywords
...   Delete List For Movie    ${access_token}      ${list_id}    AND
...    close browser

*** Variables ***
${request_token}
${access_token}
${list_id}      
    
*** Test Cases ***
    
Create New List
    [Tags]            CreateListVerification        smoke
    ${list_id}=          Create List For Movie           ${access_token}         CreateNewllistDemo.properties
    Set Suite Variable    ${list_id} 
    Log To Console      ListId=${list_id}       

Get List
    [Tags]            CreateListVerification        smoke
    Get List Details    ${apiReadAccessToken}       ${list_id}[0]
    
Validation error message from Get List when wrong ID provide
    [Tags]            CreateListVerification            smoke
    Get List Details    ${apiReadAccessToken}       ${list_id}[0]12    WrongID=True

