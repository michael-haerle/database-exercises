USE albums_db;
SHOW TABLES;
DESCRIBE albums;
SELECT * FROM albums;
SELECT DISTINCT artist FROM albums;
SELECT * FROM albums WHERE artist = 'Pink Floyd';
SELECT * FROM albums WHERE name = 'Nevermore';
SELECT * FROM albums WHERE release_date BETWEEN 1990 AND 1999;
SELECT * FROM albums WHERE SALES < 20;
SELECT * FROM albums WHERE genre = 'rock';
-- Explore the structure of the albums table.
-- a. How many rows are in the albums table? 31
-- b. How many unique artist names are in the albums table? 23
-- c. What is the primary key for the albums table? id
-- d. What is the oldest release date for any album in the albums table? What is the most recent release date?
-- Oldest Sgt. Pepper's Lonely Hearts Club Band, Newest 21
-- Write queries to find the following information:
-- a. The name of all albums by Pink Floyd The Dark Side of the Moon, The Wall
-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released 1967
-- c. The genre for the album Nevermind Grunge, Alternative rock
-- d. Which albums were released in the 1990s 11
-- e. Which albums had less than 20 million certified sales 13
-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
-- Sgt. Pepper's Lonely Hearts Club Band, 1, Abbey Road, Born in the U.S.A., and Supernatural.
-- The query has to be specific, you would have to type out the exact genre you're looking for.
