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

CT3.1.1 - Todos os Campos de Forma Válida
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=200
    Log             Corpo da resposta: ${resposta.json()}

CT3.2.1 - Todos os Campos Vazios
    ${token}    Login de usuário
    ${body}     Create Dictionary

    ...   corporateName=
    ...   registerCompany=
    ...   mail=
    ...   matriz=
    ...   responsibleContact=
    ...   telephone=
    ...   serviceDescription=

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.3.1 - 'Nome da Empresa' Utilizando Nome Já Cadastrado    
    ${token}              Login de usuário
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=Teste Company Blacklist 572884
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.3.2 - 'CNPJ' Utilizando CNPJ Já Cadastrado
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=83239359000143
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.3.3 - 'Razão Social' Utilizando Razão Social Já Cadastrada
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=Teste Matriz Blacklist
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.4.1 - 'Nome da Empresa' Utilizando Mais de 100 Caracteres
    ${token}              Login de usuário
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=Maria Alessandra Gonçalves da Silva Pereira dos Santos Oliveira Albuquerque de Souza Ferreira Costa Lima Dias
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.4.2 - 'Contato responsável' Utilizando Mais de 100 Caracteres    
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Maria Alessandra Gonçalves da Silva Pereira dos Santos Oliveira Albuquerque de Souza Ferreira Costa Lima Dias
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.5.1 - 'CNPJ' com mais de 14 números
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=043534400001838
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.5.2 - 'CNPJ' com menos de 14 números
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=0435344000018
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.5.3 - 'Telefone' menos de 13 números
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=557198856417
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.5.4 - 'Telefone' mais de 14 números 
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=557198856417598
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.1 - 'Nome da Empresa' incluindo caracteres especiais
    ${token}              Login de usuário
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary  

    ...   corporateName=Silv&ir@ El.tro,i%cos 
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=557198856417598
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.2 - 'CNPJ' incluindo letras
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=12H45G7800F195
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.3 - 'CNPJ' incluindo caracteres especiais
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=1$345&7800%195
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.4 - 'Razão Social' incluindo caracteres especiais
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz= S*lve!r$ inf#rm@tica Co
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.5 - 'Contato Responsável' incluindo caracteres especiais
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=@nt*n&o C&@#!
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.6 - 'Contato Responsável' incluindo números
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=4nt0n10 C4rl9s
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.7 - 'Contato Responsável' com uma palavra
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.8 - 'Telefone' sem DDD do Brasil
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=6271988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.9 - 'Telefone' incluindo letras
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=557198b56a178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.10 - 'Telefone' incluindo caracteres especiais
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=627198&56*178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.11 - 'E-mail' fora do formato
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=testtest.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=Servico de informatica

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}

CT3.6.12 - 'Descrição' incluindo caracteres especiais
    ${token}              Login de usuário
    ${corporateName}      Generate corporateName
    ${matriz}             Generate matriz
    ${registerCompany}    Generate registerCompany
    ${body}               Create Dictionary

    ...   corporateName=${corporateName}
    ...   registerCompany=${registerCompany}
    ...   mail=test@test.com
    ...   matriz=${matriz}
    ...   responsibleContact=Antonio Silveira
    ...   telephone=5571988564178
    ...   serviceDescription=TëçhnøVïziøn

    ${resposta}=    PUT On Session    alias=develop   url=company/66f74574b8d32c9e73d9a65f?token=${token}   json=${body}    expected_status=400
    Log             Corpo da resposta: ${resposta.json()}       