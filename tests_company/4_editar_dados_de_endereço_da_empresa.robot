*** Settings ***
Resource    ../resources/company_keywords/editar_endereço_empresas.robot

*** Test Cases ***

Login de usuário
    Login de usuário

CN1: Edição de dados de endereço da empresa com sucesso (Validação positiva)
    CT4.1.1 - Todos os Campos de Forma Válida

CN2: Campos vazios (Validação negativa)
    CT4.2.1 - Todos os Campos Vazios

CN3: Limite de caracteres (Validação negativa)
    [Tags]    robot:continue-on-failure
    CT4.3.1 - 'Logradouro' Utilizando Mais de 50 Caracteres
    CT4.3.2 - 'Número' Utilizando Mais de 10 Caracteres
    CT4.3.3 - 'Complemento' Utilizando Mais de 80 Caracteres
    CT4.3.4 - 'Bairro' Utilizando Mais de 50 Caracteres
    CT4.3.5 - 'Cidade' Utilizando Mais de 50 Caracteres
    CT4.3.6 - 'Estado' Utilizando Mais de 2 Caracteres
    CT4.3.7 - 'País' Utilizando Mais de 50 Caracteres
    
CN4: Restrição de máscara (Validação negativa)
    CT4.4.1 - 'CEP' Utilizando Mais de 8 Caracteres
    CT4.4.2 - 'CEP' Utilizando Menos de 8 Caracteres

CN5: Restrição de formato (Validação negativa)
    [Tags]    robot:continue-on-failure
    CT4.5.1 - 'Lougradouro' Incluindo Caracteres Especiais Não Permitidos
    CT4.5.2 - 'Número' Incluindo Caracteres Especiais
    CT4.5.3 - 'Número' Incluindo Letras
    CT4.5.4 - 'Complemento' Incluindo Caracteres Especiais Não Permitidos
    CT4.5.5 - 'Bairro' Incluindo Caracteres Especiais Não Permitidos
    CT4.5.6 - 'Cidade' Incluindo Caracteres Especiais Não Permitidos
    CT4.5.7 - 'Cidade' Incluindo Números
    CT4.5.8 - 'Estado' Incluindo Caracteres Especiais
    CT4.5.9 - 'Estado' Incluindo Números
    CT4.5.10 - 'País' Incluindo Caracteres Especiais
    CT4.5.11 - 'País' incluindo números
    CT4.5.12 - 'CEP' incluindo caracteres especiais
    CT4.5.13 - 'CEP' incluindo letras