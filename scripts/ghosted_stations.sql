-- Définir la période recherchée (par exemple, du 1er janvier 2024 au 31 janvier 2024)
WITH LignesSansTrajet AS (
  SELECT L.idLigne
  FROM Ligne L
  WHERE NOT EXISTS (
    SELECT 1
    FROM Trajet TR
    JOIN Horaire H ON TR.idHoraire = H.idHoraire
    WHERE H.idLigne = L.idLigne
      AND TR.date_trajet BETWEEN '2024-01-01' AND '2024-01-31'
  )
)
SELECT G.idGare,
       G.nom,
       L.idLigne,
       L.nomLigne
FROM Traverse T
JOIN Gare G ON T.idGare = G.idGare
JOIN Ligne L ON T.idLigne = L.idLigne
WHERE L.idLigne IN (SELECT idLigne FROM LignesSansTrajet)
ORDER BY L.idLigne, G.idGare;
