*** Settings ***
Resource    ../resources/company_keywords/novo_cadastro_empresa.robot

*** Test Cases ***
CN1: Validação de cadastro com sucesso
    1.1.1 - Novo cadastro de empresa com sucesso

CN2: Validação de campos obrigatórios
    1.2.1 - Cadastro de empresa com campos vazios
    
CN3: Validações do campo 'Nome da empresa'
    [Tags]    robot:recursive-continue-on-failure
    1.3.1 - corporateName incluindo caracteres especiais 
    1.3.2 - corporateName com mais de 100 caracteres
    1.3.3 - corporateName com duplicidade no sistema

CN4: Validações do campo 'CNPJ'
    [Tags]    robot:recursive-continue-on-failure
    1.4.1 - registerCompany inválido
    1.4.3 - registerCompany com duplicidade no sistema

CN5: Validações do campo 'Razão Social'
    [Tags]    robot:recursive-continue-on-failure
    1.5.1 - matriz incluindo caracteres especiais
    1.5.2 - matriz com duplicidade no sistema
    1.5.3 - matriz com mais de 100 caracteres

CN6: Validações do campo 'Contato Responsável
    [Tags]    robot:recursive-continue-on-failure
    1.6.1 - responsibleContact incluindo números
    1.6.2 - responsibleContact incluindo caracteres especiais
    1.6.3 - responsibleContact com mais de 100 caracteres
    1.6.4 - responsibleContact sem palavra composta

CN7: Validações do campo 'Telefone'
    [Tags]    robot:recursive-continue-on-failure
    1.7.1 - telephone incluindo letras
    1.7.2 - telephone incluindo caracteres especiais
    1.7.3 - telephone fora do formato esperado 

CN8: Validações do campo 'E-mail'
    1.8.1 - mail fora do formato

CN9: Validações do campo 'Descrição'
    1.9.1- serviceDescription incluindo caracteres especiais

CN10: Validações do campo 'Logradouro'
    [Tags]    robot:recursive-continue-on-failure
    1.10.1 - street incluindo carac. especiais diferentes de 'ª', 'º', '‘' e '-'.
    1.10.2 - street inclindo mais de 50 caracteres

CN11: Validações do campo 'Número'
    [Tags]    robot:recursive-continue-on-failure
    1.11.1 - number incluindo letras
    1.11.2 - number incluindo caracteres especiais
    1.11.3 - number incluindo mais de 10 caracteres

CN12: Validações do campo 'Complemento'
    [Tags]    robot:recursive-continue-on-failure
    1.12.1 - complement incluindo carac. especiais diferentes de 'ª', 'º', '‘' e '-'.
    1.12.2 - complement incluindo mais de 80 caracteres

CN13: Validações do campo 'Bairro'
    [Tags]    robot:recursive-continue-on-failure
    1.13.1 - district incluindo carac. especiais diferentes de 'ª', 'º', '‘' e '-'.
    1.13.2 - district incluindo mais de 50 caracteres

CN14: Validações do campo 'Cidade'
    [Tags]    robot:recursive-continue-on-failure
    1.14.1 - city incluindo números
    1.14.2 - city incluindo caracteres especiais
    1.14.3 - city incluindo mais de 50 caracteres

CN15: Validações do campo 'Estado'
    [Tags]    robot:recursive-continue-on-failure
    1.15.1 - state incluindo números 
    1.15.2 - state incluindo caracteres especiais
    1.15.3 - state incluindo mais de 2 caracteres

CN16: Validações do campo 'País'
    [Tags]    robot:recursive-continue-on-failure
    1.16.1 - country incluindo numeros
    1.16.2 - country incluindo caracteres especiais
    1.16.3 - country incluindo mais de 50 caracteres

CN17: Validações do campo 'CEP'
    [Tags]    robot:recursive-continue-on-failure
    1.17.1 - zipCode incluindo letras
    1.17.2 - zipCode incluindo caracteres especiais
    1.17.3 - zipCode fora do formato    
