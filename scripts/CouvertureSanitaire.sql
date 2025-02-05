SELECT g.nom, COALESCE(eg.nombre, 0) AS nombre_toilettes
FROM Gare g
LEFT JOIN Equipement_de_Gare eg ON g.idGare = eg.idGare AND eg.idEquipement = 3
ORDER BY nombre_toilettes DESC;