*** Settings ***
Resource    ../resources/user_keyword/user_keywords.robot

*** Test Cases ***
CT4.1.1: Exclusão de usuário com sucesso
    [Documentation]    CN1: Validar exclusão de cadastro com sucesso
    [Tags]    Validação Positiva    Status deve ser 200

    ${fullNameGerado}    Generate fullName
    ${emailGerado}      Generate email
    ${cpfGerado}         Generate cpf 

    Cria novo usuário    ${fullNameGerado}    ${emailGerado}    1234@Test    ADMIN    ${cpfGerado}    1234@Test    201
    ${id_user}=     Get Environment Variable    USER_ID

    Excluir ID do usuário Teste
    Buscar usuário Por ID    ${id_user}    404

CT4.2.1: Exclusão de usuário inválido    
    [Documentation]    CN2: Validar exclusão de cadastro inválido
    [Tags]    Validação Positiva    Status deve ser 404

    Buscar usuário Por ID    671e5c4ab8d32c9e73587058    404