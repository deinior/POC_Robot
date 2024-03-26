*** Settings ***
Resource    ../resources/posts.resource
Resource    ../resources/ajuda.resource

*** Variables ***

*** Test Cases ***
Criar Postagem e Verificar Dados
    [Documentation]    Como usuário, quero criar uma nova postagem na API e verificar seus dados
    [Tags]    prioridadeAlta    criar_postagem    api
    Given que a API está disponível
    When eu realizar uma chamada POST com id "4", título "another title", e visualizações 200
    Then o status code da resposta deve ser 201
    And o id da postagem criada deve ser "4"
    And o título da postagem criada deve ser "another title"
    And as visualizações da postagem criada devem ser 200
    And eu realizar uma chamada DELETE com o id da postagem criada

Deletar Postagem
    [Documentation]    Como usuário, quero deletar uma postagem na API
    [Tags]    prioridadeAlta    deletar_postagem    api
    Given que a API está disponível
    And eu realizar uma chamada POST com id "4", título "another title", e visualizações 200
    When eu realizar uma chamada DELETE com o id "4"
    Then o status code da resposta deve ser 200

Buscar Postagem por ID
    [Documentation]    Como usuário, buscar uma postagem por id
    [Tags]    prioridadeAlta    buscar_postagem    api
    Given que a API está disponível
    And eu realizar uma chamada POST com id "5", título "another title", e visualizações 200
    When eu realizar uma chamada GET com o id "5"
    Then o status code da resposta deve ser 200
    And o título da postagem criada deve ser "another title"
    And as visualizações da postagem criada devem ser 200
    And eu realizar uma chamada DELETE com o id da postagem criada

Atualizar Postagem Existente e Verificar Dados
    [Documentation]    Como usuário, quero atualizar uma postagem existente na API e verificar seus dados
    [Tags]    prioridadeAlta    atualizar_postagem    api
    Given que a API está disponível
    And eu realizar uma chamada POST com id "5", título "another title", e visualizações 200
    When eu realizar uma chamada PUT para atualizar a postagem com id "5" com o título "updated title" e visualizações 300
    Then o status code da resposta deve ser 200
    And o título da postagem criada deve ser "updated title"
    And as visualizações da postagem criada devem ser 300
    And eu realizar uma chamada DELETE com o id da postagem criada

Buscar Postagem por ID - Cenário Negativo
    [Documentation]    Como usuário, buscar uma postagem por id (cenário negativo)
    [Tags]    prioridadeMedia    buscar_postagem    api    negative
    Given que a API está disponível
    When eu realizar uma chamada GET com um id inválido
    Then o status code da resposta deve ser 404
    And o corpo da resposta deve conter a mensagem de erro "Not Found"

Buscar Postagem com Parâmetros de Paginação
    [Documentation]    Como usuário, buscar uma postagem utilizando parâmetros de paginação
    [Tags]    prioridadeAlta    buscar_postagem_per_page    api
    Given que a API está disponível
    And eu realizar uma chamada POST com id "5", título "another title", e visualizações 200
    When eu realizar uma chamada GET com os parâmetros de paginação "page=1&_per_page=5"
    Then o status code da resposta deve ser 200
    And a resposta deve conter "5" elemento
    And eu realizar uma chamada DELETE com o id da postagem criada