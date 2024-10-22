*** Settings ***
Resource    ../resources/company_keywords/atualizar_status_da_empresa.robot

*** Test Cases ***
Login de usuário
    Login de usuário

Criar nova company
    Criar nova company    

CN1: Atualizar status da empresa para inativo com sucesso (Validação positiva)
    CT6.1.1 - Alterar o status da empresa para inativo

CN2: Atualizar status da empresa para ativo com sucesso (Validação positiva)
    CT6.2.1 - Alterar o status da empresa para ativo

CN3: Atualização do status da empresa negada (Validação negativa)
    CT6.3.1 - Alterar o status da empresa com valor inválido
    CT6.3.2 - Alterar o status de uma empresa com ID inexistente
