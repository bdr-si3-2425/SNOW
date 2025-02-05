
SELECT 
    Tech.nom || ' ' || Tech.prenom AS "Technicien",
    COUNT(M.idMaintenance) AS "Nombre d'interventions",
    ARRAY_AGG(DISTINCT M.idTrain) AS "Trains concernés"
FROM Technicien Tech
LEFT JOIN Maintenance M ON Tech.idTechnicien = M.idTechnicien
GROUP BY Tech.idTechnicien
ORDER BY 2 DESC NULLS LAST;