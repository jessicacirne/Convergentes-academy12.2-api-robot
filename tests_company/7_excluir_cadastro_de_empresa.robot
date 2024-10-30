*** Settings ***
Resource    ../resources/company_keywords/excluir_cadastro_de_empresa.robot

*** Test Cases ***

CN1: Cadastro de empresa deletado com sucesso (Validação positiva)
  CT7.1.1 - Excluir cadastro de empresa com sucesso

CN2: Cadastro de empresa não deletado (Validação negativa)
  CT7.2.1 - Excluir cadastro de empresa inexistente