*** Settings ***
Resource    ../resources/company_keywords/keywords.robot

*** Test Cases ***
CT5.1.1 - Buscar por um ID cadastrado no sistema 
    [Documentation]    CN01: Validar busca por ID válido no sistema.
    [Tags]    Positivo    Status deve ser 200

    Cria nova empresa teste    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil    Empresa p testess de consulta    09369131010036    test344@test.com    Testee testee Ltda    Antonio Silveira    5571988564178    Servico de informatica    201
    ${id_empresa}=     Get Environment Variable    COMPANY_ID

    Buscar Empresa Por ID    ${id_empresa}    200

    Excluir ID da empresa teste

CT5.2.1 - Buscar por um ID não existente no sistema
    [Documentation]    CN02: Validar busca por ID inválido no sistema.
    [Tags]    Negativo    Status deve ser 400

     Buscar Empresa Por ID    6570d8fcc41ee4129739855b    400

CT5.2.2 - Buscar por um ID vazio ou nulo
    [Documentation]    CN02: Validar busca por ID inválido no sistema.
    [Tags]    Negativo    Status deve ser 500
    
    Buscar Empresa Por ID    " "    500