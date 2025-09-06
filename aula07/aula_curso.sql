create database bd_escola;
 
CREATE TABLE cursos (id_curso SERIAL PRIMARY KEY, nome VARCHAR(100) NOT NULL);
 
CREATE TABLE alunos (
    id_aluno SERIAL PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL, 
    idade INT, 
    id_curso INT REFERENCES cursos(id_curso));
 
CREATE TABLE notas (
    id_nota SERIAL PRIMARY KEY,
    disciplina VARCHAR(100) NOT NULL,
    nota FLOAT,
    id_aluno INT REFERENCES alunos(id_aluno)
);
 
INSERT INTO cursos (nome) VALUES ('Engenharia');
INSERT INTO cursos (nome) VALUES ('Análise de Sistemas'), ('Computação'), ('Matemática');
 
INSERT INTO alunos (nome, idade, id_curso) 
VALUES ('João Silva', 22, 1);
 
INSERT INTO alunos (nome, idade, id_curso) 
VALUES 
  ('Marina Lima', 16, 3), 
  ('Maria Souza', 20, 3), 
  ('Carlos Lima', 25, 4), 
  ('Lucas Pereira', 18, 3);
 
INSERT INTO notas (id_nota, id_aluno, disciplina, nota) 
VALUES 
  (101, 1, 'Matemática', 8.5),
  (102, 2, 'História', 9.0);
 
UPDATE alunos SET idade = 16 WHERE nome = 'João Silva’;
UPDATE alunos SET idade = 17, id_curso = 1 WHERE nome = 'Marina Lima’;
 
Select * from cursos;
Select * from alunos;
 
SELECT 
    a.nome AS aluno,
    c.nome AS curso
FROM alunos a
INNER JOIN cursos c ON a.id_curso = c.id_curso
ORDER BY a.nome;
 
 
 
- Conta Bancaria -
 
CREATE TABLE clientes (
id_cliente SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL,
endereco TEXT,
telefone VARCHAR(15)
);
 
INSERT INTO clientes (nome, cpf, endereco, telefone) VALUES
('Carlos Lima', '11122233344', 'Rua C, 789', '11977776666'),
('Ana Souza', '55566677788', 'Rua D, 101', '11966665555'),
('Lucas Pereira', '99988877766', 'Rua E, 202', '11955554444'),
('Fernanda Rocha', '44433322211', 'Rua F, 303', '11944443333'),
('Pedro Santos', '22233344455', 'Rua G, 404', '11933332222');
 
CREATE TABLE contas (
id_conta SERIAL PRIMARY KEY,
numero_conta VARCHAR(10) UNIQUE NOT NULL,
saldo DECIMAL(10,2) DEFAULT 0,
id_cliente INT REFERENCES clientes(id_cliente) ON DELETE CASCADE
)
 
INSERT INTO contas (numero_conta, saldo, id_cliente) VALUES
('000789', 1200.50, 3),
('000321', 5000.00, 4),
('000654', 320.75, 5),
('000987', 750.00, 1),
('001234', 4100.00, 2),
('001567', 980.25, 3),
('001890', 150.00, 4),
('002123', 2750.00, 5);
 
CREATE TABLE transacoes (
id_transacao SERIAL PRIMARY KEY,
id_conta INT REFERENCES contas(id_conta) ON DELETE CASCADE,
tipo VARCHAR(15) CHECK (tipo IN ('Depósito', 'Saque', 'Transferência')),
valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
data_transacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
destino_transferencia INT REFERENCES contas(id_conta)
);
 
INSERT INTO transacoes (id_conta, tipo, valor) VALUES
(3, 'Transferência', 300.00),
(4, 'Saque', 1000.00),
(5, 'Depósito', 150.50),
(1, 'Saque', 200.00),
(2, 'Depósito', 400.00),
(3, 'Saque', 50.00),
(4, 'Depósito', 750.00),
(5, 'Saque', 120.00),
(1, 'Depósito', 1000.00),
(2, 'Saque', 300.00);
 
SELECT * FROM clientes;
 
SELECT contas.numero_conta, clientes.nome, contas.saldo
FROM contas 
INNER JOIN clientes ON contas.id_cliente = clientes.id_cliente;
 
SELECT transacoes.tipo, transacoes.valor, transacoes.data_transacao, 
contas.numero_conta AS origem, 
c2.numero_conta AS destino
FROM transacoes
INNER JOIN contas ON transacoes.id_conta = contas.id_conta
LEFT JOIN contas c2 ON transacoes.destino_transferencia = c2.id_conta;
 
UPDATE contas
SET saldo = saldo + 500.00 
WHERE id_conta = 1;
 
DELETE FROM clientes WHERE id_cliente = 2;
 
- Atividade Prática -
 
INSERT INTO clientes (nome, cpf, endereco, telefone) 
VALUES ('Mariana Lima', '33322211144', 'Rua H, 505', '11922223333');
 
INSERT INTO contas (numero_conta, saldo, id_cliente) 
VALUES ('002456', 0.00, (SELECT id_cliente FROM clientes WHERE cpf = '33322211144'));
 
INSERT INTO transacoes (id_conta, tipo, valor, destino_transferencia)
VALUES (
    (SELECT id_conta FROM contas WHERE numero_conta = '000123'),
    'Transferência',
    100.00,
    (SELECT id_conta FROM contas WHERE numero_conta = '000789')
);
 
UPDATE contas
SET saldo = saldo - 100.00
WHERE numero_conta = '000123';
 
UPDATE contas
SET saldo = saldo + 100.00
WHERE numero_conta = '000789';
 
SELECT 
    contas.numero_conta, 
    clientes.nome, 
    contas.saldo
FROM contas
INNER JOIN clientes ON contas.id_cliente = clientes.id_cliente
ORDER BY contas.numero_conta;
