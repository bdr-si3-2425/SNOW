-- 1. Passage_Incident : Récupère les passages du trajet incident dans chaque gare
WITH Passage_Incident AS (
  SELECT 
    idGare,
    idLigne,
    idHoraire,
    heure_arrivee
  FROM Vue_Horaires_Gares
  WHERE idLigne = 1       -- Paramètre : Identifiant de la ligne affectée par l'incident
    AND idHoraire = 1    -- Paramètre : Identifiant de l'horaire concerné
),

-- 2. AlternativeRoutes : Pour chaque gare du trajet incident, identifie la ligne alternative
--    qui dessert cette gare (pour une correspondance directe) en évitant d'emprunter d'autres gares
--    de la ligne incident.
AlternativeRoutes AS (
  SELECT 
    PI.idGare,
    (
      SELECT AR.alternative_line
      FROM (
        SELECT T1.idLigne AS alternative_line, T1.idGare AS gare_depart, T2.idGare AS gare_arrivee
        FROM Traverse T1
        JOIN Traverse T2 
          ON T1.idLigne = T2.idLigne AND T1.rang < T2.rang
        WHERE T1.idLigne <> 1
          AND T1.idGare = PI.idGare
          AND T2.idGare IN (SELECT idGare FROM Traverse WHERE idLigne = 1)
        ORDER BY T1.rang
        LIMIT 1
      ) AS AR
    ) AS alternative_line
  FROM Passage_Incident PI
),

-- 3. NextTrain : Pour chaque gare du trajet incident, en se basant sur la ligne alternative
--    identifiée, trouve dans la vue Vue_Horaires_Gares le prochain train dont l'heure d'arrivée
--    est postérieure à celle du trajet incident.
NextTrain AS (
  SELECT 
    PI.idGare,
    AR.alternative_line,
    VH.idHoraire AS alternative_horaire,
    VH.heure_arrivee AS alternative_heure_arrivee,
    VH.heure_arrivee - PI.heure_arrivee AS delai
  FROM Passage_Incident PI
  JOIN AlternativeRoutes AR 
    ON PI.idGare = AR.idGare
  JOIN Vue_Horaires_Gares VH 
    ON VH.idLigne = AR.alternative_line 
   AND VH.idGare = PI.idGare
  WHERE VH.heure_arrivee > PI.heure_arrivee
)

-- 4. Sélection finale : Pour chaque gare du trajet incident, affiche le prochain train alternatif (si trouvé)
SELECT 
  PI.idGare,
  PI.heure_arrivee AS incident_heure_arrivee,
  NT.alternative_line,
  NT.alternative_horaire,
  NT.alternative_heure_arrivee,
  NT.delai AS delai_correspondance
FROM Passage_Incident PI
LEFT JOIN (
  -- Pour chaque gare, on prend l'alternative avec le délai minimal
  SELECT 
    idGare,
    alternative_line,
    alternative_horaire,
    alternative_heure_arrivee,
    MIN(delai) AS delai
  FROM NextTrain
  GROUP BY idGare, alternative_line, alternative_horaire, alternative_heure_arrivee
) NT ON PI.idGare = NT.idGare
ORDER BY PI.idGare;
