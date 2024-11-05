*** Settings ***
Resource    ../resources/company_keywords/keywords.robot

*** Test Cases ***
Cria empresa para testes de edição de cadastro
    Cria nova empresa teste    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil    Empresa para testes de ediçãoo    09369931680136    teste35@test.com    testessss Ltda    Antonio Silveira    5571988564178    Servico de informatica    201

CT3.1.1 - Todos os Campos de Forma Válida    
    [Documentation]    CN01: Validar edição de todos os campos com dados válidos
    [Tags]    Positivo    Status deve ser 200

    Edição de cadastro de empresa    Novo nome empresa    12345678017210    testes10@test.com    nova matriz    Testando contato responsavel   5511912345678    Decrição da empresa    200

CT3.2.1 - Todos os Campos Vazios
    [Documentation]    CN02: Validação edição com todos os campos vazios.
    [Tags]    Negativo    Status deve ser 400   

    Edição de cadastro de empresa    ""    ""    ""    ""    ""    ""    ""    400

CT3.3.1 - 'Nome da Empresa' Utilizando Nome Já Cadastrado  
    [Documentation]    CN03: Validação edição com restrição de campos duplicados.
    [Tags]    Negativo    Status deve ser 400

    Edição de cadastro de empresa    Teste Company Blacklist 572884    12345678017210    testes10@test.com    nova matriz    Testando contato responsavel    5511912345678    Decrição da empresa    400

CT3.3.2 - 'CNPJ' Utilizando CNPJ Já Cadastrado    
    [Documentation]    CN03: Validação edição com restrição de campos duplicados.
    [Tags]    Negativo    Status deve ser 400

    Edição de cadastro de empresa    Nome da empresa teste    83239359000143    test@test.com    Teste testando matriz    Teste Test    5511912345678    Decrição da empresa    400

CT3.3.3 - 'Razão Social' Utilizando Razão Social Já Cadastrada  
    [Documentation]    CN03: Validação edição com restrição de campos duplicados.
    [Tags]    Negativo    Status deve ser 400

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    Teste testando matriz    Teste Test    5511912345678    Decrição da empresa    400

CT3.4.1 - 'Nome da Empresa' Utilizando Mais de 100 Caracteres 
    [Documentation]    CN04: Validação edição com restrição de límite de caracteres.
    [Tags]    Negativo    Status deve ser 400

    Edição de cadastro de empresa    Maria Alessandra Gonçalves da Silva Pereira dos Santos Oliveira Albuquerque de Souza Ferreira Costa Lima Dias    12345678000195    test@test.com    Teste testando matriz    Teste Test    5511912345678    Decrição da empresa    400

CT3.4.2 - 'Contato responsável' Utilizando Mais de 100 Caracteres
    [Documentation]    CN04: Validação edição com restrição de límite de caracteres.
    [Tags]    Negativo    Status deve ser 400

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    Teste testando matriz    Maria Alessandra Gonçalves da Silva Pereira dos Santos Oliveira Albuquerque de Souza Ferreira Costa Lima Dias    5511912345678    Decrição da empresa    400

CT3.5.1 - 'CNPJ' com mais de 14 números    
    [Documentation]    CN05: Validação edição restrição com máscara.
    [Tags]    Negativo    Status deve ser 400

    Edição de cadastro de empresa    Nome da empresa teste    043534400001838    test@test.com    Teste testando matriz    Teste Test    5511912345678    Decrição da empresa    400

CT3.5.2 - 'CNPJ' com menos de 14 números  
    [Documentation]    CN05: Validação edição restrição com máscara.
    [Tags]    Negativo    Status deve ser 400

    Edição de cadastro de empresa    Nome da empresa teste    0435344000018    test@test.com    Teste testando matriz    Teste Test    5511912345678    Decrição da empresa    400

CT3.5.3 - 'Telefone' menos de 13 números    
    [Documentation]    CN05: Validação edição restrição com máscara.
    [Tags]    Negativo    Status deve ser 400

    Edição de cadastro de empresa    Nome da empresa teste    0435344000018    test@test.com    Teste testando matriz    Teste Test    55119123456    Servico de informatica    400

CT3.5.4 - 'Telefone' mais de 14 números 
    [Documentation]    CN05: Validação edição restrição com máscara.
    [Tags]    Negativo    Status deve ser 400

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    Teste testando matriz    Teste Test    551191234567855    Servico de informatica    400

CT3.6.1 - 'Nome da Empresa' incluindo caracteres especiais
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400    

    Edição de cadastro de empresa    Silv&ir@ El.tro,i%cos    12345678000195    test@test.com    Teste testando matriz    Teste Test    5511912345678    Servico de informatica    400

CT3.6.2 - 'CNPJ' incluindo letras  
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  

    Edição de cadastro de empresa    Nome da empresa teste    12H45G7800F195    test@test.com    Teste testando matriz    Teste Test    5511912345678    Servico de informatica    400

CT3.6.3 - 'CNPJ' incluindo caracteres especiais   
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  

    Edição de cadastro de empresa    Nome da empresa teste    1$345&7800%195    test@test.com    Teste testando matriz    Teste Test    5511912345678    Servico de informatica    400

CT3.6.4 - 'Razão Social' incluindo caracteres especiais   
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    S*lve!r$ inf#rm@tica Co    Teste Test    5511912345678    Servico de informatica    400

CT3.6.5 - 'Contato Responsável' incluindo caracteres especiais 
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    Teste testando matriz    @nt*n&o C&@#!    5511912345678    Servico de informatica    400

CT3.6.6 - 'Contato Responsável' incluindo números
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    Teste testando matriz    4nt0n10 C4rl9s    5511912345678    Servico de informatica    400

CT3.6.7 - 'Contato Responsável' com uma palavra
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    Teste testando matriz    Antonio    5511912345678    Servico de informatica    400

CT3.6.8 - 'Telefone' sem DDD do Brasil
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    Teste testando matriz    Teste Test    5111912345678    Servico de informatica    400

CT3.6.9 - 'Telefone' incluindo letras
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    Teste testando matriz    Teste Test    557198b56a178    Servico de informatica    400

CT3.6.10 - 'Telefone' incluindo caracteres especiais
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    Teste testando matriz    Teste Test    627198&56*178    Servico de informatica    400

CT3.6.11 - 'E-mail' fora do formato
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  

    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    testtest.com    Teste testando matriz    Teste Test    5511912345678    Servico de informatica    400

CT3.6.12 - 'Descrição' incluindo caracteres especiais 
    [Documentation]    CN05: Validação edição com restrição de formato.
    [Tags]    Negativo    Status deve ser 400  
      
    Edição de cadastro de empresa    Nome da empresa teste    12345678000195    test@test.com    Teste testando matriz    Teste Test    5511912345678    *&%@#    400

Exclui empresa para testes de edição de cadastro    
    Excluir ID da empresa teste
