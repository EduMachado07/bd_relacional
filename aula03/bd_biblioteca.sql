CREATE TABLE Autor (
    idAutor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

CREATE TABLE Livro (
    idLivro SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    anoPublicacao INT,
    isbn VARCHAR(20) UNIQUE
);

-- Tabela associativa para relacionamento N:N entre Livro e Autor
CREATE TABLE LivroAutor (
    idLivro INT,
    idAutor INT,
    PRIMARY KEY (idLivro, idAutor),
    FOREIGN KEY (idLivro) REFERENCES Livro(idLivro) ON DELETE CASCADE,
    FOREIGN KEY (idAutor) REFERENCES Autor(idAutor) ON DELETE CASCADE
);

CREATE TABLE Cliente (
    idCliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE Emprestimo (
    idEmprestimo SERIAL PRIMARY KEY,
    dataEmprestimo DATE NOT NULL,
    dataDevolucao DATE,
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);

-- Tabela associativa para relacionamento N:N entre Emprestimo e Livro
CREATE TABLE EmprestimoLivro (
    idEmprestimo INT,
    idLivro INT,
    PRIMARY KEY (idEmprestimo, idLivro),
    FOREIGN KEY (idEmprestimo) REFERENCES Emprestimo(idEmprestimo) ON DELETE CASCADE,
    FOREIGN KEY (idLivro) REFERENCES Livro(idLivro) ON DELETE CASCADE
);
