
SELECT 
    h.idLigne, 
    h.heure_depart, 
    COUNT(tr.idTrajet) AS nombre_trajets
FROM 
    Horaire h
JOIN 
    Trajet tr ON h.idHoraire = tr.idHoraire
GROUP BY 
    h.idLigne, h.heure_depart;

-- Utilisation de la vue
SELECT * 
FROM HorairesFrequentation
ORDER BY idLigne, nombre_trajets DESC;
