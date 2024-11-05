*** Settings ***
Resource    ../resources/company_keywords/keywords.robot

*** Test Cases ***
Cria empresa para testes de edição de cadastro
    Cria nova empresa teste    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil    Empresa para testes de ediçãoo    09369931680136    teste35@test.com    testessss Ltda    Antonio Silveira    5571988564178    Servico de informatica    201    
CT6.1.1 - Alterar o status da empresa para inativo
    [Documentation]    CN01: Validar atualização do status da empresa de ativo para inativo.
    [Tags]    Positivo    Status deve ser 200  
    
    ${id_empresa}=     Get Environment Variable    COMPANY_ID
    Alterar status da empresa    ${id_empresa}    false    201

CT6.2.1 - Alterar o status da empresa para ativo
    [Documentation]    CN02: Validar atualização do status da empresa de inativo para ativo.
    [Tags]    Positivo    Status deve ser 200

    ${id_empresa}=     Get Environment Variable    COMPANY_ID
    Alterar status da empresa    ${id_empresa}    true    201

CT6.3.1 - Alterar o status de uma empresa com ID inexistente
    [Documentation]    CN03: Atualização do status não aconteceu.
    [Tags]    Negativo   Status deve ser 400

    ${token}=         Login de usuário
    ${body}=          Create Dictionary    status=true
    ${resposta}=      PUT On Session   alias=develop   url=company/status/6570d8fcc41ee4129739855c?token=${token}    json=${body}    expected_status=400

    ${response_json}=  Convert To Dictionary    ${resposta.json()}
    Should Be Equal As Strings    ${response_json['msg']}    Essa companhia não existem em nossa base de dados.
  
Exclui empresa para testes de status    
    Excluir ID da empresa teste
