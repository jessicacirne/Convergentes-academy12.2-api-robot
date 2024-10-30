*** Settings ***
Documentation       Keywords para o PATH /Company
Resource            ../resource.robot
Resource            ../funcoes_gerais.robot
Library             ../generator.py
Library             OperatingSystem
Library             RequestsLibrary
Library             Collections

***Keywords***

CT7.1.1 - Excluir cadastro de empresa com sucesso
    Cria nova empresa teste
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=           Login de usuário
    
    ${resposta}=        DELETE On Session   alias=develop   url=company/${id_empresa}?token=${token}    expected_status=200
    Verifica se o ID excluido consta no sistema

CT7.2.1 - Excluir cadastro de empresa inexistente    
    ${token}=           Login de usuário
    ${body}=            Create Dictionary

    ${resposta}=        DELETE On Session   alias=develop   url=company/64f0c0703b4989d75f6241df?token=${token}    json=${body}    expected_status=404
