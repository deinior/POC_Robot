*** Settings ***
Resource    ../resources/comments.resource
Resource    ../resources/ajuda.resource

*** Variables ***
${BASE_URL}    http://localhost:3000

*** Test Cases ***

Get comentários
    [Documentation]    Como usuário, quero recuperar comentários da API
    Given que a API está disponível
    When quando eu realizar uma chamada na rota GET
    Then o status code da resposta deve ser 200
    And o numero de comentários deve ser 2
    And o id do primeiro comentário deve ser "1"
    And o texto do primeiro comentário deve ser "a comment about post 1"
    And o postId do primeiro comentário deve ser "1"



