-- Script de populare automatizată pentru proiectul SGBD

-- 1. Categorii (16)
INSERT INTO Categorii (Tip_Categorie) VALUES
('Action'), ('Sci-Fi'), ('Drama'), ('Romance'), ('Comedy'),
('Thriller'), ('Horror'), ('Fantasy'), ('Animation'), ('Adventure'),
('Crime'), ('Mystery'), ('Family'), ('History'), ('War'), ('Biography');;

-- 2. Clienti (16)
INSERT INTO Clienti (Nume_Client, Prenume_Client, Tel_Acasa, Adresa, Oras, Email, Tel_Mobil) VALUES
('Smith', 'John', '0211111111', '123 Main St', 'New York', 'john.smith@email.com', '0721000111'),
('Johnson', 'Emily', '0212222222', '456 Oak Ave', 'Los Angeles', 'emily.j@email.com', '0722000222'),
('Williams', 'Michael', '0213333333', '789 Pine Rd', 'Chicago', 'michael.w@email.com', '0723000333'),
('Brown', 'Sarah', '0232444555', '321 Elm St', 'Houston', 'sarah.b@email.com', '0744111222'),
('Jones', 'David', '0256111222', '654 Maple Dr', 'Phoenix', 'david.j@email.com', '0755222333'),
('Garcia', 'Jessica', '0215556667', '987 Cedar Ln', 'Philadelphia', 'jessica.g@email.com', '0721111222'),
('Miller', 'James', '0241888999', '147 Birch Blvd', 'San Antonio', 'james.m@email.com', '0741555666'),
('Davis', 'Jennifer', '0236444555', '258 Walnut Ct', 'San Diego', 'jennifer.d@email.com', '0736777888'),
('Rodriguez', 'Robert', '0219990001', '369 Spruce Way', 'Dallas', 'robert.r@email.com', '0722333444'),
('Martinez', 'Linda', '0264111222', '159 Ash Pl', 'San Jose', 'linda.m@email.com', '0764555666'),
('Hernandez', 'William', '0232333444', '753 Chestnut St', 'Austin', 'william.h@email.com', '0732111222'),
('Lopez', 'Elizabeth', '0251444555', '951 Cherry Ave', 'Jacksonville', 'elizabeth.l@email.com', '0751000111'),
('Gonzalez', 'Richard', '0217778889', '852 Poplar Rd', 'San Francisco', 'richard.g@email.com', '0721999888'),
('Wilson', 'Susan', '0239111222', '456 Willow Dr', 'Indianapolis', 'susan.w@email.com', '0739555666'),
('Anderson', 'Joseph', '0214443332', '789 Beech Ln', 'Columbus', 'joseph.a@email.com', '0724111000'),
('Thomas', 'Karen', '0216665554', '123 Cypress Ct', 'Seattle', 'karen.t@email.com', '0721666777');;

-- 3. Actori (17)
INSERT INTO Actori (Nume_Scena_Actor, Nume_Familie_Actor, Prenume_Actor, Data_Nastere_Actor) VALUES
('Leonardo DiCaprio', 'DiCaprio', 'Leonardo', '1974-11-11'),
('Keanu Reeves', 'Reeves', 'Keanu', '1964-09-02'),
('Marlon Brando', 'Brando', 'Marlon', '1924-04-03'),
('Al Pacino', 'Pacino', 'Al', '1940-04-25'),
('Christian Bale', 'Bale', 'Christian', '1974-01-30'),
('Tom Hanks', 'Hanks', 'Tom', '1956-07-09'),
('John Travolta', 'Travolta', 'John', '1954-02-18'),
('Samuel L. Jackson', 'Jackson', 'Samuel', '1948-12-21'),
('Matthew McConaughey', 'McConaughey', 'Matthew', '1969-11-04'),
('Russell Crowe', 'Crowe', 'Russell', '1964-04-07'),
('Robert Downey Jr.', 'Downey', 'Robert', '1965-04-04'),
('Scarlett Johansson', 'Johansson', 'Scarlett', '1984-11-22'),
('Elijah Wood', 'Wood', 'Elijah', '1981-01-28'),
('Ian McKellen', 'McKellen', 'Ian', '1939-05-25'),
('Harrison Ford', 'Ford', 'Harrison', '1942-07-13'),
('Brad Pitt', 'Pitt', 'Brad', '1963-12-18'),
('Macaulay Culkin', 'Culkin', 'Macaulay', '1980-08-26');;

-- 4. Filme (17)
INSERT INTO Filme (Titlu_Film, Descriere_Film, Data_Lansare, ID_Categorie) VALUES
('Inception', 'A thief who steals corporate secrets through the use of dream-sharing technology.', '2010-07-16', 2),
('The Matrix', 'A computer hacker learns from mysterious rebels about the true nature of his reality.', '1999-03-31', 2),
('The Godfather', 'The aging patriarch of an organized crime dynasty in postwar New York City.', '1972-03-24', 11),
('The Dark Knight', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham.', '2008-07-18', 1),
('Forrest Gump', 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal.', '1994-07-06', 3),
('Pulp Fiction', 'The lives of two mob hitmen, a boxer, a gangster and his wife.', '1994-10-14', 11),
('Interstellar', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.', '2014-11-07', 2),
('Gladiator', 'A former Roman General sets out to exact vengeance against the corrupt emperor.', '2000-05-05', 1),
('Titanic', 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.', '1997-12-19', 4),
('The Avengers', 'Earth''s mightiest heroes must come together and learn to fight as a team.', '2012-05-04', 1),
('Jurassic Park', 'A pragmatic paleontologist visiting an almost complete theme park is tasked with protecting a couple of kids.', '1993-06-11', 10),
('The Lord of the Rings: The Fellowship of the Ring', 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring.', '2001-12-19', 8),
('Star Wars: Episode IV - A New Hope', 'Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids.', '1977-05-25', 2),
('Avatar', 'A paraplegic Marine dispatched to the moon Pandora on a unique mission.', '2009-12-18', 2),
('The Shawshank Redemption', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption.', '1994-09-23', 3),
('Fight Club', 'An insomniac office worker and a devil-may-care soap maker form an underground fight club.', '1999-10-15', 3),
('Home Alone', 'An eight-year-old troublemaker must protect his house from a pair of burglars.', '1990-11-16', 13);;

-- 5. Versiuni_Film (17)
INSERT INTO Versiuni_Film (ID_Film, Rezolutie, Format, Limba_Versiune) VALUES
(1, '4K', 'Streaming', 'Engleza'), (2, '4K', 'BluRay', 'Engleza'),
(3, 'HD', 'Digital', 'Engleza'), (4, '4K', 'Streaming', 'Engleza'),
(5, 'HD', 'Digital', 'Engleza'), (6, '4K', 'BluRay', 'Engleza'),
(7, '4K', 'Streaming', 'Engleza'), (8, 'HD', 'Streaming', 'Engleza'),
(9, 'HD', 'Digital', 'Engleza'), (10, '4K', 'Streaming', 'Engleza'),
(11, 'HD', 'Streaming', 'Engleza'), (12, '4K', 'BluRay', 'Engleza'),
(13, '4K', 'Streaming', 'Engleza'), (14, '4K', 'Digital', 'Engleza'),
(15, 'HD', 'Streaming', 'Engleza'), (16, 'HD', 'BluRay', 'Engleza'),
(17, '4K', 'Streaming', 'Engleza');;

-- 6. Distributie (17)
INSERT INTO Distributie (ID_Film, ID_Actor) VALUES
(1, 1), (2, 2), (3, 3), (3, 4), (4, 5), (5, 6), (6, 7), (6, 8), (7, 9), (8, 10),
(9, 1), (10, 11), (10, 12), (10, 8), (12, 13), (12, 14), (13, 15), (16, 16), (17, 17);;

-- 7. Feedback_Voturi 
-- Client 1 si Client 2 au dat nota 10 la filmele 1, 2, 3
-- Client 2 a vazut si a dat 10 la filmul 4 The Dark Knight, Client 1 inca nu
-- `get_recomandari_prin_similaritate(1)` va returna The Dark Knight
INSERT INTO Feedback_Voturi (ID_Client, ID_Film, Rating_Film, Comentariu_Film_Text) VALUES
(1, 1, 10, 'O capodopera absoluta, un film excelent.'),
(1, 2, 10, 'Foarte amuzant si super vizual.'),
(1, 3, 10, 'Cea mai buna drama de crima, il recomand!'),
(2, 1, 10, 'Efecte vizuale incredibile, super!'),
(2, 2, 10, 'O legenda SF, conceptul e foarte interesant.'),
(2, 3, 10, 'Un film perfect, il recomand cu caldura.'),
(2, 4, 10, 'Heath Ledger este fenomenal, un film foarte bun.'),
(3, 5, 10, 'Un film emotionant si un scenariu top.'),
(4, 6, 8, 'Un clasic semnat Tarantino, foarte interesant.'),
(5, 7, 9, 'Efecte vizuale incredibile, super!'),
(6, 8, 8, 'O actiune istorica epica, excelent.'),
(7, 9, 7, 'O poveste de dragoste buna, dar putin plictisitor pe alocuri.'),
(8, 10, 8, 'O echipa de supereroi extraordinara, fain realizat.'),
(9, 11, 9, 'Un clasic al copilariei, il recomand tuturor.'),
(10, 12, 10, 'Cea mai buna aventura fantastica, nota zece, top.'),
(11, 13, 9, 'O legenda SF, conceptul e foarte interesant.'),
(12, 14, 8, 'O constructie a lumii superba si un peisaj excelent.'),
(13, 15, 10, 'Un film perfect, il recomand cu caldura.'),
(14, 16, 9, 'Are o rasturnare de situatie deosebita, bun film.'),
(15, 17, 10, 'Cel mai fain film de Craciun, super amuzant!');;

-- 8. Caracterizari_Selectate
INSERT INTO Caracterizari_Selectate (ID_Feedback, Eticheta_Predefinita) VALUES
(1, 'Capodopera'), (2, 'Vizionar'), (3, 'Clasic'),
(4, 'Intunecat'), (5, 'Emotionant'), (6, 'Iconic'),
(7, 'Epic'), (8, 'Palpitant'), (9, 'Romantic'),
(10, 'Actiune'), (11, 'Nostalgic'), (12, 'Legendar'),
(13, 'Sci-Fi Clasic'), (14, 'Impresionant Vizual'), (15, 'Perfect'),
(16, 'Imprevizibil'), (17, 'Amuzant'), (18, 'Craciun');;

-- 9. Feedback_Actori
INSERT INTO Feedback_Actori (ID_Client, ID_Film, ID_Actor, Comentariu_Actor_Rol) VALUES
(1, 1, 1, 'Leo este intotdeauna excelent.'),
(2, 2, 2, 'Keanu este cu adevarat Neo, top.'),
(3, 3, 3, 'Brando joaca rolul suprem in acest film.'),
(4, 3, 4, 'Transformarea lui Pacino este uimitoare, super.'),
(5, 4, 5, 'Bale este un Batman foarte bun.'),
(6, 5, 6, 'Hanks a oferit o interpretare de top.'),
(7, 6, 7, 'Dansul lui Travolta este interesant si emblematic.'),
(8, 6, 8, 'Samuel L. Jackson are o prestatie intensa.'),
(9, 7, 9, 'McConaughey te face sa simti cu adevarat emotia, fain.'),
(10, 8, 10, 'Crowe este un gladiator de neoprit, excelent.'),
(11, 10, 11, 'RDJ pare nascut pentru Iron Man, excelent.'),
(12, 10, 12, 'Scarlett are o prestatie super.'),
(13, 12, 13, 'Elijah l-a surprins perfect pe Frodo, bun actor.'),
(14, 12, 14, 'McKellen este genial, un rol bun.'),
(15, 13, 15, 'Harrison Ford are o carisma aparte, il recomand.'),
(16, 16, 16, 'Brad Pitt joaca impecabil, un actor top.'),
(15, 17, 17, 'Macaulay Culkin a fost copilul minune, super bun.');;

-- 10. Vizualizari
-- PREDICTII SEZONIERE:
-- multe vizualizari pentru filmul 17 Home Alone  in luna 12
INSERT INTO Vizualizari (ID_Client, ID_Versiune, ID_Film, Data_Vizualizare, Durata_Vizualizare, Stare_Vizualizare) VALUES
(1, 1, 1, '2023-01-01 20:00:00', 148, 'Terminata'),
(1, 2, 2, '2023-01-05 18:00:00', 136, 'Terminata'),
(1, 3, 3, '2023-02-10 21:00:00', 175, 'Terminata'),

(2, 1, 1, '2023-01-02 20:00:00', 148, 'Terminata'),
(2, 2, 2, '2023-01-06 18:00:00', 136, 'Terminata'),
(2, 3, 3, '2023-02-11 21:00:00', 175, 'Terminata'),
(2, 4, 4, '2023-03-12 19:30:00', 152, 'Terminata'), 

(3, 5, 5, '2023-04-15 22:00:00', 142, 'Terminata'),
(4, 6, 6, '2023-05-20 15:00:00', 154, 'Terminata'),
(5, 7, 7, '2023-06-25 10:00:00', 169, 'Terminata'),
(6, 8, 8, '2023-07-30 23:00:00', 155, 'Terminata'),
(7, 9, 9, '2023-08-14 20:15:00', 194, 'Terminata'),
(8, 10, 10, '2023-09-01 19:00:00', 143, 'Terminata'),
(9, 11, 11, '2023-10-05 18:30:00', 127, 'Terminata'),
(10, 12, 12, '2023-11-10 17:00:00', 178, 'Terminata'),
(11, 13, 13, '2023-12-15 20:00:00', 121, 'Terminata'),

(12, 17, 17, '2023-12-20 18:00:00', 103, 'Terminata'),
(13, 17, 17, '2023-12-21 19:00:00', 103, 'Terminata'),
(14, 17, 17, '2023-12-22 20:00:00', 103, 'Terminata'),
(15, 17, 17, '2023-12-23 21:00:00', 103, 'Terminata'),
(16, 17, 17, '2023-12-24 16:00:00', 103, 'Terminata'),
(5,  17, 17, '2023-12-25 12:00:00', 103, 'Terminata');;