# Sistema Bancário - Projeto de Banco de Dados

Este é um projeto de modelagem de banco de dados para um sistema bancário fictício. O projeto inclui a criação das tabelas necessárias para o funcionamento do sistema, como Clientes, Contas Bancárias, Transações, Empréstimos, Agências, Funcionários e Relações entre Tabelas.

## Modelagem do Banco de Dados

O banco de dados é composto pelas seguintes tabelas:

- **Clients**: Armazena informações sobre os clientes, como nome, CPF, endereço, telefone, e-mail, entre outros.

- **BankAccounts**: Contém informações sobre as contas bancárias, como tipo de conta, saldo, limite de crédito e relacionamento com os clientes.

- **Transactions**: Registra as transações realizadas nas contas bancárias, incluindo o tipo de transação, valor e data/hora.

- **Loans**: Armazena informações sobre os empréstimos, como valor, datas de contrato e vencimento, e relação com as contas bancárias.

- **Branches**: Mantém detalhes sobre as agências bancárias, como nome, endereço e telefone.

- **Employees**: Registra informações sobre os funcionários, incluindo nome, cargo, data de contratação, salário e relação com as agências.

- **BankAccounts_has_Branches**: Estabelece a relação entre contas bancárias e agências.

## Como Usar

1. Clone este repositório para o seu ambiente local.
2. Execute os comandos SQL presentes no arquivo `.sql` para criar o esquema do banco de dados e inserir os dados de teste.
3. Utilize as consultas de exemplo ou crie suas próprias consultas para analisar os dados.

