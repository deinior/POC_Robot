*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    http://localhost:3000    # Altere para a URL do seu servidor JSON
${SESSION_NAME}    MySession

*** Test Cases ***
Teste de Posts
    Create Session    ${SESSION_NAME}    ${BASE_URL}
    ${response}=    Get On Session    ${SESSION_NAME}    /posts
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${posts}=    Get From Dictionary    ${json}    posts
    Length Should Be    ${posts}    2
    Delete All Sessions

Teste de Comentários
    Create Session    ${SESSION_NAME}    ${BASE_URL}
    ${response}=    Get On Session    ${SESSION_NAME}    /comments
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${comments}=    Get From Dictionary    ${json}    comments
    Length Should Be    ${comments}    2
    Delete All Sessions

Teste de Perfil
    Create Session    ${SESSION_NAME}    ${BASE_URL}
    ${response}=    Get On Session    ${SESSION_NAME}    /profile
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${name}=    Get From Dictionary    ${json}[profile]    name
    Should Be Equal As Strings    ${name}    typicode
    Delete All Sessions