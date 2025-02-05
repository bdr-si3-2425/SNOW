SELECT 
    tr1.idTrajet AS trajet_depart, 
    tr2.idTrajet AS trajet_correspondance,
    tr1.date_trajet, 
    tr2.date_trajet, 
    EXTRACT(EPOCH FROM (h2.heure_depart - h1.heure_depart)) / 60 AS ecart_minutes
FROM 
    Trajet tr1
JOIN 
    Horaire h1 ON tr1.idHoraire = h1.idHoraire
JOIN 
    Trajet tr2 ON tr2.idHoraire = h1.idHoraire
JOIN 
    Horaire h2 ON tr2.idHoraire = h2.idHoraire
WHERE 
    h2.heure_depart > h1.heure_depart
ORDER BY 
    ecart_minutes ASC
LIMIT 10;
