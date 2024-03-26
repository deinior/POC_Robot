*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

*** Variables ***
${BASE_URL}    http://localhost:3000
${COMMENTS1}
${RESPONSE1}

*** Keywords ***
eu realizar uma chamada POST com id "${post_id}", título "${post_title}", e visualizações ${post_views}
    ${headers}=    Create Dictionary    
    ...    Content-Type    application/json
    ${payload}=    Create Dictionary    
    ...    id=${post_id}    
    ...    title=${post_title}    
    ...    views=${post_views}
    ${response}=    POST On Session     JSONServer    /posts    json=${payload}    headers=${headers}
    Set Test Variable    ${RESPONSE1}    ${response}
    Log    ${RESPONSE1.json()}

o id da postagem criada deve ser "${expected_post_id}"
    ${created_post}=    Convert To Dictionary    ${RESPONSE1.json()}
    Should Be Equal As Strings    ${created_post['id']}    ${expected_post_id}

o título da postagem criada deve ser "${expected_title}"
    ${created_post}=    Convert To Dictionary    ${RESPONSE1.json()}
    Should Be Equal As Strings    ${created_post['title']}    ${expected_title}

as visualizações da postagem criada devem ser ${expected_views}
    ${created_post}=    Convert To Dictionary    ${RESPONSE1.json()}
    Should Be Equal As Strings    ${created_post['views']}    ${expected_views}

eu realizar uma chamada DELETE com o id "${post_id}"
    ${headers}=    Create Dictionary    
    ...    Content-Type    application/json
    ${responseDelete}=    DELETE On Session     JSONServer    /posts/${post_id}    headers=${headers}
    Set Test Variable    ${RESPONSE1}    ${responseDelete}

eu realizar uma chamada GET com o id "${post_id}"
    ${response}=    GET On Session    JSONServer    /posts/${post_id}    expected_status=any
    Set Test Variable    ${RESPONSE1}    ${response}

eu realizar uma chamada PUT para atualizar a postagem com id "${post_id}" com o título "${post_title}" e visualizações ${post_views}
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${payload}=    Create Dictionary    
    ...    id=${post_id}    
    ...    title=${post_title}    
    ...    views=${post_views}
    ${response}=    PUT On Session     JSONServer    /posts/${post_id}    json=${payload}    headers=${headers}
    Set Test Variable    ${RESPONSE1}    ${response}

eu realizar uma chamada GET com um id inválido
    eu realizar uma chamada GET com o id "invalido"

And o corpo da resposta deve conter a mensagem de erro "${expect_message}"
    Should Be Equal As Strings    ${RESPONSE1.content}    ${expect_message}

eu realizar uma chamada GET com os parâmetros de paginação "page=${page}&_per_page=${per_page}"
    ${response}=    GET On Session    JSONServer    /posts    params={"_page": ${page}, "_per_page": ${per_page}}    expected_status=any
    Set Test Variable    ${RESPONSE1}    ${response}