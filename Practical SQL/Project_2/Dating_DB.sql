-- Database: datingdb

-- DROP DATABASE datingdb;

	
CREATE TABLE profession (
 prof_id bigserial,
 profession varchar(50),
 CONSTRAINT profession_key PRIMARY KEY (prof_id),
 CONSTRAINT profession_unique UNIQUE (profession)
);
SELECT * FROM profession

CREATE TABLE zip_code (
 city varchar(25),
 province varchar(25),
 zip_code bigserial CHECK (LENGTH (CAST(zip_code AS varchar(4))) <= 4),
 CONSTRAINT zip_key PRIMARY KEY (zip_code)
);

DROP TABLE zip_code CASCADE

SELECT * FROM zip_code

CREATE TABLE Status (
 status_id bigserial,
 status varchar(25),
 CONSTRAINT stat_key PRIMARY KEY (status_id)
);

SELECT * FROM Status

CREATE TABLE my_contacts (
 contact_id bigserial,
 last_name varchar(50),
 first_name varchar(50),
 phone varchar (10),
 email varchar(50),
 gender varchar(10),
 birthday date,
 prof_id bigserial REFERENCES profession (prof_id),
 zip_code bigserial REFERENCES zip_code (zip_code),
 status_id bigserial REFERENCES status (status_id),
 CONSTRAINT email_unique UNIQUE (email),
 CONSTRAINT contact_key PRIMARY KEY (contact_id)
);

SELECT * FROM my_contacts

CREATE TABLE interests (
 interests_id bigserial,
 interests varchar(50),
 CONSTRAINT intr_key PRIMARY KEY (interests_id)
);

SELECT * FROM interests

CREATE TABLE contact_interests (
 contact_id bigserial REFERENCES my_contacts (contact_id),
 interests_id bigserial REFERENCES interests (interests_id) 
);

DROP TABLE interests CASCADE

SELECT * FROM contact_interests

CREATE TABLE seeking (
 seeking_id bigserial,
 seeking varchar(50),
 CONSTRAINT seek_key PRIMARY KEY (seeking_id)
);

SELECT * FROM seeking

CREATE TABLE contact_seeking (
 contact_id int REFERENCES my_contacts (contact_id),
 seeking_id int REFERENCES seeking (seeking_id)
);

SELECT * FROM contact_seeking

INSERT INTO profession (profession)
VALUES ('Teacher'),
('Engineer'),
('Electrician'),
('Musician'),
('Personal Trainer'),
('Software developer'),
('IT'),
('Retail');

INSERT INTO zip_code (zip_code, city, province)
VALUES (9300, 'Bloemfontein', 'Freestate'),
(4000, 'KwaZulu-Natal', 'Durban'),
(5000, 'Eastern Cape', 'East London'),
(6000, 'Western Cape', 'Cape Town'),
(2551, 'Gauteng', 'Vereenigin'),
(3442, 'Northern Cape', 'Upington'),
(4558, 'Limpopo', 'Polokwane'),
(3441, 'North West', 'Klerksdorp'),
(0095, 'Mpumalanga', 'Baberton'),
(9301, 'Bloemfontein', 'Sasolburg'),
(4001, 'KwaZulu-Natal', 'Amamzintoti'),
(5001, 'Eastern Cape', 'George'),
(6001, 'Western Cape', 'Stellenbosch'),
(2554, 'Gauteng', 'Vanderbijl'),
(3443, 'Northern Cape', 'Kanon Eiland'),
(4559, 'Limpopo', 'Tzaneen'),
(2553, 'North West', 'Potchefstroom'),
(0094, 'Mpumalanga', 'Volksrust');

SELECT * FROM zip_code

INSERT INTO Status (status)
VALUES ('Single'),
('Married'),
('Widowed'),
('In a Relationship'),
('Divorced'),
('Open Relationship');

INSERT INTO interests (interests)
VALUES ('Offroad Tours'),
('Gaming'),
('Singing'),
('Reading'),
('Dancing'),
('Netflix'),
('Hiking'),
('Drinking'),
('Travel'),
('Shopping'),
('Art'),
('Ski Diving'),
('Cooking');

INSERT INTO seeking (seeking)
VALUES ('Relationship'),
('Friendship');

SELECT * FROM interests
DELETE FROM seeking
SELECT * FROM seeking


INSERT INTO my_contacts (last_name, first_name, phone, email, gender, birthday, prof_id, zip_code, status_id)
VALUES ('Sauer', 'JennySauer', '0872341234', 'jenny@gmail.com', 'F', '2000-01-05', 1, 9300, 1),
('Smith', 'Erin', '0835716666', 'erin@gmail.com', 'F', '1998-09-17', 2, 4000, 5),
('Cooper', 'Talika', '0866325786', 'cooper@gmail.com', 'F', '2000-01-30', 3, 5000, 2),
('Pollard', 'Handre', '0859100084', 'pollard@gmail.com', 'M', '1995-03-13', 4, 6000, 1),
('Dupteez', 'Cortney', '0842999670', 'cortney@gmail.com', 'F', '1998-04-16', 5, 2551, 6),
('Bosch', 'Josh', '0835636030', 'josh@gmail.com', 'M', '1990-12-16', 6, 3442, 1),
('Gaga', 'Tyler', '0839714819', 'Gaga@gmail.com', 'M', '1987-05-05', 7, 4559, 4),
('Foster', 'Britney', '0834307963', 'britney@gmail.com', 'F', '1993-07-18', 8, 3441, 4),
('Fox', 'Megan', '0825138355', 'fox@gmail.com', 'F', '1992-09-10', 1, 0095, 3),
('Synidious', 'Jolleen', '0821185849', 'Jolleen@gmail.com', 'M', '2000-04-29', 2, 9301, 2),
('Chang', 'Dhiao', '0838839728', 'chang@gmail.com', 'F', '1997-01-08', 2, 4001, 1),
('Lincoln', 'Abe', '0828266837', 'abe@gmail.com', 'M', '1994-02-08', 3, 5001, 6),
('Ericson', 'Jay', '0846087530', 'jay@gmail.com', 'M', '1997-04-04', 4, 4559, 1),
('Kingley', 'Justin', '0825558574', 'justin@gmail.com', 'M', '1991-11-22', 5, 2553, 6),
('Naudee', 'Charne', '0832358342', 'naudee@gmail.com', 'F', '2001-07-03', 6, 0094, 1);

SELECT * FROM my_contacts

INSERT INTO contact_interests (contact_id, interests_id)
VALUES (1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 1),
(15, 2);

SELECT * FROM contact_interests
DELETE FROM contact_interests


INSERT INTO contact_seeking (contact_id, seeking_id)
VALUES (1,1 ),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(13,1),
(14,1),
(15,1);

DELETE FROM contact_seeking
SELECT * FROM contact_seeking

SELECT * FROM my_contacts 
INNER JOIN profession
ON my_contacts.prof_id = profession.prof_id
INNER JOIN seeking
ON my_contacts.contact_id = seeking.seeking_id
INNER JOIN interests
ON my_contacts.contact_id = interests.interests_id
INNER JOIN zip_code
ON my_contacts.contact_id = zip_code.zip_code;

SELECT * FROM
my_contacts.last_name,my_contacts.first_name,
profession.profession,
status.status,
zip_code.city,
zip_code.province,
seeking.seeking,
interests.interests

SELECT *
FROM my_contacts INNER JOIN profession 
ON my_contacts.prof_id = profession.prof_id
INNER JOIN status
ON my_contacts.status_id = status.status_id
INNER JOIN zip_code
ON my_contacts.zip_code = zip_code.zip_code
INNER JOIN seeking 
ON my_contacts.contact_id = seeking.seeking_id
INNER JOIN interests
ON my_contacts.contact_id = interests.interests_id
ORDER BY  my_contacts;