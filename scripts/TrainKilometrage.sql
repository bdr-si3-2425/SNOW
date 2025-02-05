SELECT 
    t.idTrain,
    t.capacite,
    ROUND(COALESCE(SUM(l.longueur_totale), 0)::numeric, 2) AS total_km
FROM Train t
LEFT JOIN Trajet tr ON t.idTrain = tr.idTrain
LEFT JOIN Horaire h ON tr.idHoraire = h.idHoraire
LEFT JOIN Ligne l ON h.idLigne = l.idLigne
GROUP BY t.idTrain, t.capacite
ORDER BY total_km DESC;