*** Settings ***
Documentation       Keywords para o PATH /Company
Resource            ../resource.robot
Library             ../generator.py
Library             OperatingSystem
Library             RequestsLibrary
Library             Collections

*** Keywords ***
Criar Sessao
    ${headers}=    Create Dictionary   accept=application/json   Content-Type=application/json
    Create Session    alias=develop   url=${baseUrl}    headers=${headers}    verify=true

Login de usuário
    ${body}=   Create Dictionary
    ...     mail=sysadmin@qacoders.com
    ...     password=1234@Test
    Criar Sessao
    ${resposta}=   POST On Session   alias=develop   url=/login    json=${body}
    Status Should Be    200   ${resposta}
    RETURN    ${resposta.json()["token"]} 

Criar nova company 
    #Cria novo cadastro de empresa, para fins de teste
    
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
    ...     responsibleContact=Antonio Silveira
    ...     telephone=5571988564178
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=201
    ${id_empresa}    Set Variable    ${resposta.json()['newCompany']['_id']}
    Log    ID da empresa criada: ${id_empresa}
    Set Environment Variable    COMPANY_ID    ${id_empresa}

CT4.1.1 - Todos os Campos de Forma Válida
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777001
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=de 4503 ao fim - lado ímpar
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

    ${mensagem}=    Get From Dictionary    ${resposta.json()}    msg
    Should Be Equal    ${mensagem}    Endereço da companhia atualizado com sucesso.
  
CT4.2.1 - Todos os Campos Vazios  
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary

    ...   zipCode=
    ...   city=
    ...   state=
    ...   district=
    ...   street=
    ...   number=
    ...   complement=
    ...   country=

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.3.1 - 'Logradouro' Utilizando Mais de 50 Caracteres
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777001
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida das Palmeiras e Flores da Primavera - 12345 - fcfajhcklddjfflflaasl
    ...   number=50
    ...   complement=de 4503 ao fim - lado ímpar
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.3.2 - 'Número' Utilizando Mais de 10 Caracteres
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777001
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50505050500
    ...   complement=de 4503 ao fim - lado ímpar
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.3.3 - 'Complemento' Utilizando Mais de 80 Caracteres
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777001
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B - Edifício Nova Esperança - Rua das Flores - próximo ao mercado central
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.3.4 - 'Bairro' Utilizando Mais de 50 Caracteres
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777001
    ...   city=São Paulo
    ...   state=SP
    ...   district=Parque Residencial Jardim das Palmeiras do Sul
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.3.5 - 'Cidade' Utilizando Mais de 50 Caracteres
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777001
    ...   city=Parque Residencial Jardim das Palmeiras do Sul
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.3.6 - 'Estado' Utilizando Mais de 2 Caracteres
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777001
    ...   city=São Paulo
    ...   state=SPSP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.3.7 - 'País' Utilizando Mais de 50 Caracteres
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777001
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=República Federativa das Ilhas Unidas do Oceano Pacífico

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.4.1 - 'CEP' Utilizando Mais de 8 Caracteres
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=047770019
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.4.2 - 'CEP' Utilizando Menos de 8 Caracteres
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=047770
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.1 - 'Lougradouro' Incluindo Caracteres Especiais Não Permitidos
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Av,en!da Interl@gos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.2 - 'Número' Incluindo Caracteres Especiais
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=5&0
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.3 - 'Número' Incluindo Letras
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=5a
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.4 - 'Complemento' Incluindo Caracteres Especiais Não Permitidos
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto% 304&, Bloco B*.
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.5 - 'Bairro' Incluindo Caracteres Especiais Não Permitidos
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé!*&
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.6 - 'Cidade' Incluindo Caracteres Especiais Não Permitidos
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=S@o# Paul%
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.7 - 'Cidade' Incluindo Números
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=São00 P456ulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.8 - 'Estado' Incluindo Caracteres Especiais
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=São Paulo
    ...   state=S&
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.9 - 'Estado' Incluindo Números
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=São Paulo
    ...   state=S6
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.10 - 'País' Incluindo Caracteres Especiais 
    ${id_empresa}=      Get Environment Variable    COMPANY_ID 
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil%&

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.11 - 'País' incluindo números
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=04777089
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Bras09l

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.12 - 'CEP' incluindo caracteres especiais
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=0477°089
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

CT4.5.13 - 'CEP' incluindo letras
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${address}=   Create List
    ${endereco}=  Create Dictionary  
    ...   zipCode=0477A089
    ...   city=São Paulo
    ...   state=SP
    ...   district=Sé
    ...   street=Avenida Interlagos
    ...   number=50
    ...   complement=Apto 304 - Bloco B
    ...   country=Brasil

    Append To List    ${address}    ${endereco}
    ${body}=   Create Dictionary    address=${address}
    ${resposta}=    PUT On Session    alias=develop   url=company/address/${id_empresa}?token=${token}   json=${body}    expected_status=400

    Log             Status: ${resposta.status_code}
    Log             Corpo da resposta: ${resposta.json()}

