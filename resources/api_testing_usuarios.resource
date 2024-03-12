*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections

*** Variables ***
${EMAIL_TESTE}
${RESPOSTA}
${ID_USUARIO}
${RESP_CONSULTA}
${RESP_ATUALIZACAO}
${RESP_DELETAR}

*** Keywords ***
Criar um usuario novo
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TESTE}    ${palavra_aleatoria}@emailteste.com
    Log    ${EMAIL_TESTE}

Cadastrar o usuario criado na ServeRest
    [Arguments]    ${email}    ${status_code_desejado}
    Log    ${email}
    ${body}    Create Dictionary
    ...    nome=Fulano da Silva
    ...    email=${email}
    ...    password=1234
    ...    administrador=true
    ${header}    Create Dictionary    
    ...    accept: application/json    
    ...    Content-Type: application/json
    Log    ${header}

    Criar sessao na ServeRest

    ${resposta}    POST On Session    
    ...    alias= ServerRest    
    ...    url=/usuarios    
    ...    json=${body}    
    ...    expected_status=${status_code_desejado}
    Log    ${resposta.json()}
    IF    ${resposta.status_code} == 201
        Set Test Variable    ${ID_USUARIO}    ${resposta.json()["_id"]}
    END
    Set suite Variable    ${RESPOSTA}    ${resposta.json()}

Criar sessao na ServeRest
    ${header}    Create Dictionary    
    ...    accept=application/json    
    ...    Content-Type=application/json
    Create Session    alias=ServerRest    url=https://serverest.dev    headers=${header}

Conferir se o usuario foi cadastrado corretamente
    Log   ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucessot
    Dictionary Should Contain key    ${RESPOSTA}    _id    

Vou repetir o cadastro do usuario
    [Arguments]    ${status_code_desejado}
    Cadastrar o usuario criado na ServeRest    email=${EMAIL_TESTE}    status_code_desejado=${status_code_desejado}

Verificar se a API nao permitiu o cadastro do usuario
     Dictionary Should Contain Item    ${RESPOSTA}    message    Este email já está sendo usado


Consultar os dados do novo usuario
    ${resposta_consulta}    GET On Session    alias=ServerRest    url=/usuarios/${ID_USUARIO}    expected_status=any
    Set Test Variable    ${RESP_CONSULTA}    ${resposta_consulta.json()}

Conferir os dados retornado
    Log    ${RESP_CONSULTA}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    nome    Fulano da Silva
    Dictionary Should Contain Item    ${RESP_CONSULTA}    email   ${EMAIL_TESTE}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    password   1234
    Dictionary Should Contain Item    ${RESP_CONSULTA}    administrador   true

Atualizar usuario
    [Arguments]    ${email}
    ${body}    Create Dictionary
    ...    nome=Fulano dos Santos
    ...    email=${email}
    ...    password=1234
    ...    administrador=true
    ${header}    Create Dictionary    
    ...    accept: application/json    
    ...    Content-Type: application/json
    Log    ${header}

    Criar sessao na ServeRest
    
    ${resposta_atualizacao}    PUT On Session    
    ...    alias= ServerRest    
    ...    url=/usuarios/${ID_USUARIO}  
    ...    json=${body}    
    ...    expected_status=any
    Log    ${resposta_atualizacao.json()}
    Set Test Variable    ${RESP_ATUALIZACAO}    ${resposta_atualizacao}

Verificar se dados foram atualizados
    
    Dictionary Should Contain Item    ${RESP_ATUALIZACAO.json()}    message    Registro alterado com sucesso
    Should Be Equal As Numbers    ${RESP_ATUALIZACAO.status_code}    200

Deletar usuario

    ${resposta_deletar}    DELETE On Session    alias=ServerRest    url=/usuarios/${ID_USUARIO}    expected_status=any
    Set Test Variable    ${RESP_DELETAR}    ${resposta_deletar.json()}

Verificar se dados foram deletados

      Dictionary Should Contain Item    ${RESP_DELETAR}    message    Registro excluído com sucesso