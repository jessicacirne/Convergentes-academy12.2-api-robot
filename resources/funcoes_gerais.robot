*** Settings ***
Documentation       Keywords gerais para o PATH /Company
Resource            resource.robot
Library             generator.py
Library             OperatingSystem
Library             RequestsLibrary
Library             Collections

*** Keywords ***

Criar Sessao
    ${headers}=    Create Dictionary   accept=application/json   Content-Type=application/json
    Create Session    alias=develop   url=${baseUrl}    headers=${headers}    verify=true

Login de usuário
    [Documentation]     Primeira autenticação como administrador
    ${body}=   Create Dictionary
    ...     mail=sysadmin@qacoders.com
    ...     password=1234@Test
    Criar Sessao
    ${resposta}=   POST On Session   alias=develop   url=/login    json=${body}
    Status Should Be    200   ${resposta}
    RETURN    ${resposta.json()["token"]}   

Cria nova empresa teste 
    [Documentation]    Cria novo cadastro de empresa, para fins de teste
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
    ...     serviceDescription=Servico de informatica

    Set To Dictionary    ${dados_empresa}    address=${address}

    ${resposta}=  POST On Session    alias=develop    url=company/?token=${token}    json=${dados_empresa}    expected_status=201
    
    # Armazenar o _id da empresa criada em uma variável de ambiente
    ${id_empresa}=    Set Variable    ${resposta.json()['newCompany']['_id']} 
    Set Environment Variable    COMPANY_ID    ${id_empresa}

    RETURN    ${registerCompany}  # Retorna o CNPJ gerado

Excluir ID da empresa teste
    [Documentation]     Apaga empresa criada do sistema, para não poluir a base de dados
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=           Login de usuário
    
    ${resposta}=        DELETE On Session   alias=develop   url=company/${id_empresa}?token=${token}    expected_status=200

Verifica se o ID excluido consta no sistema
    ${id_empresa}=      Get Environment Variable    COMPANY_ID
    ${token}=     Login de usuário
    ${body}=      Create Dictionary
    ${resposta}=  GET On Session   alias=develop   url=company/${id_empresa}?token=${token}    json=${body}    expected_status=400

    Log         Corpo da resposta: ${resposta.json()}
    Log         Status Code: ${resposta.status_code}       

Listagem de empresas
    Login de usuário

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
  