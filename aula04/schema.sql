-- Tipo de Evento
CREATE TABLE TipoEvento (
    idTipoEvento SERIAL PRIMARY KEY,
    nomeTipoEvento VARCHAR(100) NOT NULL
);
-- Localização
CREATE TABLE Localizacao (
    idLocalizacao SERIAL PRIMARY KEY,
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    estado CHAR(2)
);
-- Usuário
CREATE TABLE Usuario (
    idUsuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);
-- Categoria de Usuário
CREATE TABLE CategoriaUsuario (
    idCategoria SERIAL PRIMARY KEY,
    nomeCategoria VARCHAR(50) NOT NULL
);
-- Vincula usuário à categoria
ALTER TABLE Usuario
ADD COLUMN idCategoria INT NOT NULL DEFAULT 1,
ADD CONSTRAINT fk_usuario_categoria FOREIGN KEY (idCategoria) REFERENCES CategoriaUsuario(idCategoria) ON DELETE SET DEFAULT;
-- Evento
CREATE TABLE Evento (
    idEvento SERIAL PRIMARY KEY,
    idTipoEvento INT NOT NULL,
    idLocalizacao INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT,
    dataHora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idTipoEvento) REFERENCES TipoEvento(idTipoEvento) ON DELETE CASCADE,
    FOREIGN KEY (idLocalizacao) REFERENCES Localizacao(idLocalizacao) ON DELETE CASCADE
);
-- Relato (N:N entre Evento e Usuario)
CREATE TABLE Relato (
    idRelato SERIAL PRIMARY KEY,
    idEvento INT NOT NULL,
    idUsuario INT NOT NULL,
    comentario TEXT,
    dataHora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario) ON DELETE CASCADE
);
-- Alerta
CREATE TABLE Alerta (
    idAlerta SERIAL PRIMARY KEY,
    idEvento INT NOT NULL,
    mensagem TEXT,
    dataHora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento) ON DELETE CASCADE
);
-- Histórico de Eventos
CREATE TABLE HistoricoEvento (
    idHistorico SERIAL PRIMARY KEY,
    idEvento INT NOT NULL,
    idUsuario INT,
    acao VARCHAR(255) NOT NULL,
    dataHora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario) ON DELETE SET NULL
);
-- Inserindo categorias de usuário
INSERT INTO CategoriaUsuario (nomeCategoria) VALUES 
('Administrador'),
('Moderador'),
('Comum');
-- Inserindo usuários
INSERT INTO Usuario (nome, email, idCategoria) VALUES
('Eduardo Silva', 'eduardo@email.com', 1),
('Ana Costa', 'ana@email.com', 2),
('Lucas Pereira', 'lucas@email.com', 3);
-- Inserindo tipos de evento
INSERT INTO TipoEvento (nomeTipoEvento) VALUES
('Crítico'),
('Alerta'),
('Informativo');
-- Inserindo localizações
INSERT INTO Localizacao (endereco, cidade, estado) VALUES
('Rua A, 123', 'São José dos Campos', 'SP'),
('Av. Brasil, 456', 'São Paulo', 'SP'),
('Rua Central, 789', 'Campinas', 'SP');
-- Inserindo eventos
INSERT INTO Evento (idTipoEvento, idLocalizacao, titulo, descricao, dataHora) VALUES
(1, 1, 'Falha no Servidor', 'O servidor principal caiu e precisa de atenção imediata.', '2025-08-19 10:00:00'),
(2, 2, 'Manutenção Programada', 'Haverá manutenção do sistema das 22h às 23h.', '2025-08-20 22:00:00'),
(3, 3, 'Reunião Informativa', 'Reunião sobre novos procedimentos internos.', '2025-08-21 14:00:00');
-- Inserindo relatos
INSERT INTO Relato (idEvento, idUsuario, comentario) VALUES
(1, 1, 'Verifiquei o problema no servidor, encaminhando equipe técnica.'),
(2, 2, 'Informei todos os usuários sobre a manutenção.'),
(3, 3, 'Presente na reunião e tomei notas.');
-- Inserindo alertas
INSERT INTO Alerta (idEvento, mensagem) VALUES
(1, 'Servidor fora do ar!'),
(2, 'Sistema em manutenção, evite acessos.'),
(3, 'Reunião iniciando em 30 minutos.');
-- Inserindo histórico de eventos
INSERT INTO HistoricoEvento (idEvento, idUsuario, acao, dataHora) VALUES
(1, 1, 'Evento criado', '2025-08-19 09:50:00'),
(1, 1, 'Equipe técnica acionada', '2025-08-19 10:05:00'),
(2, 2, 'Evento criado', '2025-08-19 11:00:00'),
(3, 3, 'Evento criado', '2025-08-19 12:00:00');


