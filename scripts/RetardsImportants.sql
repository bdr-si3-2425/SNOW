
CREATE VIEW retards_importants AS
SELECT idTrajet, AVG(duree_retard) AS retard_moyen
FROM Retard
GROUP BY idTrajet
HAVING AVG(duree_retard) > INTERVAL '30 minutes';

SELECT * FROM retards_importants
ORDER BY retard_moyen DESC;