*** Settings ***
Documentation       Keywords gerais para o PATH /Company
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
    [Documentation]     Passos iniciais e primeira autenticação como administrador
    ${body}=   Create Dictionary
    ...     mail=sysadmin@qacoders.com
    ...     password=1234@Test
    Criar Sessao
    ${resposta}=   POST On Session   alias=develop   url=/login    json=${body}
    Status Should Be    200   ${resposta}
    RETURN    ${resposta.json()["token"]}

Cria novo usuário 
    [Documentation]    Cria novo usuário, para fins de teste
    
    Login de usuário

    [Arguments]    ${fullName}    ${mail}    ${password}    ${accessProfile}    ${cpf}    ${confirmPassword}    ${expected_status}

    ${token}=       Login de usuário
    ${address}=     Create List
    ${dados_usuario}=    Create Dictionary

    ...     fullName=${fullName}
    ...     mail=${mail}
    ...     password=${password}
    ...     accessProfile=${accessProfile}
    ...     cpf=${cpf}
    ...     confirmPassword=${confirmPassword}

    ${resposta}=  POST On Session    alias=develop    url=user/?token=${token}    json=${dados_usuario}    expected_status=${expected_status}

    ${id_usuario}=    Set Variable    ${resposta.json()['user']['_id']} 
    Set Environment Variable    USER_ID    ${id_usuario}
    Log To Console    Usuário criado com ID: ${id_usuario}

Cria novo usuário (Validação negativa)

    [Documentation]    Cria novo usuário, para fins de teste
    
    Login de usuário

    [Arguments]    ${fullName}    ${mail}    ${password}    ${accessProfile}    ${cpf}    ${confirmPassword}    ${expected_status}

    ${token}=       Login de usuário
    ${address}=     Create List
    ${dados_usuario}=    Create Dictionary

    ...     fullName=${fullName}
    ...     mail=${mail}
    ...     password=${password}
    ...     accessProfile=${accessProfile}
    ...     cpf=${cpf}
    ...     confirmPassword=${confirmPassword}

    ${resposta}=  POST On Session    alias=develop    url=user/?token=${token}    json=${dados_usuario}    expected_status=${expected_status}


Excluir ID do usuário Teste
    
    [Documentation]     Apaga usuário criado do sistema, para não poluir a base de dados
    ${id_usuario}=      Get Environment Variable    USER_ID
    ${token}=           Login de usuário
    
    ${resposta}=        DELETE On Session   alias=develop   url=user/${id_usuario}?token=${token}    expected_status=200

Buscar usuário Por ID
    [Arguments]    ${id_usuario}    ${expected_status}
    ${token}=         Login de usuário
    ${body}=          Create Dictionary
    ${resposta}=      GET On Session   alias=develop   url=user/${id_usuario}?token=${token}    json=${body}    expected_status=${expected_status}
    Log               Status Code: ${resposta.status_code}    