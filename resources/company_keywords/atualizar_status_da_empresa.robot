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
    #Cria novo cadastro de empresa, para fins de teste, com Status ativo (true)

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
    
CT6.1.1 - Alterar o status da empresa para inativo
    # Altera o status da empresa criada para inativo (false)

    ${token}=           Login de usuário
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${body}=            Create Dictionary    status=false

    ${resposta}=    PUT On Session    alias=develop    url=company/status/${id_empresa}/?token=${token}    json=${body}    expected_status=201

    ${response_json}=    Convert To Dictionary    ${resposta.json()}

    ${status}=    Get From Dictionary    ${response_json['updateCompany']}    status
    Log           Corpo da resposta: ${response_json}
    Log           Status atual: ${status}
    
CT6.2.1 - Alterar o status da empresa para ativo
    # Altera o status da empresa criada para ativo (true) novamente

    ${token}=           Login de usuário
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${body}=            Create Dictionary    status=true

    ${resposta}=    PUT On Session    alias=develop    url=company/status/${id_empresa}/?token=${token}    json=${body}    expected_status=201

    ${response_json}=    Convert To Dictionary    ${resposta.json()}

    ${status}=    Get From Dictionary    ${response_json['updateCompany']}    status
    Log           Corpo da resposta: ${response_json}
    Log           Status atual: ${status}

CT6.3.1 - Alterar o status da empresa com valor inválido
    # Tentativa de alterar o status da empresa utilizando um valor inválido (diferente de True ou False)

    ${token}=           Login de usuário
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${body}=            Create Dictionary    status=inativo

    ${resposta}=    PUT On Session    alias=develop    url=company/status/${id_empresa}/?token=${token}    json=${body}    expected_status=500

CT6.3.2 - Alterar o status de uma empresa com ID inexistente  
    # Tentativa de alterar o status de uma empresa ue não existe no sistema.

    ${token}=           Login de usuário
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${body}=            Create Dictionary    status=false

    ${resposta}=    PUT On Session    alias=develop    url=company/status/6570d8fcc41ee4129739855c/?token=${token}    json=${body}    expected_status=400

