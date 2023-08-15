DROP DATABASE SisBanc;
-- Define o banco de dados a ser utilizado
CREATE DATABASE IF NOT EXISTS SisBanc;
USE SisBanc;
SET FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=1;

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS Clients (
  idClients INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100) NOT NULL,
  Data_nascim DATE,
  CPF CHAR(11) NOT NULL,
  Address VARCHAR(250),
  Phone VARCHAR(15),
  Email VARCHAR(250) NOT NULL,
  PasswordHash VARCHAR(100) NOT NULL,
  PRIMARY KEY (idClients),
  UNIQUE INDEX CPF_UNIQUE (CPF),
  UNIQUE INDEX Email_UNIQUE (Email)
) ENGINE = InnoDB;

-- Tabela de Contas Bancárias
CREATE TABLE IF NOT EXISTS BankAccounts (
  idAccounts INT NOT NULL AUTO_INCREMENT,
  AccountType VARCHAR(100),
  Balance DECIMAL(15, 2),
  CreditLimit DECIMAL(15, 2),
  ClientID INT,
  PRIMARY KEY (idAccounts),
  INDEX idx_ClientID (ClientID),
  FOREIGN KEY (ClientID) REFERENCES Clients (idClients)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Tabela de Transações
CREATE TABLE IF NOT EXISTS Transactions (
  idTransactions INT NOT NULL AUTO_INCREMENT,
  TransactionType VARCHAR(100),
  Amount DECIMAL(15, 2),
  DateTime DATETIME,
  AccountID INT,
  PRIMARY KEY (idTransactions),
  INDEX idx_AccountID (AccountID),
  FOREIGN KEY (AccountID) REFERENCES BankAccounts (idAccounts)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Tabela de Empréstimos
CREATE TABLE IF NOT EXISTS Loans (
  idLoans INT NOT NULL AUTO_INCREMENT,
  Amount DECIMAL(15, 2),
  ContracDate DATE,
  DueDate DATE,
  AccountID INT,
  PRIMARY KEY (idLoans),
  INDEX idx_AccountID (AccountID),
  FOREIGN KEY (AccountID) REFERENCES BankAccounts (idAccounts)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Tabela de Agências
CREATE TABLE IF NOT EXISTS Branches (
  idBranches INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(250) NOT NULL,
  Address VARCHAR(250),
  Phone VARCHAR(15),
  PRIMARY KEY (idBranches)
) ENGINE = InnoDB;

-- Tabela de Funcionários
CREATE TABLE IF NOT EXISTS Employees (
  idEmployees INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100) NOT NULL,
  Position VARCHAR(50),
  HireDate DATE,
  Salary DECIMAL(12, 2),
  idBranches INT,
  PRIMARY KEY (idEmployees),
  INDEX idx_idBranches (idBranches),
  FOREIGN KEY (idBranches) REFERENCES Branches (idBranches)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Tabela de Relação entre Contas Bancárias e Agências
CREATE TABLE IF NOT EXISTS BankAccounts_has_Branches (
  BankAccounts_idAccounts INT NOT NULL,
  Branches_idBranches INT NOT NULL,
  PRIMARY KEY (BankAccounts_idAccounts, Branches_idBranches),
  INDEX idx_Branches_idBranches (Branches_idBranches),
  INDEX idx_BankAccounts_idAccounts (BankAccounts_idAccounts),
  FOREIGN KEY (BankAccounts_idAccounts) REFERENCES BankAccounts (idAccounts)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (Branches_idBranches) REFERENCES Branches (idBranches)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Dados para Teste

-- Inserir dados na tabela Clients
INSERT INTO Clients (Name, Data_nascim, CPF, Address, Phone, Email, PasswordHash)
VALUES
  ('John Doe', '1985-05-15', '12345678901', '123 Main St, City', '555-1234', 'john.doe@example.com', 'hash123456'),
  ('Jane Smith', '1990-09-28', '98765432109', '456 Oak St, Town', '555-5678', 'jane.smith@example.com', 'hash789012');

-- Inserir dados na tabela BankAccounts
INSERT INTO BankAccounts (AccountType, Balance, CreditLimit, ClientID)
VALUES
  ('Savings', 5000.00, 1000.00, 1),
  ('Checking', 2500.00, 500.00, 2);

-- Inserir dados na tabela Transactions
INSERT INTO Transactions (TransactionType, Amount, DateTime, AccountID)
VALUES
  ('Debit', 100.00, '2023-08-10 10:15:00', 1),
  ('Credit', 200.00, '2023-08-11 14:30:00', 2);

-- Inserir dados na tabela Loans
INSERT INTO Loans (Amount, ContracDate, DueDate, AccountID)
VALUES
  (5000.00, '2023-07-01', '2023-12-31', 1);

-- Inserir dados na tabela Branches
INSERT INTO Branches (Name, Address, Phone)
VALUES
  ('Main Branch', '789 Elm St, City', '555-9876'),
  ('Downtown Branch', '321 Oak Ave, Downtown', '555-5432');

-- Inserir dados na tabela Employees
INSERT INTO Employees (Name, Position, HireDate, Salary, idBranches)
VALUES
  ('Michael Scott', 'Branch Manager', '2023-01-15', 60000.00, 1),
  ('Pam Beesly', 'Teller', '2023-02-20', 40000.00, 1);

-- Inserir dados na tabela BankAccounts_has_Branches
INSERT INTO BankAccounts_has_Branches (BankAccounts_idAccounts, Branches_idBranches)
VALUES
  (1, 1),
  (2, 2);
  
  -- Queries de teste:
  
  -- Consulta 1: Recupera o saldo atual de uma conta bancária específica
SELECT idAccounts, Balance
FROM BankAccounts
WHERE idAccounts = 1;

-- Consulta 2: Lista todas as transações de débito realizadas no mês atual
SELECT *
FROM Transactions
WHERE TransactionType = 'Debit'
  AND MONTH(DateTime) = MONTH(NOW())
  AND YEAR(DateTime) = YEAR(NOW());

-- Consulta 3: Calcula o saldo total de todas as contas bancárias de cada cliente
SELECT c.Name, SUM(b.Balance) AS TotalBalance
FROM Clients c
JOIN BankAccounts b ON c.idClients = b.ClientID
GROUP BY c.idClients, c.Name;

-- Consulta 4: Retorna a lista de empréstimos vencidos
SELECT *
FROM Loans
WHERE DueDate < CURDATE();

