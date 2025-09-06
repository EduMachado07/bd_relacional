INSERT INTO loja (nome, cidade) VALUES
('GameCenter', 'São Paulo'),
('PixelPlay', 'Rio de Janeiro'),
('LevelUp', 'Belo Horizonte');

INSERT INTO cliente (nome, email, cidade) VALUES
('Ana Silva', 'ana.silva@email.com', 'São Paulo'),
('Bruno Costa', 'bruno.costa@email.com', 'Rio de Janeiro'),
('Carla Mendes', 'carla.mendes@email.com', 'Belo Horizonte');

INSERT INTO jogo (titulo, ano_lancamento, genero) VALUES
('CyberQuest', 2021, 'Ação'),
('FantasyWorld', 2019, 'RPG'),
('SpeedRacer', 2022, 'Corrida');

INSERT INTO compra (data_compra, id_cliente, id_loja) VALUES
('2025-09-05', 1, 1),
('2025-09-06', 2, 2);

INSERT INTO compra_jogo (id_compra, id_jogo, quantidade) VALUES
(1, 1, 1),
(1, 3, 2);

INSERT INTO compra_jogo (id_compra, id_jogo, quantidade) VALUES
(2, 2, 1),
(2, 3, 1);
