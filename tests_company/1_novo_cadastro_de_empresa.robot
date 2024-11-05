*** Settings ***
Resource    ../resources/company_keywords/keywords.robot
Library     ../resources/generator.py

*** Variables ***

*** Test Cases ***
1.1.1 - Novo cadastro de empresa com sucesso
    [Documentation]    CN01: Validação de cadastro com sucesso
    [Tags]    Positivo    Status deve ser 201

    Cria nova empresa teste    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil    Empresa p testes cadastro    09111111680136    testestests305@test.com    tests tests tests Ltda    Antonio Silveira    5571988564178    Servico de informatica    201
    Excluir ID da empresa teste

1.2.1 - Cadastro de empresa com campos vazios
    [Documentation]    CN2: Validação de campos obrigatórios
    [Tags]    Negativo    Status deve ser 400
    
    Cria nova empresa teste (Validação negativa)    ""    ""    ""    ""    ""    ""    ""    ""    ""    ""    ""    ""    ""    ""    ""    400   
     
1.3.1 - corporateName incluindo caracteres especiais 
    [Documentation]    CN3: Validações do campo 'Nome da empresa'
    [Tags]    Negativo    Status deve ser 400

    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil   Te$t empr&s@ com car*cter,es  ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     Antonio Silveira    5571988564178    Servico de informatica    400
  
1.3.2 - corporateName com mais de 100 caracteres
    [Documentation]    CN3: Validações do campo 'Nome da empresa'
    [Tags]    Negativo    Status deve ser 400

    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil   Inconstitucionalissimamenteincontroversialmenteextraordinariamentefantasmagoricamenteultrapoderosamentecomplexa  ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     Antonio Silveira    5571988564178    Servico de informatica    400

1.3.3 - corporateName com duplicidade no sistema
    [Documentation]    CN3: Validações do campo 'Nome da empresa'
    [Tags]    Negativo    Status deve ser 400

    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     Teste Company Blacklist 960741    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     Antonio Silveira    5571988564178    Servico de informatica    400

1.4.1 - registerCompany inválido
    [Documentation]    CN4: Validações do campo 'CNPJ'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    6661101100011    testesxpoxp@test.com    ${matrizGerada}     Antonio Silveira    5571988564178    Servico de informatica    400
  
1.4.3 - registerCompany com duplicidade no sistema
    [Documentation]    CN4: Validações do campo 'CNPJ'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
  
    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    71081155494988    testesxpoxp@test.com    ${matrizGerada}     Antonio Silveira    5571988564178    Servico de informatica    400

1.5.1 - matriz incluindo caracteres especiais
    [Documentation]    CN5: Validações do campo 'Razão Social'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    Empresa #,$%to LTD@     Antonio Silveira    5571988564178    Servico de informatica    400
1.5.2 - matriz com duplicidade no sistema
    [Documentation]    CN5: Validações do campo 'Razão Social'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    Teste Matriz Blacklist     Antonio Silveira    5571988564178    Servico de informatica    400

1.5.3 - matriz com mais de 100 caracteres
    [Documentation]    CN5: Validações do campo 'Razão Social'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    Inconstitucionalissimamenteincontroversialmenteextraordinariamentefantasmagoricamenteultrapoderosamentecomplexa     Antonio Silveira    5571988564178    Servico de informatica    400

1.6.1 - responsibleContact incluindo números
    [Documentation]    CN6: Validações do campo 'Contato Responsável
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     478963214 Silveira    5571988564178    Servico de informatica    400

1.6.2 - responsibleContact incluindo caracteres especiais
    [Documentation]    CN6: Validações do campo 'Contato Responsável
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     @&*,$! Silveira    5571988564178    Servico de informatica    400

1.6.3 - responsibleContact com mais de 100 caracteres
    [Documentation]    CN6: Validações do campo 'Contato Responsável
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     Inconstitucionalissimamenteincontroversialmente Extraordinariamentefantasmagoricamenteultrapoderosamentecomplexa    5571988564178    Servico de informatica    400
1.6.4 - responsibleContact sem palavra composta
    [Documentation]    CN6: Validações do campo 'Contato Responsável
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany 

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     Silveira    5571988564178    Servico de informatica    400   

1.7.1 - telephone incluindo letras
    [Documentation]    CN7: Validações do campo 'Telefone'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     Paulo Silveira    5571988564A78    Servico de informatica    400

1.7.2 - telephone incluindo caracteres especiais
    [Documentation]    CN7: Validações do campo 'Telefone'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     Paulo Silveira    5571988564@78    Servico de informatica    400

1.7.3 - telephone fora do formato esperado 
    [Documentation]    CN7: Validações do campo 'Telefone'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany   

        Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     Paulo Silveira    3171988564178    Servico de informatica    400 

1.8.1 - mail fora do formato
    [Documentation]    CN8: Validações do campo 'E-mail'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxptest.com    ${matrizGerada}     Paulo Silveira    5571988564178    Servico de informatica    400

1.9.1- serviceDescription incluindo caracteres especiais
    [Documentation]    CN9: Validações do campo 'Descrição'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany  

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida Interlagos    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     Paulo Silveira    5571988564178    Servico $%&@#!,    400  

1.10.1 - street incluindo carac. especiais diferentes de 'ª', 'º', '‘' e '-'.
    [Documentation]    CN10: Validações do campo 'Logradouro'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida &@#$    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400

1.10.2 - street inclindo mais de 50 caracteres
    [Documentation]    CN10: Validações do campo 'Logradouro'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany   

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Avenida dos Pioneiros da Independência e da Liberdade do Sul    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400 

1.11.1 - number incluindo letras
    [Documentation]    CN11: Validações do campo 'Número'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Rua Macaúbas    5a    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400

1.11.2 - number incluindo caracteres especiais
    [Documentation]    CN11: Validações do campo 'Número'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Rua Macaúbas    5$    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400
1.11.3 - number incluindo mais de 10 caracteres
    [Documentation]    CN11: Validações do campo 'Número'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Rua Macaúbas    589631475910    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400    

1.12.1 - complement incluindo carac. especiais diferentes de 'ª', 'º', '‘' e '-'.
    [Documentation]    CN12: Validações do campo 'Complemento'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany  

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Rua Macaúbas    50    Edficio Flores101$%&@    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400      

1.12.2 - complement incluindo mais de 80 caracteres
    [Documentation]    CN12: Validações do campo 'Complemento'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany   

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Rua Macaúbas    5a    sbjfjdsfdsnvdvlsfjirtirscmxmxjkjrfsbjfjdsfdsnvdvlsfjirtirscmxmxjkjrfjkjrfsbjfjdsfdsnvdvlsfjirtirscmxmxjkjrf   Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400     


1.13.1 - district incluindo carac. especiais diferentes de 'ª', 'º', '‘' e '-'.
    [Documentation]    CN13: Validações do campo 'Bairro'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé#$%&@    Rua Macaúbas    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400    

1.13.2 - district incluindo mais de 50 caracteres
    [Documentation]    CN13: Validações do campo 'Bairro'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    sbjfjdsfdsnvdvlsfjirtirscmxmxjkjrfsbjfjdsfdsnvdvlsfjirtirscm    Rua Macaúbas    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400        

1.14.1 - city incluindo números
    [Documentation]    CN14: Validações do campo 'Cidade'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany   

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo9856    SP    Sé    Rua Macaúbas    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400    


1.14.2 - city incluindo caracteres especiais
    [Documentation]    CN14: Validações do campo 'Cidade'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo$%&#@    SP    Sé    Rua Macaúbas    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400    


1.14.3 - city incluindo mais de 50 caracteres
    [Documentation]    CN14: Validações do campo 'Cidade'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany

    Cria nova empresa teste (Validação negativa)    04777001    sbjfjdsfdsnvdvlsfjirtirscmxmxjkjrfsbjfjdsfdsnvdvlsfjirtirscm    SP    Sé    Rua Macaúbas    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400    

1.15.1 - state incluindo números 
    [Documentation]    CN15: Validações do campo 'Estado'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP98    Sé    Rua Macaúbas    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400    


1.15.2 - state incluindo caracteres especiais
    [Documentation]    CN15: Validações do campo 'Estado'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP@    Sé    Rua Macaúbas    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400    


1.15.3 - state incluindo mais de 2 caracteres
    [Documentation]    CN15: Validações do campo 'Estado'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany   

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SPSP    Sé    Rua Macaúbas    50    Edficio Flores apt 101    Brasil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400    


1.16.1 - country incluindo numeros
    [Documentation]    CN16: Validações do campo 'País'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Rua Macaúbas    50    Edficio Flores apt 101    Bra00sil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400        

1.16.2 - country incluindo caracteres especiais
    [Documentation]    CN16: Validações do campo 'País'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP   Sé    Rua Macaúbas    50    Edficio Flores apt 101    Br@sil     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400        

1.16.3 - country incluindo mais de 50 caracteres
    [Documentation]    CN16: Validações do campo 'País'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany

    Cria nova empresa teste (Validação negativa)    04777001    São Paulo    SP    Sé    Rua Macaúbas    50    Edficio Flores apt 101    sbjfjdsfdsnvdvlsfjirtirscmxmxjkjrfsbjfjdsfdsnvdvlsfjirtirscm     ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400            

1.17.1 - zipCode incluindo letras
    [Documentation]   CN17: Validações do campo 'CEP'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    047770ABC01    São Paulo    SP    Sé    Rua Macaúbas    50    Edficio Flores apt 101    Brasil    ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400            


1.17.2 - zipCode incluindo caracteres especiais
    [Documentation]   CN17: Validações do campo 'CEP'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    047770%&@01    São Paulo    SP    Sé    Rua Macaúbas    50    Edficio Flores apt 101    Brasil    ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400            


1.17.3 - zipCode fora do formato    
    [Documentation]   CN17: Validações do campo 'CEP'
    [Tags]    Negativo    Status deve ser 400

    ${corporateNameGerado}      Generate corporateName
    ${matrizGerada}             Generate matriz
    ${registerCompanyGerado}    Generate registerCompany    

    Cria nova empresa teste (Validação negativa)    04701    São Paulo    SP    Sé    Rua Macaúbas    50    Edficio Flores apt 101    Brasil    ${corporateNameGerado}    ${registerCompanyGerado}    testesxpoxp@test.com    ${matrizGerada}     João Silveira    5571988564178    Servico de informatica    400            
