drop database movie_db;
create database movie_db;
use movie_db;
create table actor(
actor_id INT primary key,
actor_name varchar(30),
actor_gender varchar(30));
create table director(
dir_id INT PRIMARY KEY,
dir_name varchar(30),
dir_phone varchar(30)
);
create table movies(
movie_id INT primary key,
movie_title varchar(30),
movie_year INT,
movie_lang varchar(30),
dir_id INT,
foreign key (dir_id) references director(dir_id));
create table movie_cast(
actor_id INT,
movie_id INT,
role varchar(30),
primary key(actor_id,movie_id),
foreign key (actor_id) references  actor(actor_id) ON DELETE CASCADE,
foreign key (movie_id) references movies(movie_id) ON DELETE CASCADE);
create table rating(
movie_id INT primary key,
rev_star varchar(30),
foreign key (movie_id) references movies(movie_id));
INSERT INTO actor values
(10,'Brad','M'),
(11,'Monica','F'),
(12,'George','M'),
(13,'Courtney','F'),
(14,'James','M');
INSERT INTO director values
(30,'Quentin','8698440915'),
(31,'Hitchcock','9498550914'),
(32,'Lucas','9798440916'),
(33,'Steven Spielberg','9698440915'),
(34,'Denzel','8698775415');
INSERT INTO movies values
(1001,'Oceans 11','2006','English',33),
(1002,'After Earth','2008','Hindi',33),
(1003,'Star Wars','2014','English',31),
(1004,'Sopranos','1999','Hindi',30),
(1005,'The A team','2020','Telugu',32);
INSERT INTO movie_cast values
(10,1001,'Hero'),
(13,1004,'Heroine'),
(11,1003,'guest'),
(14,1002,'Hero'),
(14,1005,'guest');
INSERT INTO rating values
(1004,5),
(1003,4),
(1002,3),
(1001,4),
(1005,2);

/*1. List the titles of all movies directed by ‘Hitchcock’.*/
SELECT movies.movie_title FROM director,movies WHERE director.dir_id=movies.dir_id AND director.dir_name="Hitchcock";

/*2. Find the movie names where one or more actors acted in two or more movies.*/
SELECT movie_TITLE FROM movies,movie_cast WHERE movies.movie_id=movie_cast.movie_id and actor_id IN(SELECT actor_id FROM movie_cast group by actor_id having count(movie_cast.actor_id)>1) GROUP BY movie_title;

/*3. List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation).*/
SELECT actor_name,movie_title,movie_year from actor join movie_cast on actor.actor_id=movie_cast.actor_id join movies on movies.movie_id=movie_cast.movie_id WHERE MOVIE_YEAR NOT BETWEEN 2000 AND 2015; 

/*4. Find the title of movies and number of stars for each movie that has at least one rating and find the highest
    number of stars that movie received. Sort the result by movie title.*/
SELECT movie_title,max(rev_star) FROM movies,rating WHERE movies.movie_id=rating.movie_id GROUP BY movie_title HAVING COUNT(rev_star)>0 ORDER BY MOVIE_TITLE;
    
/*5. Update rating of all movies directed by ‘Steven Spielberg’ to 5.*/
UPDATE RATING SET rev_star=5 WHERE movie_id IN(SELECT MOVIE_ID FROM movies,director WHERE movies.dir_id=director.dir_id AND dir_name="Steven Spielberg");
SELECT*FROM rating;