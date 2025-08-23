-- Listar os ultimos cinco eventos criados (ordenados pela data mais recente)
SELECT e.idEvento, e.titulo, e.dataHora, te.nomeTipoEvento, l.cidade
FROM Evento e
JOIN TipoEvento te ON e.idTipoEvento = te.idTipoEvento
JOIN Localizacao l ON e.idLocalizacao = l.idLocalizacao
ORDER BY e.dataHora DESC
LIMIT 5;
-- Mostrar os ultimos relatos feitos, com nome do usuario e evento
SELECT r.idRelato, u.nome AS usuario, e.titulo AS evento, r.comentario, r.dataHora
FROM Relato r
JOIN Usuario u ON r.idUsuario = u.idUsuario
JOIN Evento e ON r.idEvento = e.idEvento
ORDER BY r.dataHora DESC
LIMIT 5;
-- Exibir os alertas mais recentes por evento
SELECT a.idAlerta, e.titulo AS evento, a.mensagem, a.dataHora
FROM Alerta a
JOIN Evento e ON a.idEvento = e.idEvento
ORDER BY a.dataHora DESC
LIMIT 3;
-- Consultar o historico de um evento especifico ordenado por data
SELECT h.idHistorico, e.titulo, u.nome AS usuario, h.acao, h.dataHora
FROM HistoricoEvento h
JOIN Evento e ON h.idEvento = e.idEvento
LEFT JOIN Usuario u ON h.idUsuario = u.idUsuario
WHERE h.idEvento = 1
ORDER BY h.dataHora ASC;
-- Listar os tres usuarios que mais fizeram relatos
SELECT u.nome, COUNT(r.idRelato) AS total_relatos
FROM Relato r
JOIN Usuario u ON r.idUsuario = u.idUsuario
GROUP BY u.nome
ORDER BY total_relatos DESC
LIMIT 3;
-- Listar os eventos futuros mais proximos (agenda)
SELECT e.titulo, e.descricao, e.dataHora, l.cidade
FROM Evento e
JOIN Localizacao l ON e.idLocalizacao = l.idLocalizacao
WHERE e.dataHora > NOW()
ORDER BY e.dataHora ASC
LIMIT 5;
