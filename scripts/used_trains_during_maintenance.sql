SELECT Maintenance.idTrain, Trajet.date_trajet, Maintenance.date_maintenance
FROM Maintenance JOIN Trajet ON Maintenance.idTrain = Trajet.idTrain
WHERE date_trajet = date_maintenance;