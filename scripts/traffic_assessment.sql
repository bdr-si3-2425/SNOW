-- 1. Extraire les arrivées par gare depuis la vue
WITH Arrivals AS (
  SELECT 
    idGare,
    heure_arrivee
  FROM Vue_Horaires_Gares
),

-- 2. Pour chaque arrivée, compter le nombre de trains arrivant dans les 60 minutes suivantes
CountIntervals AS (
  SELECT 
    A1.idGare,
    A1.heure_arrivee AS window_start,
    COUNT(*) AS nb_arrivals
  FROM Arrivals A1
  JOIN Arrivals A2 
    ON A1.idGare = A2.idGare 
    AND A2.heure_arrivee BETWEEN A1.heure_arrivee AND A1.heure_arrivee + INTERVAL '60 minutes'
  GROUP BY A1.idGare, A1.heure_arrivee
)

-- 3. Pour chaque gare, récupérer le maximum d'arrivées sur un intervalle de 60 minutes
SELECT 
  G.idGare,
  G.nom,
  G.nombre_de_quais,
  MAX(C.nb_arrivals) AS max_arrivals
FROM CountIntervals C
JOIN Gare G ON C.idGare = G.idGare
GROUP BY G.idGare, G.nom, G.nombre_de_quais
HAVING MAX(C.nb_arrivals) > G.nombre_de_quais
ORDER BY G.nom;
