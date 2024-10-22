*** Settings ***
Resource    ../resources/company_keywords/consultar_empresa_por_id.robot

*** Test Cases ***
Login de usuário
    Login de usuário

Criar nova company
    Criar nova company    
    
CN1: Consulta de empresa por ID com sucesso (Validação positiva)
    CT5.1.1 - Buscar por um ID cadastrado no sistema 

CN2: Consulta de empresa por ID não realizada (Validação negativa)
    CT5.2.1 - Buscar por um ID não existente no sistema
    CT5.2.2 - Buscar por um ID vazio ou nulo