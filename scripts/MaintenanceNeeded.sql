

WITH MaintenanceNeeded AS (
    SELECT 
        t.idTrain,
        SUM(EXTRACT(EPOCH FROM tr.dureeTrajet)/3600) AS heures_utilisation,
        COUNT(DISTINCT r.idRetard) FILTER (WHERE r.idIncident IS NOT NULL) AS nb_incidents
    FROM Train t
    LEFT JOIN Trajet tr ON t.idTrain = tr.idTrain
    LEFT JOIN Retard r ON tr.idTrajet = r.idTrajet
    LEFT JOIN Maintenance m ON t.idTrain = m.idTrain
    GROUP BY t.idTrain
)
SELECT 
    t.*,
    mn.heures_utilisation,
    mn.nb_incidents,
    CASE 
        WHEN mn.heures_utilisation > 50 OR mn.nb_incidents >= 2 THEN 'Maintenance urgente'
        WHEN mn.heures_utilisation BETWEEN 20 AND 50 THEN 'Maintenance préventive'
        ELSE 'Maintenance non nécessaire'
    END AS priorite
FROM Train t
JOIN MaintenanceNeeded mn ON t.idTrain = mn.idTrain
WHERE mn.heures_utilisation > 20 OR mn.nb_incidents >= 2
ORDER BY mn.heures_utilisation DESC; 