*** Settings ***
Resource    ../resources/company_keywords/keywords.robot

*** Test Cases ***

CN1: Visualização e Performance da Lista de Empresas
    [Tags]    robot:recursive-continue-on-failure
    Lista cadastro de empresas
    Desempenho e performance

CN2: Filtros de pesquisas na Lista de Empresas - Nome da empresa
    Verificar filtro por Nome da empresa     

CN2: Filtros de pesquisas na Lista de Empresas - Cidade
    Verificar filtro por Cidade  

CN2: Filtros de pesquisas na Lista de Empresas - Estado
    Verificar filtro por Estado

CN2: Filtros de pesquisas na Lista de Empresas - País
    Verificar filtro por País

CN2: Filtros de pesquisas na Lista de Empresas - Palavra-chave
    Verificar filtro por Palavra-chave          
    
CN3: Ordenação na Lista de Empresas - ordem alfabética
    Verificar ordenação da Lista de Empresas por ordem alfabética

CN3: Ordenação na Lista de Empresas - data de cadastro   
    Verificar ordenação da Lista de Empresas por data de cadastro
