CREATE VIEW Vue_Horaires_Gares AS
WITH RECURSIVE Cumul_Heure AS (
  -- Point de départ : une ligne commence son trajet à l’heure de départ du premier horaire
  SELECT 
    H.idLigne, 
    H.idHoraire,
    T.idGare,
    H.heure_depart AS heure_arrivee
  FROM Horaire H
  JOIN Traverse T ON H.idLigne = T.idLigne
  WHERE T.rang = 1  -- Sélectionne la première gare de la ligne

  UNION ALL

  -- Récursif : Ajoute les gares suivantes en accumulant la durée
  SELECT 
    CH.idLigne,
    CH.idHoraire,
    GS.idGare2 AS idGare,
    CH.heure_arrivee + GS.duree AS heure_arrivee
  FROM Cumul_Heure CH
  JOIN Gare_Successive GS 
    ON GS.idGare1 = CH.idGare  -- Suivi logique du trajet
  JOIN Traverse T ON T.idGare = GS.idGare2 AND T.idLigne = CH.idLigne
  WHERE CH.heure_arrivee IS NOT NULL  -- Assurer que l'heure d'arrivée est valide
)
SELECT DISTINCT * FROM Cumul_Heure;



select * from vue_horaires_gares;
