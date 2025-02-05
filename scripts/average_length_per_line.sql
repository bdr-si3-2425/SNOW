SELECT Ligne.idLigne , AVG(Trajet.dureeTrajet + COALESCE(Retard.duree_retard, '00:00:00')) duree_moyenne 
FROM Trajet JOIN Horaire ON Trajet.idHoraire = Horaire.idHoraire
JOIN Ligne ON Horaire.idLigne = Ligne.idLigne
LEFT JOIN Retard ON Trajet.idTrajet = Retard.idTrajet
GROUP BY Ligne.idLigne
ORDER BY duree_moyenne desc;