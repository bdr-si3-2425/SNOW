BEGIN;

CREATE OR REPLACE FUNCTION update_train_status_after_maintenance()
RETURNS void AS $$
BEGIN
  UPDATE Train T
  SET en_service = TRUE
  FROM Maintenance M
  WHERE T.idTrain = M.idTrain
    -- La date actuelle est au moins égale au lendemain de la date de maintenance
    AND CURRENT_DATE >= M.date_maintenance + INTERVAL '1 day'
    -- N'actualiser que si le train est actuellement en maintenance
    AND T.en_service = FALSE;
END;
$$ LANGUAGE plpgsql;

COMMIT;

--créer un job qui va exécuter la fonction à des intervalles réguliers
-- sur Linux utiliser pg_cron et sur Windows utiliser pg_agent







