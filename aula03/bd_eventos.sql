CREATE TABLE TipoEvento (
    idTipoEvento SERIAL PRIMARY KEY
);

CREATE TABLE Localizacao (
    idLocalizacao SERIAL PRIMARY KEY
);

CREATE TABLE Evento (
    idEvento SERIAL PRIMARY KEY,
    idTipoEvento INT NOT NULL,
    idLocalizacao INT NOT NULL,
    FOREIGN KEY (idTipoEvento) REFERENCES TipoEvento(idTipoEvento) ON DELETE CASCADE,
    FOREIGN KEY (idLocalizacao) REFERENCES Localizacao(idLocalizacao) ON DELETE CASCADE
);

CREATE TABLE Usuario (
    idUsuario SERIAL PRIMARY KEY
);

-- Relacionamento N:N entre Evento e Usuario via Relato
CREATE TABLE Relato (
    idRelato SERIAL PRIMARY KEY,
    idEvento INT NOT NULL,
    idUsuario INT NOT NULL,
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario) ON DELETE CASCADE
);

CREATE TABLE Alerta (
    idAlerta SERIAL PRIMARY KEY,
    idEvento INT NOT NULL,
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento) ON DELETE CASCADE
);
