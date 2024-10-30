*** Settings ***
Documentation       Keywords para o PATH /Company
Resource            ../resource.robot
Resource            ../funcoes_gerais.robot
Library             ../generator.py
Library             OperatingSystem
Library             RequestsLibrary
Library             Collections

*** Keywords ***

# CN1: Validação de cadastro com sucesso
1.1.1 - Novo cadastro de empresa com sucesso
    ${registerCompany}=    Cria nova empresa teste  # Captura o CNPJ gerado
    
    # Verifica se o CNPJ contém um verificador válido
    ${is_valid}=    Validate Cnpj    ${registerCompany}
    Run Keyword If    not ${is_valid}    Fail    CNPJ inválido: ${registerCompany}

# CN2: Validação de campos obrigatórios
1.2.1 - Cadastro de empresa com campos vazios
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=
    ...     city=
    ...     state=
    ...     district=
    ...     street=
    ...     number=
    ...     complement=
    ...     country=

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=
    ...     registerCompany=
    ...     mail=
    ...     matriz=
    ...     responsibleContact=
    ...     telephone=
    ...     serviceDescription=

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

    log     ${resposta}

# CN3: Validações do campo 'Nome da empresa'
1.3.1 - corporateName incluindo caracteres especiais 
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=Te$t t#est,nd@
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

   log     ${resposta} 

1.3.2 - corporateName com mais de 100 caracteres
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=EmpresaBrasileiraDeTecnologiaInovacaoDesenvolvimentoESolucoesParaNegociosComercioIndustriaServicosLtdaME
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta}    

1.3.3 - corporateName com duplicidade no sistema   
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=Future Enterprises Corp
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta}
    
# CN4: Validações do campo 'CNPJ'
1.4.1 - registerCompany inválido
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=02022961537100      # cnpj inválido 
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta}    

1.4.3 - registerCompany com duplicidade no sistema
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=71081155494988
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta} 

# CN5: Validações do campo 'Razão Social'
1.5.1 - matriz incluindo caracteres especiais
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=*Tech&Soluções93*
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta}    

1.5.2 - matriz com duplicidade no sistema
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=Organização Beta Ltda
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta}
    
1.5.3 - matriz com mais de 100 caracteres
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=MatrizEmpresaTeste123456789MatrizEmpresaTeste123456789MatrizEmpresaTeste123456789MatrizEmpresaTeste123456789
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta}

# CN6: Validações do campo 'Contato Responsável'
1.6.1 - responsibleContact incluindo números
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=4nt0n1o S1lv71ra
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta}

1.6.2 - responsibleContact incluindo caracteres especiais
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=@nt°n!o S,lv%#ra
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta}
1.6.3 - responsibleContact com mais de 100 caracteres
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=AntonioCarlosdaSilva PereiraFernandesAlbuquerqueSouzaMoraesLimaGomesSantanaCostaRodriguesNascimentoOliveiraSilveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta}

1.6.4 - responsibleContact sem palavra composta
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=AntonioCarlosdaSilvaPereiraFernandesAlbuquerqueSouzaMoraesLimaGomesSantanaCostaRodriguesNascimentoOliveiraSilveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
    log     ${resposta}

# CN7: Validações do campo 'Telefone'
1.7.1 - telephone incluindo letras
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988528ABC
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.7.2 - telephone incluindo caracteres especiais
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564ABC
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.7.3 - telephone fora do formato esperado
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5371988415913
    ...     serviceDescription=Servico de informatica

    ${is_valid}=    is_brazilian_telephone_format    ${dados_empresa['telephone']}
    Run Keyword If    not ${is_valid}    Fail    Telefone fora do formato brasileiro: ${dados_empresa['telephone']}

    Set To Dictionary    ${dados_empresa}    address=${address}
    ${resposta}=    POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

# CN8: Validações do campo 'E-mail'
1.8.1 - mail fora do formato
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=testtest.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

# CN9: Validações do campo 'Descrição'
1.9.1- serviceDescription incluindo caracteres especiais
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Avenida Interlagos
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=$&rv!c% de inform@t&c@

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

# CN10: Validações do campo 'Logradouro'
1.10.1 - street incluindo carac. especiais diferentes de 'ª', 'º', '‘' e '-'.
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Aven!d@ Int&rlag*s
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.10.2 - street inclindo mais de 50 caracteres
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Rua das Palmeiras Centenárias e dos Ipês Florescendo Sempre
    ...     number=50
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

# CN11: Validações do campo 'Número'
1.11.1 - number incluindo letras
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Rua das Palmeiras 
    ...     number=5A0
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.11.2 - number incluindo caracteres especiais
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Rua das Palmeiras 
    ...     number=5%$&*
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.11.3 - number incluindo mais de 10 caracteres
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Rua das Palmeiras 
    ...     number=123456789101112
    ...     complement=de 4503 ao fim - lado ímpar
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

# CN12: Validações do campo 'Complemento'
1.12.1 - complement incluindo carac. especiais diferentes de 'ª', 'º', '‘' e '-'.
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Sala 23 @ Ed. Central * 
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.12.2 - complement incluindo mais de 80 caracteres
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305; Prédio Green Space, ao lado do Shopping Plaza, frente para Av. Central
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

# CN13: Validações do campo 'Bairro'
1.13.1 - district incluindo carac. especiais diferentes de 'ª', 'º', '‘' e '-'.
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Sé$&*@#
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.13.2 - district incluindo mais de 50 caracteres
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Jardim das Flores e Palmeiras, Residencial Nova Esperança, Bloco B
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

# CN14: Validações do campo 'Cidade'
1.14.1 - city incluindo números
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São01 Paulo85
    ...     state=SP
    ...     district=Jardim das Flores
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.14.2 - city incluindo caracteres especiais
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=S@o Pau#$lo
    ...     state=SP
    ...     district=Jardim das Flores e Palmeiras, Residencial Nova Esperança, Bloco B
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.14.3 - city incluindo mais de 50 caracteres
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Pedro do Vale Encantado dos Pinheiros e Palmeiras Leste Sul Sudeste
    ...     state=SP
    ...     district=Jardim das Flores e Palmeiras, Residencial Nova Esperança, Bloco B
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

# CN15: Validações do campo 'Estado'
1.15.1 - state incluindo números 
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=S2
    ...     district=Jardim das Flores
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.15.2 - state incluindo caracteres especiais
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=S#
    ...     district=Jardim das Flores
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400
1.15.3 - state incluindo mais de 2 caracteres
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Pedro
    ...     state=SSBA
    ...     district=Jardim das Flores
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

# CN16: Validações do campo 'País'
1.16.1 - country incluindo numeros
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Jardim das Flores
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil071

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.16.2 - country incluindo caracteres especiais
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Jardim das Flores
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil$%&

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.16.3 - country incluindo mais de 50 caracteres
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04777001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Jardim das Flores
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=jasjaklksckslnklckljcklcsdksdnksncknssbajkcakgbksdwkdjahclhclajhcahhsjlhcldchdjlcdcldc

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

# CN17: Validações do campo 'CEP'
1.17.1 - zipCode incluindo letras
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=0477A001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Jardim das Flores
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.17.2 - zipCode incluindo caracteres especiais
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=04&77001
    ...     city=São Paulo
    ...     state=SP
    ...     district=Jardim das Flores
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400

1.17.3 - zipCode fora do formato
    Login de usuário
        
    ${token}=    Login de usuário
    ${corporateName}=      Generate corporateName
    ${matriz}=             Generate matriz
    ${registerCompany}=    Generate registerCompany
    ${address}=           Create List
    ${endereco}=          Create Dictionary
    ...     zipCode=047770
    ...     city=São Paulo
    ...     state=SP
    ...     district=Jardim das Flores
    ...     street=Rua das Palmeiras 
    ...     number=50
    ...     complement=Bloco C, Apto 305
    ...     country=Brasil

    Append To List        ${address}    ${endereco}

    ${dados_empresa}=      Create Dictionary
    ...     corporateName=${corporateName}
    ...     registerCompany=${registerCompany}
    ...     mail=test@test.com
    ...     matriz=${matriz}
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=400    
