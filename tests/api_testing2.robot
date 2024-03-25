*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

*** Variables ***
${BASE_URL}    http://localhost:3000

*** Test Cases ***
Get Comments
    [Documentation]    Recuperar dados dos comentários da API
    Create Session    JSONServer    ${BASE_URL}
    ${response}=    Get Request    JSONServer    /comments
    Should Be Equal As Strings    ${response.status_code}    200
    ${comments}=    Evaluate    json.loads($response.content)
    Length Should Be    ${comments}    2
    ${first_comment}=    Get From List    ${comments}    0
    Should Be Equal As Strings    ${first_comment['id']}    1
    Should Be Equal As Strings    ${first_comment['text']}    a comment about post 1
    Should Be Equal As Strings    ${first_comment['postId']}    1

Get Profile
    [Documentation]    Recuperar dados do perfil da API
    Create Session    JSONServer    ${BASE_URL}
    ${response}=    Get Request    JSONServer    /profile
    Should Be Equal As Strings    ${response.status_code}    200
    ${profile}=    Evaluate    json.loads($response.content)
    Should Be Equal As Strings    ${profile['name']}    typicode

Create Post and Verify Data
    [Documentation]    Criar um novo post na API e verificar os dados
    Create Session    JSONServer    ${BASE_URL}
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${payload}=    Create Dictionary    id=3    title=new title    views=150
    Log    ${payload}
    ${response}=    POST On Session    JSONServer    /posts    json=${payload}    headers=${headers}
    Log    ${response.text}   # Verifique a resposta do servidor
    Should Be Equal As Strings    ${response.status_code}    201
    ${created_post}=    Convert To Dictionary    ${response.json()}    # Convertendo a resposta em um dicionário
    Log    Created Post: ${created_post}   # Verifique se os dados do post criado estão corretos
    Should Be Equal As Strings    ${created_post['id']}    3
    Should Be Equal As Strings    ${created_post['title']}    new title
    Should Be Equal As Strings    ${created_post['views']}    150
    Dictionary Should Contain Item    ${created_post}    title   new title