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
    # Autenticação necessária para o teste rodar
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

CT5.1.1 - Buscar por um ID cadastrado no sistema
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${body}=      Create Dictionary
    ${resposta}=  GET On Session   alias=develop   url=company/${id_empresa}?token=${token}    json=${body}    expected_status=200

    Log         Corpo da resposta: ${resposta.json()}
    Log         Status Code: ${resposta.status_code}

CT5.2.1 - Buscar por um ID não existente no sistema
    ${token}=     Login de usuário
    ${body}=      Create Dictionary
    ${resposta}=  GET On Session   alias=develop   url=company/6570d8fcc41ee4129739855b?token=${token}    json=${body}    expected_status=400

    Log         Corpo da resposta: ${resposta.json()}
    Log         Status Code: ${resposta.status_code}

CT5.2.2 - Buscar por um ID vazio ou nulo    
    ${token}=     Login de usuário
    ${body}=      Create Dictionary
    ${resposta}=  GET On Session   alias=develop   url=company/0?token=${token}    json=${body}    expected_status=500

    Log         Corpo da resposta: ${resposta.json()}
    Log         Status Code: ${resposta.status_code}