*** Settings ***
Resource        users.robot
Library             RequestsLibrary

*** Test Cases ***
Login de Usuário - CN1: Login com sucesso
    Login de usuário

Login de Usuário - CN2: Login não funcionou
    Login c/ campos vazios
    Login c/ e-mail inválido
    Login c/ senha inválida
    Login c/ e-mail e senha inválidos

Novo cadastro de Login - CN1: Cadastrar usuário com sucesso
    Criar usuário c/ campos válidos
    Editar usuário c/ sucesso

Novo cadastro de Login - CN2: Cadastro de usuário não funcionou
    Criar usuário c/ os campos vazios
    Campo fullName c/ 101 caracteres    
    Campo fullName c/ números
    Campo fullName c/ uma palavra
    Campo mail fora do formato
    Campo mail c/ espaço
    Campo password c/ 7 caracteres
    Campo password c/ 13 caracteres    
    Campo password sem números
    Campo password sem caracteres especiais 
    Campos password e confirmPassword diferentes entre sí
    Campo cpf com 10 dígitos
    Campo cpf com 12 dígitos
    Campo cpf com letras
    Campo cpf com caracteres
    Campo password sem letra minúscula

Novo cadastro de Login - CN2: Cadastro de usuário não funcionou (continua)    
    Campo password sem letra maiúscula

Excluir cadastro de Login - CN1: Excluir usuário falhou
    Excluir usuário (ID) não existente

Excluir cadastro de Login - CN2: Excluir usuário com sucesso
    Excluir usuário (ID) existente
