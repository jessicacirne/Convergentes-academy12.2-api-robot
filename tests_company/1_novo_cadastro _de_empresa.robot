*** Settings ***
Resource    ../resources/company_keywords/novo_cadastro_de_empresa

*** Test Cases ***

Login de usuário
  Login de usuário

CN1: Novo cadastro de empresa com sucesso (Validação positiva)

CN2: Novo cadastro de empresa com campos vazios (Validação negativa)