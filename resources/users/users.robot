*** Settings ***
Documentation    Keywords para o PATH /Users
Resource         ../resource.robot
Library          ../generator.py
Library          OperatingSystem

*** Keywords ***
Criar Sessao
    ${headers}    Create Dictionary   accept=application/json   Content-Type=application/json
    Create Session    alias=develop   url=${baseUrl}    headers=${headers}    verify=true

Login de usuário
    ${body}   Create Dictionary
    ...     mail=sysadmin@qacoders.com
    ...     password=1234@Test

    Criar Sessao
    ${resposta}   POST On Session   alias=develop   url=/login    json=${body}
    Status Should Be    200   ${resposta}
    RETURN                  ${resposta.json()["token"]}

Login c/ campos vazios
    ${token}    Login de usuário       
    ${body}    Create Dictionary
    ...    mail= 
    ...    password= 

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Login c/ e-mail inválido    
    ${token}    Login de usuário       
    ${body}    Create Dictionary
    ...    mail=sys@qacoders.com
    ...    password=12345@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Login c/ senha inválida    
    ${token}    Login de usuário       
    ${body}    Create Dictionary
    ...    mail=sysadmin@qacoders.com
    ...    password=12345@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Login c/ e-mail e senha inválidos
    ${token}    Login de usuário       
    ${email}    Generate Email
    ${body}    Create Dictionary
    ...    mail=${email}
    ...    password=12345@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Criar usuário c/ campos válidos
    ${token}    Login de usuário
    ${email}    Generate Email        
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=1234@Test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=1234@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=201
    Log     Corpo da resposta: ${resposta.json()}
    ${id_usuario}    Set Variable    ${resposta.json()['user']['_id']}
    Log    ID do usuário criado: ${id_usuario}
    Set Environment Variable    USER_ID    ${id_usuario}

Criar usuário c/ os campos vazios
    ${token}    Login de usuário
    ${body}    Create Dictionary
    ...    fullName= 
    ...    mail= 
    ...    password= 
    ...    accessProfile= 
    ...    cpf= 
    ...    confirmPassword= 

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Campo fullName c/ 101 caracteres
    ${token}    Login de usuário        
    ${email}    Generate Email
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Maria Alexandra dos Santos Ferreira de Oliveira Castro Gomes da Silva Pereira Fernandes Costa e Souza Lima
    ...    mail=${email}
    ...    password=1234@Test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=1234@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Campo fullName c/ números    
    ${token}    Login de usuário        
    ${email}    Generate Email
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice8 Allana1
    ...    mail=${email}
    ...    password=1234@Test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=1234@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Campo fullName c/ uma palavra
    ${token}    Login de usuário        
    ${email}    Generate Email
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice
    ...    mail=${email}
    ...    password=1234@Test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=1234@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Campo mail fora do formato
    ${token}    Login de usuário        
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=clariceallanagmail.com
    ...    password=1234@Test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=1234@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Campo mail c/ espaço
    ${token}    Login de usuário        
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=clariceallana @gmail.com
    ...    password=1234@Test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=1234@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Campo password c/ 7 caracteres
    ${token}    Login de usuário        
    ${email}    Generate Email
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=12@Test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=12@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Campo password c/ 13 caracteres
    ${token}    Login de usuário        
    ${email}    Generate Email
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=12345678@Test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=12345678@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Campo password sem números
    ${token}    Login de usuário
    ${email}    Generate Email
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=test@Test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=test@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Campo password sem caracteres especiais
    ${token}    Login de usuário
    ${email}    Generate Email
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=test@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
    Log     Corpo da resposta: ${resposta.json()}

Campos password e confirmPassword diferentes entre sí
    ${token}    Login de usuário
    ${email}    Generate Email
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=12345@Test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=1234@Test
      
    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
   
    Log     Corpo da resposta: ${resposta.json()}

Campo cpf com 10 dígitos
    ${token}    Login de usuário
    ${email}    Generate Email
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=12345@Test
    ...    accessProfile=ADMIN
    ...    cpf=3240719606
    ...    confirmPassword=12345@Test
      
    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
   
    Log     Corpo da resposta: ${resposta.json()}

Campo cpf com 12 dígitos
    ${token}    Login de usuário
    ${email}    Generate Email
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=12345@Test
    ...    accessProfile=ADMIN
    ...    cpf=324071960646
    ...    confirmPassword=12345@Test
      
    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
   
    Log     Corpo da resposta: ${resposta.json()}
Campo cpf com letras
    ${token}    Login de usuário
    ${email}    Generate Email
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=12345@Test
    ...    accessProfile=ADMIN
    ...    cpf=1456b874111
    ...    confirmPassword=12345@Test
      
    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
   
    Log     Corpo da resposta: ${resposta.json()}

Campo cpf com caracteres
    ${token}    Login de usuário
    ${email}    Generate Email
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=12345@Test
    ...    accessProfile=ADMIN
    ...    cpf=1456@874111
    ...    confirmPassword=12345@Test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
   
    Log     Corpo da resposta: ${resposta.json()}

Campo password sem letra maiúscula
    ${token}    Login de usuário        
    ${email}    Generate Email
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=1234@test
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=1234@test

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
   
    Log     Corpo da resposta: ${resposta.json()}
Campo password sem letra minúscula
    ${token}    Login de usuário        
    ${email}    Generate Email
    ${cpf}      Generate Cpf
    ${body}    Create Dictionary
    ...    fullName=Clarice Allana
    ...    mail=${email}
    ...    password=1234@TEST
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    confirmPassword=1234@TEST

    ${resposta}=  POST On Session    alias=develop    url=/user/?token=${token}    json=${body}    expected_status=400
   
    Log     Corpo da resposta: ${resposta.json()}
   
Excluir usuário (ID) não existente
    ${token}    Login de usuário
    DELETE On Session    alias=develop   url=/user/66c4f1bc0957c6c05f10708f?token=${token}    expected_status=400

Excluir usuário (ID) existente  
    ${token}    Login de usuário

    ${id_usuario}    Get Environment Variable    USER_ID
    

    DELETE On Session    alias=develop   url=/user/${id_usuario}?token=${token}    expected_status=200
    
    Log    Usuário com ID ${id_usuario} foi excluído.