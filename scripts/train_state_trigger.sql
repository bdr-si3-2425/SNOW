CREATE OR REPLACE FUNCTION trg_check_train_not_in_maintenance()
RETURNS trigger AS $$
DECLARE
    train_status BOOLEAN;
BEGIN
    -- Récupère le statut du train dans la table Train
    SELECT en_service INTO train_status 
    FROM Train 
    WHERE idTrain = NEW.idTrain;
    
    -- Si le train n'est pas en service, lève une exception
    IF train_status IS NOT TRUE THEN
        RAISE EXCEPTION 'Le train % est en maintenance et ne peut être affecté à un trajet', NEW.idTrain;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Création du trigger sur la table Trajet, avant INSERT ou UPDATE
CREATE TRIGGER check_train_not_in_maintenance_trigger
BEFORE INSERT OR UPDATE ON Trajet
FOR EACH ROW
EXECUTE FUNCTION trg_check_train_not_in_maintenance();
