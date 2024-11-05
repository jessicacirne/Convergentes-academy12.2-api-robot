*** Settings ***
Resource    ../resources/company_keywords/keywords.robot

*** Test Cases ***

CT4.1.1 - Todos os Campos de Forma Válida
    [Documentation]    CN01: Validar edição do endereço de empresa com sucesso.
    [Tags]    Positivo    Status deve ser 201   

    Editar Endereço   04777001   São Paulo   SP   Sé   Avenida Interlagos   50   de 4503 ao fim - lado ímpar   Brasil    201

CT4.2.1 - Todos os Campos Vazios
    [Documentation]    CN02: Validar campos obrigatórios
    [Tags]    Negativo    Status deve ser 400
    
    Editar Endereço    ""   ""   ""   ""   ""   ""   ""   ""    400   

CT4.3.1 - 'Logradouro' Utilizando Mais de 50 Caracteres
    [Documentation]    CN03: Validar limite de caracteres
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777001   São Paulo   SP   Sé   ucomrqapmaoyrgjopydmqdsyhuumuaoahsqbbyryeobzqgqaqkoxuhsqcmqx   50    de 4503 ao fim a lado ímpar   Brasil    400

CT4.3.2 - 'Número' Utilizando Mais de 10 Caracteres
    [Documentation]    CN03: Validar limite de caracteres
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777001   São Paulo   SP   Sé   Avenida Interlagos   50505050500   de 4503 ao fim - lado ímpar   Brasil    400
    
CT4.3.3 - 'Complemento' Utilizando Mais de 80 Caracteres
    [Documentation]    CN03: Validar limite de caracteres
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777001   São Paulo   SP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B - Edifício Nova Esperança - Rua das Flores - próximo ao mercado central   Brasil    400

CT4.3.4 - 'Bairro' Utilizando Mais de 50 Caracteres
    [Documentation]    CN03: Validar limite de caracteres
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777001   São Paulo   SP   ucomrqapmaoyrgjopydmqdsyhuumuaoahsqbbyryeobzqgqaqkoxuhsqcmqx   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400

CT4.3.5 - 'Cidade' Utilizando Mais de 50 Caracteres
    [Documentation]    CN03: Validar limite de caracteres
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777001   Parque Residencial Jardim das Palmeiras do Sul   SP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400

CT4.3.6 - 'Estado' Utilizando Mais de 2 Caracteres
    [Documentation]    CN03: Validar limite de caracteres
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777001   São Paulo   SPSP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400

CT4.3.7 - 'País' Utilizando Mais de 50 Caracteres
    [Documentation]    CN03: Validar limite de caracteres
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777001   São Paulo   SP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   República Federativa das Ilhas Unidas do Oceano Pacífico    400

CT4.4.1 - 'CEP' fora da máscara
    [Documentation]    CN04: Validar restrição de máscara
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   047770019   São Paulo   SP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400

CT4.5.1 - 'Logradouro' Incluindo Caracteres Especiais Não Permitidos
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777089   São Paulo   SP   Sé   Av,en!da Interl@gos   50   Apto 304 - Bloco B   Brasil    400

CT4.5.2 - 'Número' Incluindo Caracteres Especiais
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777089   São Paulo   SP   Sé   Avenida Interlagos   5&0   Apto 304 - Bloco B   Brasil    400

CT4.5.3 - 'Número' Incluindo Letras
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777089   São Paulo   SP   Sé   Avenida Interlagos   5a   Apto 304 - Bloco B   Brasil    400

CT4.5.4 - 'Complemento' Incluindo Caracteres Especiais Não Permitidos
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777089   São Paulo   SP   Sé   Avenida Interlagos   50   Apto% 304&, Bloco B*.   Brasil    400

CT4.5.5 - 'Bairro' Incluindo Caracteres Especiais Não Permitidos
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   4777089   São Paulo   SP   Sé!*&   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400

CT4.5.6 - 'Cidade' Incluindo Caracteres Especiais Não Permitidos
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777089   S@o# Paul%   SP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400

CT4.5.7 - 'Cidade' Incluindo Números
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777089   São00 P456ulo   SP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400

CT4.5.8 - 'Estado' Incluindo Caracteres Especiais
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400
    
    Editar Endereço   04777089   São Paulo   S&   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400

CT4.5.9 - 'Estado' Incluindo Números
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço    04777089   São Paulo   S6   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400


CT4.5.10 - 'País' Incluindo Caracteres Especiais 
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777089   São Paulo   SP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil%&    400

CT4.5.11 - 'País' incluindo números
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   04777089   São Paulo   SP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Bras09l    400

CT4.5.12 - 'CEP' incluindo caracteres especiais
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   0477°089   São Paulo   SP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400

CT4.5.13 - 'CEP' incluindo letras
    [Documentation]    CN05: Validar restrição de formato
    [Tags]    Negativo    Status deve ser 400

    Editar Endereço   0477A089   São Paulo   SP   Sé   Avenida Interlagos   50   Apto 304 - Bloco B   Brasil    400

Exclui empresa para testes de edição de cadastro    
    Excluir ID da empresa teste
