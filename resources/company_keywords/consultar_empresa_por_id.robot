*** Settings ***
Documentation       Keywords para o PATH /Company
Resource            ../resource.robot
Library             ../generator.py
Resource            ../funcoes_gerais.robot
Library             OperatingSystem
Library             RequestsLibrary
Library             Collections

*** Keywords ***

CT5.1.1 - Buscar por um ID cadastrado no sistema
    Cria nova empresa teste
    
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