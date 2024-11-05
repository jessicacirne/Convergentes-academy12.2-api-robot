*** Settings ***
Resource    ../resources/company_keywords/keywords.robot

*** Test Cases ***
 CT7.1.1 - Excluir cadastro de empresa com sucesso
    [Documentation]    CN01: Validar exclusão de cadastro de empresa com sucesso.
    [Tags]    Positivo    Status deve ser 200

    Cria nova empresa teste    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil    Empresa p testess de consulta    09369131010036    test344@test.com    Testee testee Ltda    Antonio Silveira    5571988564178    Servico de informatica    201
    ${id_empresa}=     Get Environment Variable    COMPANY_ID

    Excluir ID da empresa teste
    Buscar Empresa Por ID    ${id_empresa}    400 
    
CT7.2.1 - Excluir cadastro de empresa inexistente
    [Documentation]    CN02: Validar exclusão de cadastro de empresa não realizada.
    [Tags]    Negativo    Status deve ser 400

    ${token}=           Login de usuário    
    ${resposta}=        DELETE On Session   alias=develop   url=company/672813d8921ac3975fdfdc0e/?token=${token}    expected_status=404

    
