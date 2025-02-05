SELECT 
    AVG(EXTRACT(EPOCH FROM r.duree_retard) / 60) AS retard_moyen_minutes
FROM 
    Retard r
JOIN 
    Trajet t ON r.idTrajet = t.idTrajet
WHERE 
    t.date_trajet BETWEEN '2025-02-01' AND '2025-02-03';
