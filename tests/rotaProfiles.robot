*** Settings ***
Resource    ../resources/profiles.resource
Resource    ../resources/ajuda.resource

*** Variables ***
${BASE_URL}    http://localhost:3000

*** Test Cases ***

Criar Postagem e Verificar Dados
    [Documentation]    Como usuário, quero criar uma nova postagem na API e verificar seus dados
    Given que a API está disponível
    When eu realizar uma chamada POST com id "4", título "another title", e visualizações 200
    Then o status code da resposta deve ser 201
    And o id da postagem criada deve ser "4"
    And o título da postagem criada deve ser "another title"
    And as visualizações da postagem criada devem ser 200
    And eu realizar uma chamada DELETE com o id da postagem criada

Deletar Postagem
    [Documentation]    Como usuário, quero deletar uma postagem na API
    Given que a API está disponível
    And eu realizar uma chamada POST com id "4", título "another title", e visualizações 200
    When eu realizar uma chamada DELETE com o id "4"
    Then o status code da resposta deve ser 200

Buscar Postagem por ID
    [Documentation]    Como usuário, buscar uma postagem por id
    Given que a API está disponível
    And eu realizar uma chamada POST com id "5", título "another title", e visualizações 200
    When eu realizar uma chamada GET com o id "5"
    Then o status code da resposta deve ser 200
    And o título da postagem criada deve ser "another title"
    And as visualizações da postagem criada devem ser 200
    And eu realizar uma chamada DELETE com o id da postagem criada

Atualizar Postagem Existente e Verificar Dados
    [Documentation]    Como usuário, quero atualizar uma postagem existente na API e verificar seus dados
    Given que a API está disponível
    And eu realizar uma chamada POST com id "5", título "another title", e visualizações 200
    When eu realizar uma chamada PUT para atualizar a postagem com id "5" com o título "updated title" e visualizações 300
    Then o status code da resposta deve ser 200
    And o título da postagem criada deve ser "updated title"
    And as visualizações da postagem criada devem ser 300
    And eu realizar uma chamada DELETE com o id da postagem criada