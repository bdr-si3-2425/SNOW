SELECT 
    h.idLigne, 
    h.heure_depart, 
    COUNT(tr.idTrajet) AS nombre_trajets
FROM 
    Horaire h
JOIN 
    Trajet tr ON h.idHoraire = tr.idHoraire
GROUP BY 
    h.idLigne, h.heure_depart
ORDER BY 
    h.idLigne, nombre_trajets DESC;
