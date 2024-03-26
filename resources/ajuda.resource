*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

*** Variables ***
${BASE_URL}    http://localhost:3000
${COMMENTS1}
${RESPONSE1}

*** Keywords ***
que a API está disponível
    Create Session    JSONServer    ${BASE_URL}

o status code da resposta deve ser ${expected_status_code}
    Log    ${RESPONSE1.status_code}
    Should Be Equal As Strings    ${RESPONSE1.status_code}    ${expected_status_code}

eu realizar uma chamada DELETE com o id da postagem criada
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${responseDelete}=    DELETE On Session     JSONServer    /posts/${RESPONSE1.json()['id']}    headers=${headers}
    Set Test Variable    ${RESPONSE1}    ${responseDelete}

a resposta deve conter "${expected_length}" elemento
    Length Should Be    ${RESPONSE1.json()}    ${expected_length}
