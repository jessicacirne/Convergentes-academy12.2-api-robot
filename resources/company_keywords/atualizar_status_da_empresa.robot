*** Settings ***
Documentation       Keywords para o PATH /Company
Resource            ../resource.robot
Library             ../generator.py
Resource            ../funcoes_gerais.robot
Library             OperatingSystem
Library             RequestsLibrary
Library             Collections

*** Keywords ***
    
CT6.1.1 - Alterar o status da empresa para inativo

    Cria nova empresa teste
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

