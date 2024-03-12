*** Settings ***
Resource    ../resources/api_testing_usuarios.resource

*** Variables ***


*** Test Cases ***

Cenário 01: Cadastrar um novo usuario na ServeRest
    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${EMAIL_TESTE}    status_code_desejado=201
    Conferir se o usuario foi cadastrado corretamente

Cenário 02: Cadastrar um usuario ja existente na ServeRest
    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${EMAIL_TESTE}    status_code_desejado=201
    Vou repetir o cadastro do usuario    status_code_desejado=400
    Verificar se a API nao permitiu o cadastro do usuario

Cenário 03: Consultar os dados de um novo usuario
    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${EMAIL_TESTE}    status_code_desejado=201
    Consultar os dados do novo usuario
    Conferir os dados retornado

Cenário 04: Atualizar dados usuario
    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${EMAIL_TESTE}    status_code_desejado=201
    Atualizar usuario    email=${EMAIL_TESTE}
    Verificar se dados foram atualizados

Cenário 05: Deletar dados usuario
    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest    email=${EMAIL_TESTE}    status_code_desejado=201
    Deletar usuario
    Verificar se dados foram deletados