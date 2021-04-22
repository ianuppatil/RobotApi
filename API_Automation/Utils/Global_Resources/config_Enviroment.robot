*** Settings ***
Library    SeleniumLibrary   run_on_failure=Nothing
Library    OperatingSystem      
Library    BuiltIn
Library    Collections
Library    DateTime
Library    DatabaseLibrary
Library    Process    
#Library    SeleniumScreenshots
Library    String
Library    RequestsLibrary  
Library    JSONLibrary    
Library    ../PythonLibarary/CustomLib.py    




*** Variables ***

${apiKey}                       b4c8f3ecd7574535c7e2838bcbc29223    
${apiReadAccessToken}           eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGM4ZjNlY2Q3NTc0NTM1YzdlMjgzOGJjYmMyOTIyMyIsInN1YiI6IjYwNmI0NDNjMWNjNGZmMDAyOWM2MWVmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LVXpKxZrjv7X2_GLPSSKoQAEx2qwVAbK_UiMDFDXv58
${redirectUrl}                  http://www.themoviedb.org/      
${baseUrl}                      https://api.themoviedb.org/4/
${approveReuestBaseUrl}         https://www.themoviedb.org
${AccessGeneratePerTestcase}    False
${Uname}                        ianuppatil
${Pass}                         1988
${OS}                           windows
${Headless}                      True
${Approve_URL}                  https://www.themoviedb.org/auth/access?request_token  

