*** Settings ***
Resource    ../resources/user_keyword/user_keywords.robot
Library     ../resources/generator.py

*** Test Cases ***
CT1.1.1 - Cadastro de usuário com sucesso
    [Documentation]    CN1: Validar novo cadastro com sucesso
    [Tags]    Validação Positiva    Status deve ser 201

    ${fullNameGerado}    Generate fullName
    ${emailGerado}      Generate email
    ${cpfGerado}         Generate cpf 

    Cria novo usuário    ${fullNameGerado}    ${emailGerado}    1234@Test    ADMIN    ${cpfGerado}    1234@Test    201
    Excluir ID do usuário Teste
CT1.2.1: Cadastro com campos vazios
    [Documentation]    CN2: Validações de campos obrigatórios
    [Tags]    Validação negativa    Status deve ser 400

    Cria novo usuário (Validação negativa)    ""    ""    ""    ""    ""    ""    400

CT1.3.1: FullName com mais de 100 caracteres
    [Documentation]    CN3: Validações do campo 'Nome Completo'
    [Tags]    Validação negativa    Status deve ser 400    

    ${emailGerado}      Generate email
    ${cpfGerado}        Generate cpf    

    Cria novo usuário (Validação negativa)    Alexanderson Maximiliano de Albuquerque Pereira da Silva Costa e Souza Oliveira dos Santos Monteiro Neto    ${emailGerado}    1234@Test    ADMIN    ${cpfGerado}    1234@Test   400

CT1.3.2: FullName incluindo números
    [Documentation]    CN3: Validações do campo 'Nome Completo'
    [Tags]    Validação negativa    Status deve ser 400    

    ${emailGerado}      Generate email
    ${cpfGerado}        Generate cpf  

    Cria novo usuário (Validação negativa)    Teste Testando7    ${emailGerado}    1234@Test    ADMIN    ${cpfGerado}    1234@Test   400

CT1.3.3: FullName incluindo caracteres especiais    
    [Documentation]    CN3: Validações do campo 'Nome Completo'
    [Tags]    Validação negativa    Status deve ser 400  

    ${emailGerado}      Generate email
    ${cpfGerado}        Generate cpf 

    Cria novo usuário (Validação negativa)    Teste Testando@    ${emailGerado}    1234@Test    ADMIN    ${cpfGerado}    1234@Test   400

CT1.3.4: FullName sem palavra composta  
    [Documentation]    CN3: Validações do campo 'Nome Completo'
    [Tags]    Validação negativa    Status deve ser 400  

    ${emailGerado}      Generate email
    ${cpfGerado}        Generate cpf   

    Cria novo usuário (Validação negativa)    Teste    ${emailGerado}    1234@Test    ADMIN    ${cpfGerado}    1234@Test   400

CT1.4.1: Mail fora do formato
    [Documentation]    CN4: Validações do campo 'E-mail'
    [Tags]    Validação negativa    Status deve ser 400  

    ${fullNameGerado}    Generate fullName
    ${cpfGerado}         Generate cpf  

    Cria novo usuário (Validação negativa)    ${fullNameGerado}    testando.com.br    1234@Test    ADMIN    ${cpfGerado}    1234@Test   400

CT1.5.1: Password com menos de 8 ou mais de 12 caracteres
    [Documentation]    CN5: Validações do campo 'Senha'
    [Tags]    Validação negativa    Status deve ser 400 

    ${fullNameGerado}    Generate fullName
    ${emailGerado}      Generate email
    ${cpfGerado}         Generate cpf 

    Cria novo usuário (Validação negativa)    ${fullNameGerado}    ${emailGerado}    12@Test    ADMIN    ${cpfGerado}    12@Test   400

*** Comments ***
CT1.5.2: Password sem incluir letra maiúscula
    [Documentation]    CN5: Validações do campo 'Senha'
    [Tags]    Validação negativa    Status deve ser 400 

    ${fullNameGerado}    Generate fullName
    ${emailGerado}      Generate email
    ${cpfGerado}         Generate cpf 

    Cria novo usuário (Validação negativa)    ${fullNameGerado}    ${emailGerado}    1234@test    ADMIN    ${cpfGerado}    1234@test   400   

CT1.5.3: Password sem incluir letra minúscula
    [Documentation]    CN5: Validações do campo 'Senha'
    [Tags]    Validação negativa    Status deve ser 400 

    ${fullNameGerado}    Generate fullName
    ${emailGerado}      Generate email
    ${cpfGerado}         Generate cpf 

    Cria novo usuário (Validação negativa)    ${fullNameGerado}    ${emailGerado}    1234@TEST    ADMIN    ${cpfGerado}    1234@TEST   400     
*** Test Cases ***
 
 CT1.5.4: Password sem incluir números
    [Documentation]    CN5: Validações do campo 'Senha'
    [Tags]    Validação negativa    Status deve ser 400 

    ${fullNameGerado}    Generate fullName
    ${emailGerado}      Generate email
    ${cpfGerado}         Generate cpf 

    Cria novo usuário (Validação negativa)    ${fullNameGerado}    ${emailGerado}    12345Test    ADMIN    ${cpfGerado}    12345Test   400

 CT1.6.1: ConfirmPassword diferente de Password   
    [Documentation]    CN6:  Validações do campo 'Confirmar senha'
    [Tags]    Validação negativa    Status deve ser 400 

    ${fullNameGerado}    Generate fullName
    ${emailGerado}      Generate email
    ${cpfGerado}         Generate cpf 

    Cria novo usuário (Validação negativa)    ${fullNameGerado}    ${emailGerado}    1234@Test    ADMIN    ${cpfGerado}    1234@Tes   400                               