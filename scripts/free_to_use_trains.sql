SELECT idTrain FROM Train
where NOT EXISTS (
SELECT idTrain FROM Trajet 
where trajet.idTrain = Train.idTrain
and Trajet.date_trajet >= '2025-02-01'
UNION ALL
SELECT idTrain FROM Maintenance
where Maintenance.idTrain = Train.idTrain
UNION ALL
SELECT idTrain FROM Train t
where t.en_service = FALSE
and t.idTrain = Train.idTrain
);