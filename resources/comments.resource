*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary


*** Variables ***
${BASE_URL}    http://localhost:3000
${COMMENTS1}
${RESPONSE1}

*** Keywords ***
quando eu realizar uma chamada na rota GET
    ${response}=    GET On Session    JSONServer    /comments
    Set Test Variable    ${RESPONSE1}    ${response}
    Log    ${RESPONSE1}

o numero de comentários deve ser ${expected_length}
    Length Should Be    ${RESPONSE1.json()}    ${expected_length}

o id do primeiro comentário deve ser "${expected_comment_id}"
    ${first_comment}=    Get From List    ${RESPONSE1.json()}    0
    Should Be Equal As Strings    ${first_comment['id']}    ${expected_comment_id}

o texto do primeiro comentário deve ser "${expected_comment_text}"
    ${first_comment}=    Get From List    ${RESPONSE1.json()}    0
    Should Be Equal As Strings    ${first_comment['text']}    ${expected_comment_text}

o postId do primeiro comentário deve ser "${expected_post_id}"
    ${first_comment}=    Get From List    ${RESPONSE1.json()}    0
    Should Be Equal As Strings    ${first_comment['postId']}    ${expected_post_id}