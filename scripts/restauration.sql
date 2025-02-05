
SELECT G.nom AS "Gare", EG.nombre AS "Nombre de restaurants"
FROM Gare G
JOIN Equipement_de_Gare EG ON G.idGare = EG.idGare
JOIN Equipement E ON EG.idEquipement = E.IdEquipement
WHERE E.Descriptif = 'Restauration'
order by "Nombre de restaurants" DESC;