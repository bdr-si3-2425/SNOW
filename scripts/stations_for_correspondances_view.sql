CREATE VIEW Vue_Gares_Correspondance AS
SELECT idGare
FROM Traverse
GROUP BY idGare
HAVING COUNT(DISTINCT idLigne) > 1;