SELECT Train.idTrain, Count(Retard.idRetard) nombre_retards, COALESCE(Sum(Retard.duree_Retard), '00:00:00') retard_total
FROM Train LEFT JOIN Trajet ON Train.idTrain = Trajet.idTrain
LEFT JOIN Retard ON Trajet.idTrajet = Retard.idRetard 
GROUP BY Train.idTrain
ORDER BY nombre_retards ASC, retard_total ASC, idTrain ASC;