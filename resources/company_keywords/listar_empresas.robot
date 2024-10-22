*** Settings ***
Documentation       Keywords para o PATH /Company
Resource            ../resource.robot
Library             ../generator.py
Library             OperatingSystem
Library             RequestsLibrary
Library             DateTime
Library             Collections
Library             String

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

Lista cadastro de empresas
    ${token}=    Login de usuário
    ${body}=     Create Dictionary
    ${resposta}=  GET On Session   alias=develop   url=/company/?token=${token}    json=${body}    expected_status=200

    Log         Corpo da resposta: ${resposta.json()}
    Log         Status Code: ${resposta.status_code}

    @{expectedKeys}=  Create List    corporateName    registerCompany    mail    matriz    responsibleContact    telephone    serviceDescription    address
    FOR    ${item}    IN    @{resposta.json()}
        Log    Verificando item: ${item}
        FOR    ${key}    IN    @{expectedKeys}
            Run Keyword If    not '${key}' in ${item}    Fail    O item não contém a chave esperada: ${key}
        END
    END

    Log    Exibição das informações de cadastro das empresas com sucesso.

Desempenho e performance
    ${token}=    Login de usuário
    ${body}=     Create Dictionary
    ${start_time}=    Get Time    epoch
    ${resposta}=    GET On Session    alias=develop    url=/company/?token=${token}    json=${body}    expected_status=200
    ${end_time}=    Get Time    epoch
    ${response_time}=    Evaluate    ${end_time} - ${start_time}
    
    Log    Corpo da resposta: ${resposta.json()}
    Log    Status Code: ${resposta.status_code}
    
    Should Be True    ${response_time} < 2    msg=Tempo de resposta foi superior a 2 segundos: ${response_time} segundos
    Log    Tempo de resposta: ${response_time} segundos

Verificar filtro por Nome da empresa  
    ${token}=    Login de usuário
    ${filtro}=    Create Dictionary    corporateName=Teste Company Blacklist 572884
    ${url}=    Set Variable    ${baseUrl}/company/?corporateName=${filtro['corporateName']}&token=${token}

    ${resposta}=    GET On Session    alias=develop    url=${url}    expected_status=200
    
    Validate Filtered Companies    ${resposta.json()}    ${filtro['corporateName']}

Validate Filtered Companies
    [Arguments]    ${response}    ${expected_corporate_name}
    Should Not Be Empty    ${response}    A resposta não deve estar vazia.
    
    Should Be True    ${response} != []    A resposta deve conter registros.

    FOR    ${company}    IN    @{response}
        Should Be Equal    ${company['corporateName']}    ${expected_corporate_name}    A empresa não corresponde ao nome esperado: ${company['corporateName']}
    END

Verificar filtro por Cidade
    ${token}=    Login de usuário
    ${filtro}=    Create Dictionary    city=Recife
    ${url}=    Set Variable    ${baseUrl}/company/?city=${filtro['city']}&token=${token}

    ${resposta}=    GET On Session    alias=develop    url=${url}    expected_status=200
    
    Validate Filtered Companies by City    ${resposta.json()}    ${filtro['city']}

Validate Filtered Companies by City
    [Arguments]    ${response}    ${expected_city}
    Should Not Be Empty    ${response}    A resposta não deve estar vazia.
    
    Should Be True    ${response} != []    A resposta deve conter registros.

    FOR    ${company}    IN    @{response}
        Should Be Equal    ${company['address'][0]['city']}    ${expected_city}    A cidade não corresponde à cidade esperada: ${company['address'][0]['city']}
    END

Verificar filtro por Estado
    ${token}=    Login de usuário
    ${filtro}=    Create Dictionary    state=PE
    ${url}=    Set Variable    ${baseUrl}/company/?state=${filtro['state']}&token=${token}

    ${resposta}=    GET On Session    alias=develop    url=${url}    expected_status=200
    
    Validate Filtered Companies by State    ${resposta.json()}    ${filtro['state']}

Validate Filtered Companies by State
    [Arguments]    ${response}    ${expected_state}
    Should Not Be Empty    ${response}    A resposta não deve estar vazia.
    
    Should Be True    ${response} != []    A resposta deve conter registros.

    FOR    ${company}    IN    @{response}
        Should Be Equal    ${company['address'][0]['state']}    ${expected_state}    O estado não corresponde ao estado esperado: ${company['address'][0]['state']}
    END

Verificar filtro por País
    ${token}=    Login de usuário
    ${filtro}=    Create Dictionary    country=Brasil
    ${url}=    Set Variable    ${baseUrl}/company/?country=${filtro['country']}&token=${token}

    ${resposta}=    GET On Session    alias=develop    url=${url}    expected_status=200
    
    Validate Filtered Companies by Country    ${resposta.json()}    ${filtro['country']}

Validate Filtered Companies by Country
    [Arguments]    ${response}    ${expected_country}
    Should Not Be Empty    ${response}    A resposta não deve estar vazia.
    
    Should Be True    ${response} != []    A resposta deve conter registros.

    FOR    ${company}    IN    @{response}
        Should Be Equal    ${company['address'][0]['country']}    ${expected_country}    O país não corresponde ao país esperado: ${company['address'][0]['country']}
    END

Verificar filtro por Palavra-chave
    ${token}=    Login de usuário
    ${palavra_chave}=    Set Variable    Company Blacklist
    ${url}=    Set Variable    ${baseUrl}/company/?keyword=${palavra_chave}&token=${token}

    ${resposta}=    GET On Session    alias=develop    url=${url}    expected_status=200
    
    Validate Filtered Companies by Keyword    ${resposta.json()}    ${palavra_chave}

Validate Filtered Companies by Keyword
    [Arguments]    ${response}    ${expected_keyword}
    Should Not Be Empty    ${response}    A resposta não deve estar vazia.
    
    Should Be True    ${response} != []    A resposta deve conter registros.

    FOR    ${company}    IN    @{response}
        ${corporate_name_contains_keyword}=    Evaluate    "${expected_keyword}" in "${company['corporateName']}"
        ${service_description_contains_keyword}=    Evaluate    "${expected_keyword}" in "${company['serviceDescription']}"
        ${city_contains_keyword}=    Evaluate    "${expected_keyword}" in "${company['address'][0]['city']}"

        IF    ${corporate_name_contains_keyword} or ${service_description_contains_keyword} or ${city_contains_keyword}
            Log    Palavra-chave encontrada na empresa: ${company['corporateName']}
        ELSE
            Fail    Empresa não corresponde à palavra-chave esperada: ${company['corporateName']}
        END
    END

Verificar ordenação da Lista de Empresas por ordem alfabética
    ${token}=       Login de usuário
    ${body}=     Create Dictionary
    ${resposta}=    GET On Session    alias=develop    url=company/?sort=corporateName&token=${token}     json=${body}
    
    Log     Corpo da resposta: ${resposta.json()}

    ${responseOrdenado}=     Sort Companies  ${resposta.json()}

    Log     Lista original: ${resposta.json()}
    Log     Lista ordenada: ${responseOrdenado}

    Lists Should Be Equal   ${resposta.json()}     ${responseOrdenado}

Verificar ordenação da Lista de Empresas por data de cadastro
    ${token}=       Login de usuário
    ${body}=        Create Dictionary
    ${resposta2}=    GET On Session      alias=develop   url=company/?sort=audit.registrationDate&token=${token}     json=${body}
    Log     Corpo da resposta: ${resposta2.json()}

    ${responseOrdenadoData}=    Sort Companies By Date     ${resposta2.json()}

    Log     Lista ordenada: ${responseOrdenadoData}

    Lists Should Be Equal   ${resposta2.json()}     ${responseOrdenadoData}