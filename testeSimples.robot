*** Settings ***
Documentation    Exemplo de teste de API GET usando uma URL base.
Library          RequestsLibrary
Library          Collections

*** Variables ***
# Definimos a URL base aqui para fácil manutenção
${BASE_URL}      https://jsonplaceholder.typicode.com

*** Test Cases ***
Validar Busca de Post com Sucesso
    [Documentation]    Cria sessão com a BASE_URL e valida o endpoint /posts/1.
    
    # 1. Cria a sessão associada à URL base
    Create Session    alias=meu_projeto    url=${BASE_URL}    verify=True

    # 2. Faz a requisição GET no endpoint específico
    ${response}=    GET On Session    alias=meu_projeto    url=/posts/1

    # 3. Validações (Assertions)
    Status Should Be    200    ${response}
    
    # Valida campos do JSON de resposta
    Should Be Equal As Numbers    ${response.json()}[id]    1
    Dictionary Should Contain Key    ${response.json()}    title
    
    Log To Console    \nStatus da Resposta: ${response.status_code}
    Log To Console    Corpo da Resposta: ${response.json()}
