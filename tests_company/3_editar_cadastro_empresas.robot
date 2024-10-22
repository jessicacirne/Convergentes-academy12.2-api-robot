*** Settings ***
Resource    ../resources/company_keywords/editar_cadastro_empresas.robot

*** Test Cases ***
Auth
    Login de usuário

CN1: Cadastro de empresa editado com sucesso (Validação positiva) 
    CT3.1.1 - Todos os Campos de Forma Válida

CN2: Campos vazios (Validação negativa)
    CT3.2.1 - Todos os Campos Vazios

CN3: Duplicidade (Validação negativa)
    [Tags]    robot:continue-on-failure
    CT3.3.1 - 'Nome da Empresa' Utilizando Nome Já Cadastrado 
    CT3.3.2 - 'CNPJ' Utilizando CNPJ Já Cadastrado
    CT3.3.3 - 'Razão Social' Utilizando Razão Social Já Cadastrada

CN4: Limite de caracteres (Validação negativa)
    CT3.4.1 - 'Nome da Empresa' Utilizando Mais de 100 Caracteres  
    CT3.4.2 - 'Contato responsável' Utilizando Mais de 100 Caracteres

CN5: Restrição de máscara (Validação negativa)
    CT3.5.1 - 'CNPJ' com mais de 14 números
    CT3.5.2 - 'CNPJ' com menos de 14 números
    CT3.5.3 - 'Telefone' menos de 13 números
    CT3.5.4 - 'Telefone' mais de 14 números

CN6: Restrição de formato (Validação negativa)
    [Tags]    robot:continue-on-failure
    CT3.6.1 - 'Nome da Empresa' incluindo caracteres especiais  
    CT3.6.2 - 'CNPJ' incluindo letras 
    CT3.6.3 - 'CNPJ' incluindo caracteres especiais
    CT3.6.4 - 'Razão Social' incluindo caracteres especiais
    CT3.6.5 - 'Contato Responsável' incluindo caracteres especiais
    CT3.6.6 - 'Contato Responsável' incluindo números    
    CT3.6.7 - 'Contato Responsável' com uma palavra 
    CT3.6.8 - 'Telefone' sem DDD do Brasil  
    CT3.6.9 - 'Telefone' incluindo letras  
    CT3.6.10 - 'Telefone' incluindo caracteres especiais  
    CT3.6.11 - 'E-mail' fora do formato   
    CT3.6.12 - 'Descrição' incluindo caracteres especiais


