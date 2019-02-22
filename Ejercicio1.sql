CREATE DATABASE pintagram;

\c pintagram

CREATE TABLE Users(
  id SERIAL,
  first_name VARCHAR(15),
  last_name VARCHAR(15),
  email VARCHAR
);

CREATE TABLE Imagen (
  id SERIAL,
  img_name VARCHAR(15),
  owner_id INTEGER,
  FOREIGN KEY (owner_id) REFERENCES Users(id)
);

CREATE TABLE Evaluated_image (
  id SERIAL,
  user_id INTEGER,
  img_id INTEGER,
  evaluated_like BOOLEAN,
  FOREIGN KEY (user_id) REFERENCES User(id),
  FOREIGN KEY (img_name) REFERENCES Imagen(id)
);

CREATE TABLE Tagging (
  id SERIAL,
  tag_id INTEGER,
  img_id INTEGER,
  FOREIGN KEY (tag_id) REFERENCES Tags(id),
  FOREIGN KEY (img_id) REFERENCES Imagen(id)
);

CREATE TABLE Tags (
  id SERIAL,
  tag_name VARCHAR
);

INSERT INTO Users(first_name, last_name, email) VALUES 
('Daniel', 'Hidalgo', 'pachamamico@gmail.com'),
('Viviana', 'Fajardo', 'viviana@gmail.com'),
('Ignacio', 'Olea', 'olea@gmail.com'),
('Ignacio', 'Garces', 'nacho@gmail.com');

INSERT INTO Images(img_name, owner_id) VALUES 
('Daniel_uno.jpg', '1'), ('Daniel_dos.jpg', '1'),
('Viviana_uno.jpg', '2'), ('Viviana_dos.jpg', '2'),
('Ignacio_uno.jpg', '3'), ('Ignacio_dos.jpg', '3'),
('Nacho_uno.jpg', '4'), ('Nacho_dos.jpg', '4');

INSERT INTO EvaluatedImages(evaluated_like, user_id, img_id) VALUES 
(true, 1, 3), (true, 1, 4), (true, 1, 5), (true, 1, 6), (true, 1, 7), (true, 1, 8),
(true, 2, 1), (true, 2, 2), (true, 2, 5), (true, 2, 6), (true, 2, 7), (true, 2, 8),
(true, 3, 1), (true, 3, 2), (true, 3, 3), (true, 3, 4), (true, 3, 7), (true, 3, 8),
(true, 4, 1), (true, 4, 2), (true, 4, 3), (true, 4, 4), (true, 4, 5), (true, 4, 6);


INSERT INTO Tags(tag_name) VALUES
('PintaChile'), ('PintaChina'), ('PintaColombia'), ('PintaVenezuela'), ('PintaSantiago'), ('PintaFrutillar'), ('PintaChillan'), ('PintaCarita');

INSERT INTO Tagging(tag_id, img_id) VALUES
(1,1), (2,1), (3,1), (4,2), (5,2), (6,2), 
(7,3), (8,3), (1,3), (2,4), (3,4), (4,4), 
(5,5), (6,5), (7,5), (8,6), (1,6), (2,6), 
(3,6), (4,6), (5,6), (6,8), (7,8), (8,8);

SELECT img_name, COUNT(Evaluated_image) FROM Imagen FULL JOIN Evaluated_image on (imagen.id = img_id) GROUP BY img_name;

SELECT first_name, last_name, img_name FROM Users INNER JOIN Imagen on (Users.id = owner_id) GROUP BY first_name;

SELECT tag_name, COUNT(Imagen) FROM ((Tags INNER JOIN Taggging ON Tags.id = tag_id) INNER JOIN Imagen ON img_id = Imagen.id);
