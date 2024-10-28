# TEST PLAN - API - ERP ACADEMY 

## ✨ Feature testada: **COMPANY**
                            
## 2. Lista cadastro de empresas
  ### CN1:  Visualização e Performance da Lista de Empresas

  ##### CT2.1.1 - Exibição das Informações de Cadastro
  - **Objetivo**: Verificar se as informações relevantes sobre cada empresa são exibidas corretamente
  - **Prioridade**: Alta
  - **Pré-requisitos**: A lista de empresas deve estar disponível.
  - **Passos**: Enviar uma requisição GET para o endpoint `/api/company`
  - **Resultado esperado**:
    - O status code é 200 - OK
    - A resposta é um array
    - Exibição das informações de cadastro das empresas com sucesso

  ##### CT2.1.2 - Desempenho e Performance
    - **Objetivo**: Assegurar que a lista de empresas seja carregada de maneira eficiente.
    - **Prioridade**: Alta
    - **Pré-requisitos**: A lista de empresas deve ter um grande número de registros.
    - **Passos**: Enviar uma requisição GET para o endpoint `/api/company`
    - **Resultado esperado**: 
      - Tempo de resposta deve ser inferior a 2 segundos
  
  ### CN2: Paginação da Lista de Empresas

  ##### CT2.2.1 - Verificação da Exibição de Paginação
    - **Objetivo**: Verificar a funcionalidade de paginação.
    - **Prioridade**: Alta
    - **Pré-requisitos**: A lista de empresas deve conter mais de 30 registros.
    - **Passos**: Enviar uma requisição GET para o endpoint `/api/company` com os parâmetros de paginação.
    - **Resultado esperado**:
      - A barra de paginação deve aparecer após o 31º registro

  ### CN3: Filtros de Pesquisas na Lista de Empresas

  ##### CT2.3.1 - Verificar Filtro por Nome da Empresa
    - **Objetivo**: Verificar se os filtros de pesquisa por Nome da empresa funcionam corretamente.
    - **Prioridade**: Alta
    - **Pré-requisitos**: A lista de empresas deve estar disponível.
    - **Passos**: Enviar uma requisição GET para o endpoint `/api/company` incluindo o parâmetro de filtro para `corporateName`
    - **Resultado esperado**: 
      - Todas as empresas listadas obedecem ao filtro Nome da empresa

  ##### CT2.3.2 - Verificar Filtro por Cidade
    - **Objetivo**: Verificar se os filtros de pesquisa por Cidade funcionam corretamente.
    - **Prioridade**: Alta
    - **Pré-requisitos**: A lista de empresas deve estar disponível.
    - **Passos**: Enviar uma requisição GET para o endpoint `/api/company` incluindo o parâmetro de filtro para `city`
    - **Resultado esperado**:
     - Todas as empresas listadas obedecem ao filtro Cidade

  ##### CT2.3.3 - Verificar Filtro por Estado
    - **Objetivo**: Verificar se os filtros de pesquisa por Estado funcionam corretamente.
    - **Prioridade**: Alta
    - **Pré-requisitos**: A lista de empresas deve estar disponível.
    - **Passos**: Enviar uma requisição GET para o endpoint `/api/company` incluindo o parâmetro de filtro para `state`
    - **Resultado esperado**:
      - Todas as empresas listadas obedecem ao filtro Estado

  ##### CT2.3.4 - Verificar Filtro por País
    - **Objetivo**: Verificar se os filtros de pesquisa por País funcionam corretamente.
     **Prioridade**: Alta
    - **Pré-requisitos**: A lista de empresas deve estar disponível.
    - **Passos**: Enviar uma requisição GET para o endpoint `/api/company` incluindo o parâmetro de filtro para `country`
    - **Resultado esperado**: 
      - Todas as empresas listadas obedecem ao filtro País

  ##### CT2.3.5 - Verificar Filtro por Palavra-chave
  - **Objetivo**: Verificar se os filtros de pesquisa por Palavra-chave funcionam corretamente.
  - **Prioridade**: Alta
  - **Pré-requisitos**: A lista de empresas deve estar disponível.
  - **Passos**: Enviar uma requisição GET para o endpoint `/api/company` incluindo o parâmetro de filtro para `palavra-chave`
  - **Resultado esperado**:
    - Todas as empresas listadas obedecem ao filtro Palavra-chave

  #### CN4: Ordenação na Lista de Empresas

  ##### CT2.4.1 - Verificar Ordenação da Lista de Empresas por Ordem Alfabética
  - **Objetivo**: Verificar se a ordenação dos resultados funciona conforme esperado
  - **Prioridade**: Alta
  - **Passos**: Enviar uma requisição GET para o endpoint da lista de empresas, solicitando a ordenação em ordem alfabética
  - **Pré-requisitos**: A lista de empresas deve estar disponível.
   **Resultado esperado**:
    - A lista de empresas está ordenada por ordem alfabética

  ##### CT2.4.2 - Verificar Ordenação da Lista de Empresas por Data de Cadastro
  - **Objetivo**: Verificar se a ordenação dos resultados funciona conforme esperado
  - **Prioridade**: Alta
  - **Passos**: Enviar uma requisição GET para o endpoint da lista de empresas, solicitando a ordenação em ordem de data de cadastro
  - **Pré-requisitos**: A lista de empresas deve estar disponível.
  - **Resultado esperado**:
    - A lista de empresas está ordenada por data de cadastro

---
## 3. Editar cadastro de empresa 

  ### CN1: Cadastro de empresa editado com sucesso (Validação positiva)

  #### CT3.1.1 - Todos os Campos de Forma Válida
  - **Objetivo**: Editar o cadastro de empresa com sucesso, preenchendo todos os campos de forma válida.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição PUT para o endpoint api/company/{id da empresa}
  - **Pré-condição**: Empresa deve estar cadastrada no sistema.
  - **Passos**: Editar todos os campos de forma válida.
  - **Resultado esperado**: Status Code 200 - OK
                          Validação de preenchimento dos campos corretamente
                          Exibição de mensagem de sucesso

  ### CN2: Campos vazios (Validação negativa)

  #### CT3.2.1 - Todos os Campos Vazios

  - **Objetivo**: Verificar se o sistema retorna erro ao tentar editar o cadastro com campos vazios.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição PUT para o endpoint api/company/{id da empresa}
  - **Pré-condição**: Empresa deve estar cadastrada no sistema.
  - **Passos**: Editar todos os campos deixando-os vazios.
  - **Resultado esperado**: Status Code 400 - Bad request
                          Exibição de mensagem de erro indicando os os campos vazios

  ### CN3: Duplicidade (Validação negativa)
  #### CT3.3.1 - 'Nome da Empresa' Utilizando Nome Já Cadastrado
  - **Objetivo**: Verificar se o sistema impede a edição do nome da empresa com um nome já cadastrado.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'corporateName' utilizando um nome já cadastrado no sistema e preencher os outros campos de forma válida.
  - **Resultado esperado**: Status Code 400 - Bad request
                          Exibição de mensagem de erro
  #### CT3.3.2 - 'CNPJ' Utilizando CNPJ Já Cadastrado
  - **Objetivo**: Verificar se o sistema impede a edição do CNPJ com um já cadastrado.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'registerCompany' utilizando um já cadastrado no sistema e preencher os outros campos de forma válida.
  - **Resultado esperado**: Status Code 400 - Bad request
                          Exibição de mensagem de erro
  #### CT3.3.3 - 'Razão Social' Utilizando Razão Social Já Cadastrada
  - **Objetivo**: Verificar se o sistema impede a edição da Razão social com uma já cadastrada.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'matriz' utilizando um já cadastrado no sistema e preencher os outros campos de forma válida.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro                        
  ### CN4: Limite de caracteres (Validação negativa)
  #### CT3.4.1 - 'Nome da Empresa' Utilizando Mais de 100 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição do nome da empresa com mais de 100 caracteres.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'Nome da Empresa' utilizando mais de 100 caracteres.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro  

  #### CT3.4.2 - 'Contato responsável' Utilizando Mais de 100 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição do Contato responsável com mais de 100 caracteres.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'responsableContact' utilizando mais de 100 caracteres.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro 

  ### CN5: Restrição de máscara (Validação negativa)                         
  #### CT3.5.1 - 'CNPJ' com mais de 14 números
  - **Objetivo**: Verificar se o sistema impede a edição do campo CNPJ com mais de 14 dígitos.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'registerCompany' utilizando 15 dígitos, sendo eles números e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro 
                            
  #### CT3.5.2 - 'CNPJ' com menos de 14 números
  - **Objetivo**: Verificar se o sistema impede a edição do campo CNPJ com menos de 14 dígitos.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'registerCompany' utilizando 13 dígitos, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro   

  #### CT3.5.3 - 'Telefone' menos de 13 números
  - **Objetivo**: Verificar se o sistema impede a edição do campo Telefone com menos de 13 dígitos.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'telephone' utilizando 12 dígitos, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro            

  #### CT3.5.4 - 'Telefone' mais de 14 números
  - **Objetivo**: Verificar se o sistema impede a edição do campo Telefone com mais de 14 dígitos.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'telephone' utilizando 15 dígitos, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro 

  ### CN6: Restrição de formato (Validação negativa)
  
  #### CT3.6.1 - 'Nome da Empresa' incluindo caracteres especiais
  - **Objetivo**: Verificar se o sistema impede a edição do campo Nome da Empresa incluindo caracteres especiais.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'corporateName' incluindo caracteres especiais, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro

  #### CT3.6.2 - 'CNPJ' incluindo letras
  - **Objetivo**: Verificar se o sistema impede a edição do campo CNPJ incluindo letras.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'registerCompany' incluindo letras, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro

  #### CT3.6.3 - 'CNPJ' incluindo caracteres especiais
  - **Objetivo**: Verificar se o sistema impede a edição do campo CNPJ incluindo caracteres especiais.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'registerCompany' incluindo caracteres especiais, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro

  #### CT3.6.4 - 'Razão Social' incluindo caracteres especiais
  - **Objetivo**: Verificar se o sistema impede a edição do campo Razão Social incluindo caracteres especiais.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'matriz' incluindo caracteres especiais, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro                                                                                    
  #### CT3.6.5 - 'Contato Responsável' incluindo caracteres especiais
  - **Objetivo**: Verificar se o sistema impede a edição do campo Contato Responsável incluindo caracteres especiais.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'responsibleContact' incluindo caracteres especiais, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro

  #### CT3.6.6 - 'Contato Responsável' incluindo números
  - **Objetivo**: Verificar se o sistema impede a edição do campo Contato Responsável incluindo números.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'responsibleContact' incluindo números, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro

  #### CT3.6.7 - 'Contato Responsável' com uma palavra
  - **Objetivo**: Verificar se o sistema impede a edição do campo Contato Responsável com apenas uma palavra.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'responsibleContact' com apenas uma palavra, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro

  #### CT3.6.8 - 'Telefone' sem DDD do Brasil
  - **Objetivo**: Verificar se o sistema impede a edição do campo Telefone com números sem o ddd do Brasil.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'telephone' utilizando 15 dígitos e sem o prefixo 55 e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro

  #### CT3.6.9 - 'Telefone' incluindo letras
  - **Objetivo**: Verificar se o sistema impede a edição do campo Telefone incluindo letras.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'telephone' incluindo letras, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro

  #### CT3.6.10 - 'Telefone' incluindo caracteres especiais
  - **Objetivo**: Verificar se o sistema impede a edição do campo Telefone incluindo caracteres especiais.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'telephone' incluindo caracteres especiais, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro

  #### CT3.6.11 - 'E-mail' fora do formato
  - **Objetivo**: Verificar se o sistema impede a edição do campo E-mail fora do formato nome@dominio.com.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'mail' fora do formato estipulado e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro

  #### CT3.6.12 - 'Descrição' incluindo caracteres especiais
  - **Objetivo**: Verificar se o sistema impede a edição do campo Descrição incluindo caracteres especiais.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'serviceDescription' incluindo caracteres especiais, obedecendo as outras restrições de formato e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro
                         
---
## 4. Editar dados de endereço da empresa 

  ### CN1: Edição de dados de endereço da empresa com sucesso (Validação positiva)

  #### CT4.1.1 - Todos os Campos de Forma Válida
  - **Objetivo**: Editar os dados de endereço da empresa com sucesso, preenchendo todos os campos de forma válida.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição PUT para o endpoint api/company/address/{id da empresa}
  - **Pré-condição**: Empresa deve estar cadastrada no sistema.
  - **Passos**: Editar todos os campos de forma válida.
  - **Resultado esperado**: Status Code 200 - OK  
                          Validação de preenchimento dos campos corretamente  
                          Exibição de mensagem de sucesso

  ### CN2: Campos vazios (Validação negativa)

  #### CT4.2.1 - Todos os Campos Vazios
  - **Objetivo**: Verificar se o sistema retorna erro ao tentar editar dados de endereço da empresa com campos vazios.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição PUT para o endpoint api/company/address/{id da empresa}
  - **Pré-condição**: Empresa deve estar cadastrada no sistema.
  - **Passos**: Editar todos os campos deixando-os vazios.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro indicando os campos vazios

  ### CN3: Limite de caracteres (Validação negativa)

  #### CT4.3.1 - 'Logradouro' Utilizando Mais de 50 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição do lougradouro com mais de 50 caracteres.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'street' utilizando 51 caracteres e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.3.2 - 'Número' Utilizando Mais de 10 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição do número com mais de 10 caracteres.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'number' utilizando 11 caracteres e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.3.3 - 'Complemento' Utilizando Mais de 80 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição do complemento com mais de 80 caracteres.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'complement' utilizando 81 caracteres e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.3.4 - 'Bairro' Utilizando Mais de 50 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição do bairro com mais de 50 caracteres.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'district' utilizando 51 caracteres e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.3.5 - 'Cidade' Utilizando Mais de 50 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição da cidade com mais de 50 caracteres.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'city' utilizando 51 caracteres e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.3.6 - 'Estado' Utilizando Mais de 2 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição do estado com mais de 2 caracteres.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'state' utilizando 3 caracteres e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.3.7 - 'País' Utilizando Mais de 50 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição do país com mais de 50 caracteres e preencher os outros campos corretamente.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'country' utilizando 51 caracteres.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  ### CN4: Restrição de máscara (Validação negativa)

  #### CT4.4.1 - 'CEP' Utilizando Mais de 8 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição do CEP com mais de 8 caracteres.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'zipCode' utilizando 9 caracteres e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                            Exibição de mensagem de erro

  #### CT4.4.2 - 'CEP' Utilizando Menos de 8 Caracteres
  - **Objetivo**: Verificar se o sistema impede a edição do CEP com menos de 8 caracteres.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'zipCode' utilizando 7 caracteres e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  ### CN5: Restrição de formato (Validação negativa)

  #### CT4.5.1 - 'Lougradouro' Incluindo Caracteres Especiais Não Permitidos
  - **Objetivo**: Verificar se o sistema impede a edição do campo Lougradouro incluindo caracteres especiais não permitidos (Diferentes de 'ª', 'º', '‘' e '-').
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'street' incluindo caracteres especiais não permitidos (Diferentes de 'ª', 'º', '‘' e '-') e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.5.2 - 'Número' Incluindo Caracteres Especiais
  - **Objetivo**: Verificar se o sistema impede a edição do campo Número incluindo caracteres especiais.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'number' incluindo caracteres especiais e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                            Exibição de mensagem de erro

  #### CT4.5.3 - 'Número' Incluindo Letras
  - **Objetivo**: Verificar se o sistema impede a edição do campo Número incluindo letras.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'number' incluindo letras e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.5.4 - 'Complemento' Incluindo Caracteres Especiais Não Permitidos
  - **Objetivo**: Verificar se o sistema impede a edição do campo Complemento incluindo caracteres especiais não permitidos (Diferentes de 'ª', 'º', '‘' e '-').
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'complement' incluindo caracteres especiais não permitidos (Diferentes de 'ª', 'º', '‘' e '-') e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                            Exibição de mensagem de erro

  #### CT4.5.5 - 'Bairro' Incluindo Caracteres Especiais Não Permitidos
  - **Objetivo**: Verificar se o sistema impede a edição do campo Bairro incluindo caracteres especiais não permitidos (Diferentes de 'ª', 'º', '‘' e '-').
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'district' incluindo caracteres especiais não permitidos (Diferentes de 'ª', 'º', '‘' e '-') e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.5.6 - 'Cidade' Incluindo Caracteres Especiais Não Permitidos
  - **Objetivo**: Verificar se o sistema impede a edição do campo Bairro incluindo caracteres especiais não permitidos (Diferentes de 'ª', 'º', '‘' e '-').
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'city' incluindo caracteres especiais não permitidos (Diferentes de 'ª', 'º', '‘' e '-') e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.5.7 - 'Cidade' Incluindo Números
  - **Objetivo**: Verificar se o sistema impede a edição do campo Cidade incluindo números.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'city' incluindo números e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.5.8 - 'Estado' Incluindo Caracteres Especiais
  - **Objetivo**: Verificar se o sistema impede a edição do campo Estado incluindo caracteres especiais.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'state' incluindo caracteres especiais e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.5.9 - 'Estado' Incluindo Números
  - **Objetivo**: Verificar se o sistema impede a edição do campo Estado incluindo números.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'state' incluindo números e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.5.10 - 'País' Incluindo Caracteres Especiais 
  - **Objetivo**: Verificar se o sistema impede a edição do campo País incluindo caracteres especiais.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'country' incluindo caracteres especiais e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request  
                          Exibição de mensagem de erro

  #### CT4.5.11 - 'País' incluindo números
  - **Objetivo**: Verificar se o sistema impede a edição do campo país incluindo números.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'country' incluindo números e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro  

  #### CT4.5.12 - 'CEP' incluindo caracteres especiais
  - **Objetivo**: Verificar se o sistema impede a edição do campo CEP incluindo caracteres especiais.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'zipCode' incluindo caracteres especiais e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro 

  #### CT4.5.13 - 'CEP' incluindo letras
  - **Objetivo**: Verificar se o sistema impede a edição do campo CEP incluindo letras.
  - **Prioridade**: Alta
  - **Passos**: Editar campo 'zipCode' incluindo letras e preencher os outros campos corretamente.
  - **Resultado esperado**: Status Code 400 - Bad request
                            Exibição de mensagem de erro  
---
## 5. Consultar empresa por ID 
  ### CN1: Consulta de empresa por ID com sucesso (Validação positiva)
  ####  CT5.1.1 - Buscar por um ID cadastrado no sistema
  - **Objetivo**: Realizar uma consulta por empresa a partir do ID.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição GET para o endpoint api/company/{id da empresa}
  - **Pré-condição**: Empresa deve estar cadastrada no sistema.
  - **Passos**: Enviar uma requisição usando um id válido.
  - **Resultado esperado**: Status Code 200 - OK
                            Exibição dos dados de cadastro da empresa

  ### CN2: Consulta de empresa por ID não realizada (Validação negativa)
    ####  CT5.2.1 - Buscar por um ID não existente no sistema
  - **Objetivo**: Validar a busca usando um id inexistente no sistema.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição GET para o endpoint api/company/{id da empresa}
  - **Pré-condição**: Empresa não deve estar cadastrada no sistema.
  - **Passos**: Enviar uma requisição usando um id inválido.
  - **Resultado esperado**: Status Code 400 - Solicitação inválida
                            Sistema deve retornar um erro ou mensagem informativa

  ####  CT5.2.2 - Buscar por um ID vazio ou nulo                      
  - **Objetivo**: Validar a busca usando id vazio ou nulo.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição GET para o endpoint api/company/{id vazio ou nulo}
  - **Pré-condição**: Empresa não deve estar cadastrada no sistema.
  - **Passos**: Enviar uma requisição usando um id vazio.
  - **Resultado esperado**: Status Code 500 - Solicitação inválida
                            Sistema deve retornar um erro ou mensagem informativa

---
## 6. Atualizar status da empresa 

  ### CN1 - Atualizar status da empresa para inativo com sucesso (Validação positiva)

  #### CT5.1.1 - Alterar o status da empresa para inativo
  - **Objetivo**: Alterar o status da empresa de ativo para inativo
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição PUT para o endpoint api/company/status/{id a empresa}
  - **Pré-condição**: Empresa deve estar cadastrada no sistema e ter perfil ativo.
  - **Passos**: Enviar uma requisição atualizando o status no body para inativo (false).
  - **Resultado esperado**: Status Code: 200 - OK
                            O status da empresa é alterado para inativo.
                            O sistema deve retornar uma mensagem de sucesso.
  ---
  ### CN2 - Atualizar status da empresa para ativo com sucesso (Validação positiva)

  #### CT5.2.1 - Alterar o status da empresa para ativo
  - **Objetivo**: Alterar o status da empresa de inativo para ativo
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição PUT para o endpoint api/company/status/{id a empresa}
  - **Pré-condição**: Empresa deve estar cadastrada no sistema e ter perfil inativo.
  - **Passos**: Enviar uma requisição atualizando o status no body para ativo (true).
  - **Resultado esperado**: Status Code: 200 - OK
                            O status da empresa é alterado para ativo.
                            O sistema deve retornar uma mensagem de sucesso.
  ---
  ### CN3 - Atualização do status da empresa negada (Validação negativa)

  #### CT5.3.1 - Alterar o status da empresa com valor inválido
  - **Objetivo**: Validar um cenário negativo em que o valor passado no body é inválido.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição PUT para o endpoint api/company/status/{id a empresa}
  - **Pré-condição**: Empresa deve estar cadastrada no sistema.
  - **Passos**: Enviar uma requisição atualizando o status no body com valor diferente de True ou false.
  - **Resultado esperado**: Status Code: 500
                            O status da empresa não é alterado.
                            O sistema deve retornar uma mensagem de erro.

  #### CT5.3.2 - Alterar o status de uma empresa com ID inexistente
  - **Objetivo**: Validar um cenário negativo de tentativa de alteração de status de uma empresa inexistente no sistema.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição PUT para o endpoint api/company/status/{id a empresa}
  - **Pré-condição**: Empresa não deve estar cadastrada no sistema.
  - **Passos**: Enviar uma requisição atualizando o status no body com valor True ou false.
  - **Resultado esperado**: Status Code: 400
                            O sistema deve retornar uma mensagem de erro.
---
## 7. Excluir cadastro de empresa 
  ### CN1: Cadastro de empresa deletado com sucesso (Validação positiva)

  #### CT7.1.1 - Excluir cadastro de empresa com sucesso
  - **Objetivo**: Validar a exclusão de um cadastro de empresa.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição DELETE para o endpoint api/company/{id da empresa}
  - **Pré-condição**: Empresa deve estar cadastrada no sistema.
  - **Passos**: Enviar uma requisição DELETE para o endpoint.
  - **Resultado esperado**: Status Code: 200 - OK
                            A empresa é deletada do sistema.
                            O sistema deve retornar uma mensagem de sucesso:"Companhia deletado com sucesso!."

  ### CN2: Cadastro de empresa não deletado (Validação negativa)

  #### CT6.2.1 - Excluir cadastro de empresa inexistente
  - **Objetivo**: Validar cenário negativo da exclusão de um cadastro de empresa.
  - **Prioridade**: Alta
  - **Localização**: Enviar uma requisição DELETE para o endpoint api/company/{id da empresa}
  - **Pré-condição**: Empresa não deve estar cadastrada no sistema.
  - **Passos**: Enviar uma requisição DELETE para o endpoint.
  - **Resultado esperado**: Status Code: 403 - Não encontrado
                            A empresa é deletada do sistema.
                            O sistema deve retornar uma mensagem de erro: "Essa companhia não existem em nossa base de dados."
