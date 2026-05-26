-- Pasul 3: Logica Server-Side
-- 3.1. Funcție pentru Analiza de Sentiment Automata
CREATE OR REPLACE FUNCTION fn_analiza_sentiment()
RETURNS TRIGGER AS $$
DECLARE
keywords_pos TEXT[] := ARRAY['bun', 'excelent', 'recomand', 'interesant', 'super', 'fain', 'top'];
    keywords_neg TEXT[] := ARRAY['slab', 'plictisitor', 'nasol', 'prost', 'timp', 'dezamagit'];
    p_count INT := 0;
    n_count INT := 0;
    word TEXT;
BEGIN
    -- EXCEPTIA 1: Verificam daca textul e prea scurt sau invalid
    IF NEW.Comentariu_Film_Text IS NOT NULL AND length(trim(NEW.Comentariu_Film_Text)) < 3 THEN
        RAISE EXCEPTION 'Eroare SGBD: Comentariul este prea scurt pentru a fi analizat.';
END IF;

    NEW.Sentiment_Analiza := 'Neutru';
    IF NEW.Comentariu_Film_Text IS NOT NULL THEN
        FOR word IN SELECT unnest(string_to_array(translate(lower(NEW.Comentariu_Film_Text), '.,!?;:', ''), ' ')) LOOP
                                                         IF word = ANY(keywords_pos) THEN p_count := p_count + 1;
ELSIF word = ANY(keywords_neg) THEN n_count := n_count + 1;
END IF;
END LOOP;
        IF p_count > n_count THEN NEW.Sentiment_Analiza := 'Pozitiv';
        ELSIF n_count > p_count THEN NEW.Sentiment_Analiza := 'Negativ';
END IF;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;;

-- 3.1.2. Funcție pentru Analiza de Sentiment Actori
CREATE OR REPLACE FUNCTION fn_analiza_sentiment_actor()
RETURNS TRIGGER AS $$
DECLARE
    keywords_pos TEXT[] := ARRAY['bun', 'excelent', 'recomand', 'interesant', 'super', 'fain', 'top', 'impecabil', 'genial'];
    keywords_neg TEXT[] := ARRAY['slab', 'plictisitor', 'nasol', 'prost', 'dezamagit'];
    p_count INT := 0;
    n_count INT := 0;
    word TEXT;
BEGIN
    NEW.Sentiment_Analiza := 'Neutru';
    IF NEW.Comentariu_Actor_Rol IS NOT NULL THEN
        FOR word IN SELECT unnest(string_to_array(translate(lower(NEW.Comentariu_Actor_Rol), '.,!?;:', ''), ' ')) LOOP
            IF word = ANY(keywords_pos) THEN p_count := p_count + 1;
            ELSIF word = ANY(keywords_neg) THEN n_count := n_count + 1;
            END IF;
        END LOOP;
        IF p_count > n_count THEN NEW.Sentiment_Analiza := 'Pozitiv';
        ELSIF n_count > p_count THEN NEW.Sentiment_Analiza := 'Negativ';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;;

-- 3.2. Functie pentru Recomandari Personalizate
-- Returneaza 3 filme dintr-o categorie placuta de utilizator, pe care nu le-a vazut
CREATE OR REPLACE FUNCTION get_recomandari_client(p_id_client INT)
RETURNS TABLE (Titlu VARCHAR, Medie_Rating NUMERIC) AS $$
BEGIN
RETURN QUERY
SELECT f.Titlu_Film, ROUND(AVG(fv.Rating_Film), 2)
FROM Filme f
         JOIN Feedback_Voturi fv ON f.ID_Film = fv.ID_Film
WHERE f.ID_Categorie IN (
    -- Selectam categoriile unde clientul a dat note de minim 8
    SELECT f2.ID_Categorie
    FROM Feedback_Voturi fv2
             JOIN Filme f2 ON fv2.ID_Film = f2.ID_Film
    WHERE fv2.ID_Client = p_id_client AND fv2.Rating_Film >= 8
)
  AND f.ID_Film NOT IN (
    -- Excludem filmele pe care clientul le-a vazut deja
    SELECT v.ID_Film FROM Vizualizari v WHERE v.ID_Client = p_id_client
)
GROUP BY f.ID_Film, f.Titlu_Film
ORDER BY 2 DESC LIMIT 3;
END;
$$ LANGUAGE plpgsql;;

-- 3.3. Functie pentru Predictii Sezoniere
-- Estimeaza succesul unui film intr-o anumita luna, bazat pe istoricul anilor trecuti
DROP FUNCTION IF EXISTS get_predictie_sezoniera(INT);;
CREATE OR REPLACE FUNCTION get_predictie_sezoniera(p_luna INT)
RETURNS TABLE (Titlu_Film VARCHAR, Vizualizari_Estimate DECIMAL) AS $$
BEGIN
RETURN QUERY
SELECT f.Titlu_Film, COUNT(v.ID_Vizualizare) * 1.5
FROM Filme f
         JOIN Vizualizari v ON f.ID_Film = v.ID_Film
WHERE EXTRACT(MONTH FROM v.Data_Vizualizare) = p_luna
GROUP BY f.Titlu_Film
ORDER BY 2 DESC LIMIT 5;
END;
$$ LANGUAGE plpgsql;;

-- 3.4. Functie pentru Recomandari prin Similaritate
-- Gaseste utilizatori care au dat note mari la aceleasi filme
CREATE OR REPLACE FUNCTION get_recomandari_prin_similaritate(p_id_client INT)
RETURNS TABLE (Titlu_Recomandat VARCHAR) AS $$
BEGIN
RETURN QUERY
SELECT DISTINCT f.Titlu_Film
FROM Filme f
         JOIN Feedback_Voturi fv ON f.ID_Film = fv.ID_Film
WHERE fv.ID_Client IN (
    -- Gasim useri care au dat note 9-10 la aceleasi filme ca si clientul nostru
    SELECT fv2.ID_Client
    FROM Feedback_Voturi fv2
    WHERE fv2.ID_Film IN (SELECT fv3.ID_Film FROM Feedback_Voturi fv3 WHERE fv3.ID_Client = p_id_client AND fv3.Rating_Film >= 9)
      AND fv2.ID_Client <> p_id_client
      AND fv2.Rating_Film >= 9
)
  AND f.ID_Film NOT IN (SELECT v.ID_Film FROM Vizualizari v WHERE v.ID_Client = p_id_client)
    LIMIT 3;
END;
$$ LANGUAGE plpgsql;;

-- 3.5. Procedura pentru Calculul Automat al Frecventei de Vizionare
-- Actualizeaza un raport statistic pentru un client
CREATE OR REPLACE FUNCTION get_statistici_consum(p_id_client INT)
RETURNS TABLE (Total_Minute INT, Filme_Vazute INT, Calitate_Preferata VARCHAR) AS $$
BEGIN
RETURN QUERY
SELECT
    SUM(v.Durata_Vizualizare)::INT,
    COUNT(DISTINCT v.ID_Film)::INT,
    (SELECT vf.Rezolutie FROM Vizualizari v2
                                  JOIN Versiuni_Film vf ON v2.ID_Versiune = vf.ID_Versiune
     WHERE v2.ID_Client = p_id_client
     GROUP BY vf.Rezolutie ORDER BY COUNT(*) DESC LIMIT 1)
FROM Vizualizari v
WHERE v.ID_Client = p_id_client;
END;
$$ LANGUAGE plpgsql;;

-- 3.6. Trigger pentru activarea automata a analizei de sentiment
-- Aceasta comanda leaga functia de tabelul Feedback_Voturi
CREATE TRIGGER trg_sentiment
    BEFORE INSERT OR UPDATE ON Feedback_Voturi
                         FOR EACH ROW EXECUTE FUNCTION fn_analiza_sentiment();;

-- 3.7. AL DOILEA TRIGGER
-- impiedica inserarea unei vizualizari daca durata este mai mare decat 500 minute
CREATE OR REPLACE FUNCTION fn_validare_vizualizare()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Durata_Vizualizare > 500 THEN
        -- EXCEPTIA 2
        RAISE EXCEPTION 'Eroare SGBD: Durata vizualizarii (%) este nerealista pentru un film standard.', NEW.Durata_Vizualizare;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;;

CREATE TRIGGER trg_validare_viz
    BEFORE INSERT OR UPDATE ON Vizualizari
    FOR EACH ROW EXECUTE FUNCTION fn_validare_vizualizare();;

CREATE TRIGGER trg_sentiment_actor
    BEFORE INSERT OR UPDATE ON Feedback_Actori
    FOR EACH ROW EXECUTE FUNCTION fn_analiza_sentiment_actor();;
