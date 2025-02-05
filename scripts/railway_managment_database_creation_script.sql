begin;

-- Table Gare
CREATE TABLE Gare (
    idGare INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    code_postal VARCHAR(10) NOT NULL,
    nombre_de_quais INT NOT NULL CHECK (nombre_de_quais > 0)
);

-- Table Equipement
CREATE TABLE Equipement (
	IdEquipement INT PRIMARY KEY,
	Descriptif VARCHAR(100) NOT NULL
);

-- Table pour le suivi du nombre d'un genre d'Equipement dans une Gare
CREATE TABLE Equipement_de_Gare (
	idGare INT NOT NULL,
	idEquipement INT NOT NULL,
	nombre INT NOT NULL CHECK ( nombre > 0 ),
	primary key(idGare, idEquipement),
	FOREIGN KEY (idGare) REFERENCES Gare(idGare) on delete cascade,
	FOREIGN KEY (idEquipement) REFERENCES Equipement(idEquipement) on delete cascade
);

-- Table Gare_Successive (Relation entre gares)
CREATE TABLE Gare_Successive (
    idGare1 INT,
    idGare2 INT,
    distance FLOAT CHECK (distance > 0),
    duree INTERVAL NOT NULL,
    PRIMARY KEY (idGare1, idGare2),
    FOREIGN KEY (idGare1) REFERENCES Gare(idGare) ON DELETE CASCADE,
    FOREIGN KEY (idGare2) REFERENCES Gare(idGare) ON DELETE CASCADE
);

-- Table Ligne
CREATE TABLE Ligne (
    idLigne INT PRIMARY KEY,
    nomLigne VARCHAR(100) NOT NULL,
    longueur_totale FLOAT CHECK (longueur_totale > 0)
);

-- Table pour l'ordre de passage d'une Ligne dans des Gare
CREATE TABLE Traverse (
    idLigne INT,
    idGare INT,
    rang INT NOT NULL CHECK (rang > 0),
    PRIMARY KEY (idLigne, idGare, rang),
    FOREIGN KEY (idLigne) REFERENCES Ligne(idLigne) ON DELETE CASCADE,
    FOREIGN KEY (idGare) REFERENCES Gare(idGare) ON DELETE CASCADE
);

-- Table Horaire
CREATE TABLE Horaire (
    idHoraire SERIAL PRIMARY KEY,
    idLigne INT NOT NULL,
    sens CHAR(1) NOT NULL CHECK (sens IN ('A', 'R')), -- Indique le sens du trajet A : aller, R : retour
    heure_depart TIME NOT NULL,
    FOREIGN KEY (idLigne) REFERENCES Ligne(idLigne) ON DELETE CASCADE
);

-- Table Train
CREATE TABLE Train (
    idTrain SERIAL PRIMARY KEY,
    capacite INT CHECK (capacite > 0),
    date_de_mise_en_service date not null,
    en_service BOOLEAN DEFAULT TRUE -- Indique si le train est en service ou en maintenance
);

-- Table Technicien
CREATE TABLE Technicien (
    idTechnicien INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    contact VARCHAR(50) NOT NULL
);

-- Table Maintenance
CREATE TABLE Maintenance (
    idMaintenance SERIAL PRIMARY KEY,
    idTrain INT,
    idTechnicien INT,
    date_maintenance DATE NOT NULL,
    FOREIGN KEY (idTrain) REFERENCES Train(idTrain) ON DELETE CASCADE,
    FOREIGN KEY (idTechnicien) REFERENCES Technicien(idTechnicien) ON DELETE CASCADE
);


-- Table Type_Incident
CREATE TABLE Type_Incident (
    idIncident INT PRIMARY KEY,
    description TEXT NOT NULL
);

-- Table Trajet
CREATE TABLE Trajet (
    idTrajet SERIAL PRIMARY KEY,
    idHoraire INT,
    idTrain INT,
    date_trajet DATE NOT NULL,
	dureeTrajet INTERVAL NOT NULL,
    FOREIGN KEY (idHoraire) REFERENCES Horaire(idHoraire) ON DELETE SET NULL,
    FOREIGN KEY (idTrain) REFERENCES Train(idTrain) ON DELETE CASCADE
);

-- Table Retard
CREATE TABLE Retard (
    idRetard SERIAL PRIMARY KEY,
    duree_retard INTERVAL NOT NULL CHECK (duree_retard > '00:00:00'),
    idIncident INT,
	idTrajet INT,
    FOREIGN KEY (idIncident) REFERENCES Type_Incident(idIncident) ON DELETE SET NULL,
	FOREIGN KEY (idTrajet) REFERENCES Trajet(idTrajet) on delete cascade
);


commit;


