	-- 1a. Display the first and last names of all actors from the table actor.--
	-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.--

USE sakila;

SELECT 
    first_name, last_name
FROM
    actor;
    
ALTER TABLE actor ADD COLUMN Actor Name VARCHAR(50);
    
 UPDATE tbl SET actor_name = CONCAT(first_name, last_name);  
 
 ALTER TABLE actor
  ADD actor_name VARCHAR(50);
  
SELECT UPPER(CONCAT(first_name,  last_name));

SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS `actor _name`
FROM actor;

	-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?--

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

	-- 2b. Find all actors whose last name contain the letters GEN:--
    
SELECT 
    actor_id, last_name
FROM
    actor
WHERE
    last_name LIKE '%gen%';

	-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:--
 
 SELECT 
    actor_id, last_name, first_name
FROM
    actor
WHERE
    last_name LIKE '%li%';
    
	-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:--

SELECT country_id, country
FROM country
WHERE IN ('Afghanistan', 'Bangladesh', 'China');

SELECT country_id, country
FROM country
WHERE  country IN ('Afghanistan', 'Bangladesh', 'China');

	-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.--
    
ALTER TABLE actor
  ADD middle_name VARCHAR(50) AFTER first_name;
  
ALTER TABLE actor
  ADD COLUMN middle_name VARCHAR(50) AFTER first_name;
  
-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.--
-- ??????????--

ALTER TABLE actor
MODIFY COLUMN middle_name BLOB;




  

  

    






    



