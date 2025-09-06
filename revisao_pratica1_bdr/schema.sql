CREATE TABLE loja (
    id_loja INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL
);

CREATE TABLE jogo (
    id_jogo INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    ano_lancamento INT NOT NULL,
    genero VARCHAR(50) NOT NULL
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cidade VARCHAR(100) NOT NULL
);

CREATE TABLE compra (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    data_compra DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_loja INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_loja) REFERENCES loja(id_loja)
);

CREATE TABLE compra_jogo (
    id_compra INT NOT NULL,
    id_jogo INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_compra, id_jogo),
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra),
    FOREIGN KEY (id_jogo) REFERENCES jogo(id_jogo)
);
