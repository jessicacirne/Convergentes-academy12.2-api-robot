# Feature: Company

## Itens do backlog:

1. **Novo cadastro de empresas** 
    **Descrição**:
        Eu, como PO;
        Quero um cadastro de empresa;
        Para que possa realizar o acesso ao sistema por empresa.

    **Critérios de aceitação**:
        **Nome da empresa**: Nome da empresa.  
            i. Campo obrigatório.  
            ii. Alfanumérico.  
            iii. Não permitir duplicidade.  
            iv. O campo deve permitir no máximo 100 caracteres.  
        **CNPJ**: Número de registro nacional da empresa.  
            i. Campo obrigatório.  
            ii. Somente números.  
            iii. Não permitir duplicidade.  
            iv. O campo deve ter máscara (##.###.###/####-##), com 14 dígitos.  
            v. Deve ter validador.  
        **Razão Social**: Nome completo da empresa registrado nos órgãos competentes.  
            i. Campo obrigatório.  
            ii. Alfanumérico.  
            iii. Não permitir duplicidade.  
            iv. Máximo de 100 caracteres.  
        **Contato Responsável**  
            i. Campo obrigatório.  
            ii. Somente letras.  
            iii. Máximo de 100 caracteres.  
            iv. O campo deve ter no mínimo duas palavras compostas.  
        **Telefone**: Número(s) de telefone(s) de contato da empresa.  
            i. Campo obrigatório.  
            ii. Somente números.  
            iii. Apenas números brasileiros.  
            iv. Deve ter máscara (###)-(###)-(#####-####).  
            v. Máximo de 15 caracteres (20 para números internacionais).  
        **E-mail**: Endereço de e-mail da empresa.  
            i. Campo obrigatório.  
            ii. Formato: nome@dominio.com, nome@dominio.com.br ou outros domínios válidos ([Lista de TLDs](https://pt.wikipedia.org/wiki/Lista_de_TLDs)).  
        **Descrição**: Informações sobre o negócio.  
            i. Campo obrigatório.  
            ii. Alfanumérico.  
        **Logradouro (Endereço)**  
            i. Campo obrigatório.  
            ii. Alfanumérico.  
            iii. Pode conter caracteres especiais 'ª', 'º', '‘' e '-'.  
            iv. Máximo de 50 caracteres.  
        **Número**  
            i. Campo obrigatório.  
            ii. Deve conter apenas números.  
            iii. Máximo de 10 caracteres.  
        **Complemento**  
            i. Campo não obrigatório.  
            ii. Alfanumérico.  
            iii. Pode conter caracteres especiais 'ª', 'º', '‘' e '-'.  
            iv. Máximo de 80 caracteres.  
        **Bairro**  
            i. Campo obrigatório.  
            ii. Alfanumérico.  
            iii. Pode conter caracteres especiais 'ª', 'º', '‘' e '-'.  
            iv. Máximo de 50 caracteres.  
        **Cidade**  
            i. Campo obrigatório.  
            ii. Somente letras.  
            iii. Pode conter caracteres especiais 'ª', 'º', '‘' e '-'.  
            iv. Máximo de 50 caracteres.  
        **Estado**  
            i. Campo obrigatório.  
            ii. Somente letras.  
            iii. Máximo de 2 caracteres (exemplo: SP).  
        **País**  
            i. Campo obrigatório.  
            ii. Somente letras.  
            iii. Máximo de 50 caracteres.  
        **CEP**  
            i. Campo obrigatório.  
            ii. Somente números.  
            iii. Deve ter máscara (#####-###).

    **Regras de Negócio**:
        **Verificação de Duplicidade:**  
            i. Garantir que não existam empresas cadastradas com o mesmo CNPJ.  
        **Acesso Restrito:**  
            i. Garantir que apenas usuários autorizados, com perfil de **Admin**, possam cadastrar novas empresas.  
            ii. O acesso deve ser controlado com base em permissões de acesso definidas no sistema.  
        **Botão Salvar:**  
            i. Ao clicar no botão "Salvar":  
            ii. Se algum campo obrigatório não estiver preenchido, deve ser exibida a mensagem: `"O campo (nome_campo) é obrigatório"`.  
            iii. Se todos os campos obrigatórios estiverem preenchidos, deve ser exibida a mensagem: `"Registro realizado com sucesso"`.  
        **Botão Cancelar:**  
            i. Ao clicar no botão "Cancelar":  
            ii. Se os campos estiverem preenchidos, deve ser exibida a mensagem: `"Se você sair sem salvar, todos os dados serão perdidos. Deseja cancelar?"`, com as opções de botões "SIM" ou "NÃO".  
            iii. Se nenhuma alteração tiver sido realizada, o formulário deve ser simplesmente fechado.  

2. **Lista cadastro de empresas** => *To Do*

3. **Editar cadastro de empresas**
    **Descrição**:
        Eu, como PO,  
        Quero que seja desenvolvida uma funcionalidade para editar o cadastro de empresa,  
        Para que os dados possam ser alterados de acordo com a necessidade do usuário.
    
    **Critérios de aceitação**:
        **Nome da empresa**: Nome da empresa.  
            i. Campo obrigatório.  
            ii. Alfanumérico.  
            iii. Não permitir duplicidade.  
            iv. O campo deve permitir no máximo 100 caracteres.  
        **CNPJ**: Número de registro nacional da empresa.  
            i. Campo obrigatório.  
            ii. Somente números.  
            iii. Não permitir duplicidade.  
            iv. O campo deve ter máscara (##.###.###/####-##), com 14 dígitos.  
            v. Deve ter validador.  
        **Razão Social**: Nome completo da empresa registrado nos órgãos competentes.  
            i. Campo obrigatório.  
            ii. Alfanumérico.  
            iii. Não permitir duplicidade.  
            iv. Máximo de 100 caracteres.  
        **Contato Responsável**  
            i. Campo obrigatório.  
            ii. Somente letras.  
            iii. Máximo de 100 caracteres.  
            iv. O campo deve ter no mínimo duas palavras compostas.  
        **Telefone**: Número(s) de telefone(s) de contato da empresa.  
            i. Campo obrigatório.  
            ii. Somente números.  
            iii. Apenas números brasileiros.  
            iv. Deve ter máscara (###)-(###)-(#####-####).  
            v. Máximo de 15 caracteres (20 para números internacionais).  
        **E-mail**: Endereço de e-mail da empresa.  
            i. Campo obrigatório.  
            ii. Formato: nome@dominio.com, nome@dominio.com.br ou outros domínios válidos ([Lista de TLDs](https://pt.wikipedia.org/wiki/Lista_de_TLDs)).  
        **Descrição**: Informações sobre o negócio.  
            i. Campo obrigatório.  
            ii. Alfanumérico.  

4. **Editar dados de endereço da empresa** => *To Do*

5. **Consultar empresa por ID**
    **Critérios de aceitação**:
        i. Dados corretos: A consulta deve retornar todos os dados da empresa correspondente ao ID informado.
        ii. Tratamento de erros:
            - Se a empresa não for encontrada, a consulta deve retornar um erro ou mensagem informativa.
            - Se ocorrerem outros erros (como problemas de conexão com o banco de dados), o sistema deve lidar com eles de forma adequada.
    
    **Regras de negócio**:
        i. Unicidade do ID: Cada empresa possui um ID único que a identifica no sistema.

6. **Atualizar o status da empresa**
    **Critérios de aceitação**:
        i. O campo necessário para atualizar o status da empresa deve armazenar um booleano `true` (ativo) ou `false` (inativo).

    **Regras de negócio**:
        Alteração de Status: O sistema deve permitir que um usuário autorizado altere o status de uma empresa para ativo ou inativo.
        Valores Permitidos: Os únicos valores válidos para o campo status são `true` e `false`.

7. **Excluir cadastro de empresa**
    **Critérios de aceitação**:
        i. A empresa deve ser excluída do banco de dados, incluindo todas as suas informações relacionadas.
        ii. O sistema deve retornar a mensagem: "Companhia deletada com sucesso."
        iii. Tratamento de erros: Se a empresa não existir, o sistema deve retornar a mensagem de erro: "Essa companhia não existe em nossa base de dados."

    - **Regras de negócio**:
        Unicidade do ID: Cada empresa possui um ID único que a identifica no sistema.


