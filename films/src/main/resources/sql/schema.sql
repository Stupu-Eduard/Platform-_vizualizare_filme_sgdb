-- Pasul 1: Curatare completa
DROP TABLE IF EXISTS caracterizari_selectate CASCADE;;
DROP TABLE IF EXISTS feedback_voturi CASCADE;;
DROP TABLE IF EXISTS vizualizari CASCADE;;
DROP TABLE IF EXISTS feedback_actori CASCADE;;
DROP TABLE IF EXISTS distributie CASCADE;;
DROP TABLE IF EXISTS versiuni_film CASCADE;;
DROP TABLE IF EXISTS filme CASCADE;;
DROP TABLE IF EXISTS actori CASCADE;;
DROP TABLE IF EXISTS clienti CASCADE;;
DROP TABLE IF EXISTS categorii CASCADE;;

-- Pasul 2: Creare tabele
-- 2.1 Creare tabele intependente
CREATE TABLE Categorii (
    ID_Categorie SERIAL PRIMARY KEY,
    Tip_Categorie VARCHAR(50) NOT NULL UNIQUE
);;
CREATE TABLE Clienti (
    ID_Client SERIAL PRIMARY KEY,
    Nume_Client VARCHAR(50) NOT NULL,
    Prenume_Client VARCHAR(50) NOT NULL,
    Tel_Acasa VARCHAR(15) NOT NULL,
    Adresa VARCHAR(100) NOT NULL,
    Oras VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Tel_Mobil VARCHAR(20)
);;

CREATE TABLE Actori (
    ID_Actor SERIAL PRIMARY KEY,
    Nume_Scena_Actor VARCHAR(100) NOT NULL,
    Nume_Familie_Actor VARCHAR(50) NOT NULL,
    Prenume_Actor VARCHAR(50) NOT NULL,
    Data_Nastere_Actor DATE,
     -- Constrângere pentru a evita duplicatele
       CONSTRAINT unicitate_biografica_actor UNIQUE (Nume_Familie_Actor, Prenume_Actor, Data_Nastere_Actor)
   );;
-- 2.2 Creare tabele dependente
CREATE TABLE Filme (
    ID_Film SERIAL PRIMARY KEY,
    Titlu_Film VARCHAR(100) NOT NULL,
    Descriere_Film TEXT,
    Data_Lansare DATE NOT NULL,
    ID_Categorie INT NOT NULL,

    -- Legătura cu tabelul părinte
    CONSTRAINT fk_categorie_film FOREIGN KEY (ID_Categorie)
           REFERENCES Categorii(ID_Categorie)
           -- Daca stergem o categorie, stergem toate filmele ce au aceeasi categorie
           ON DELETE CASCADE,

    CONSTRAINT unicitate_film UNIQUE (Titlu_Film, Data_Lansare)
);;

CREATE TABLE Versiuni_Film (
    ID_Versiune SERIAL PRIMARY KEY,
    ID_Film INT NOT NULL,
    Rezolutie VARCHAR(20) NOT NULL,
    Format VARCHAR(20) NOT NULL,
    Limba_Versiune VARCHAR(30) NOT NULL,

    -- Legătura cu filmul părinte
    CONSTRAINT fk_versiune_film FOREIGN KEY (ID_Film)
        REFERENCES Filme(ID_Film) ON DELETE CASCADE,

    -- Constrângere CHECK: acceptăm doar anumite standarde de calitate
    CONSTRAINT check_rezolutie CHECK (Rezolutie IN ('4K', 'HD', 'SD', '3D'))
);;

CREATE TABLE Distributie (
    ID_Film INT NOT NULL,
    ID_Actor INT NOT NULL,

    -- Cheia primară este compusă din ambele ID-uri
    PRIMARY KEY (ID_Film, ID_Actor),


    CONSTRAINT fk_dist_film FOREIGN KEY (ID_Film) REFERENCES Filme(ID_Film) ON DELETE CASCADE,
    CONSTRAINT fk_dist_actor FOREIGN KEY (ID_Actor) REFERENCES Actori(ID_Actor) ON DELETE CASCADE
);;

CREATE TABLE Feedback_Actori (
    Feedback_Actor SERIAL PRIMARY KEY,
    ID_Client INT NOT NULL,
    ID_Film INT NOT NULL,
    ID_Actor INT NOT NULL,
    Comentariu_Actor_Rol TEXT,
    Sentiment_Analiza VARCHAR(20),

    CONSTRAINT fk_fa_client FOREIGN KEY (ID_Client) REFERENCES Clienti(ID_Client),
    CONSTRAINT fk_fa_film FOREIGN KEY (ID_Film) REFERENCES Filme(ID_Film),
    CONSTRAINT fk_fa_actor FOREIGN KEY (ID_Actor) REFERENCES Actori(ID_Actor)
);;


CREATE TABLE Vizualizari (
    ID_Vizualizare SERIAL PRIMARY KEY,
    ID_Client INT NOT NULL,
    ID_Versiune INT NOT NULL,
    ID_Film INT NOT NULL,
    Data_Vizualizare TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Durata_Vizualizare INT NOT NULL, -- exprimată în minute
    Stare_Vizualizare VARCHAR(20) NOT NULL,

    -- Legaturi
    CONSTRAINT fk_viz_client FOREIGN KEY (ID_Client) REFERENCES Clienti(ID_Client),
    CONSTRAINT fk_viz_versiune FOREIGN KEY (ID_Versiune) REFERENCES Versiuni_Film(ID_Versiune),
    CONSTRAINT fk_viz_film FOREIGN KEY (ID_Film) REFERENCES Filme(ID_Film),

    -- Constrângere CHECK pentru starea vizionării
    CONSTRAINT check_stare_viz CHECK (Stare_Vizualizare IN ('Inceputa', 'Terminata', 'Intrerupta')),
    -- Constrângere pentru durată (nu poate fi negativă)
    CONSTRAINT check_durata CHECK (Durata_Vizualizare >= 0)
   );;


CREATE TABLE Feedback_Voturi (
    ID_Feedback SERIAL PRIMARY KEY,
    ID_Client INT NOT NULL,
    ID_Film INT NOT NULL,
    Rating_Film INT NOT NULL,
    Comentariu_Film_Text TEXT,
    Sentiment_Analiza VARCHAR(20),

    CONSTRAINT fk_feed_client FOREIGN KEY (ID_Client) REFERENCES Clienti(ID_Client),
    CONSTRAINT fk_feed_film FOREIGN KEY (ID_Film) REFERENCES Filme(ID_Film),

    -- Constrângere CHECK pentru nota acordată (1-10)
    CONSTRAINT check_rating CHECK (Rating_Film BETWEEN 1 AND 10)
);;

CREATE TABLE Caracterizari_Selectate (
    ID_Caracterizare SERIAL PRIMARY KEY,
    ID_Feedback INT NOT NULL,
    Eticheta_Predefinita VARCHAR(50) NOT NULL,

    CONSTRAINT fk_char_feedback FOREIGN KEY (ID_Feedback)
    REFERENCES Feedback_Voturi(ID_Feedback) ON DELETE CASCADE
);;
