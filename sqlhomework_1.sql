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

SELECT 
    country_id, country
FROM
    country
WHERE
    country IN ('Afghanistan' , 'Bangladesh', 'China');

	-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.--
    
ALTER TABLE actor
  ADD middle_name VARCHAR(50) AFTER first_name;
  
ALTER TABLE actor
  ADD COLUMN middle_name VARCHAR(50) AFTER first_name;
  
-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.--
-- ??????????--

ALTER TABLE actor
MODIFY COLUMN middle_name BLOB;

	-- 3c. Now delete the middle_name column.
  
ALTER TABLE actor
DROP COLUMN middle_name;

	-- 4a. List the last names of actors, as well as how many actors have that last name.

SELECT last_name, COUNT AS 'Number of Actors' 
FROM actor GROUP BY last_name;

SELECT 
    last_name, COUNT(*) AS 'Number of Actors'
FROM
    actor
GROUP BY last_name;

	-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
  
SELECT 
    last_name, COUNT(*) AS 'Number of Actors'
FROM
    actor
GROUP BY last_name
HAVING COUNT(*) >= 2;

-- 4c. Oh, no! The actor `HARPO WILLIAMS` was accidentally entered in the `actor` 
--     table as `GROUCHO WILLIAMS`, the name of Harpo's second cousin's husband's
--     yoga teacher. Write a query to fix the record.

UPDATE actor 
SET 
    first_name = 'HARPO'
WHERE
    First_name = 'GROUCHO'
        AND last_name = 'WILLIAMS';


  
-- 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. 
--     It turns out that `GROUCHO` was the correct name after all!
--     In a single query, if the first name of the actor is currently
--     `HARPO`, change it to `GROUCHO`. Otherwise, change the first
--     name to `MUCHO GROUCHO`, as that is exactly what the actor will
--     be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST
--     NAME OF EVERY ACTOR TO `MUCHO GROUCHO`, HOWEVER! (Hint: update
--     the record using a unique identifier.)

UPDATE actor 
SET 
    first_name = 'GROUCHO'
WHERE
    actor_id = 172;
    

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?


#   Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html--

DESCRIBE sakila.address;


-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:


SELECT 
    first_name, last_name, address
FROM
    staff
        JOIN
    address ON address_id = address_id;
    

SELECT 
    first_name, last_name, address
FROM
    staff s
        JOIN
    address a ON s.address_id = a.address_id;
    
-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.

SELECT 
    payment.staff_id,
    staff.first_name,
    staff.last_name,
    payment.amount,
    payment.payment_date
FROM
    staff
        INNER
    payment ON staff.staff_id = payment.staff_id
        AND payment_date LIKE '2005-08';

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.--  
    
SELECT 
    f.title AS 'Film Title',
    COUNT(fa.actor_id) AS 'Number of Actors'
FROM
    film_actor fa
        INNER JOIN
    film f ON fa.film_id = f.film_id
GROUP BY f.title;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
    
SELECT 
    title,
    (SELECT 
            COUNT(*)
        FROM
            inventory
        WHERE
            film.film_id = inventory.film_id) AS 'Amount of Copies'
FROM
    film
WHERE
    title = 'Hunchback Impossible';
    
-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last 
-- ??????? could not get to run

SELECT 
    c.first_name, c.last_name, SUM(p.amount) AS 'Total amount paid'
FROM
    customer c
        JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY c.last_name;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

SELECT 
    title
FROM
    film
WHERE
    title LIKE 'K%'
        OR title LIKE 'Q%'
        AND title IN (SELECT 
            title
        FROM
            film
        WHERE
            language_id = 1);
            
-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));
                    
-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

SELECT 
    c.first_name, c.last_name, c.email
FROM
    customer c
        JOIN
    address a ON (c.address_id = a.address_id)
        JOIN
    city cty ON (cty.city_id = a.city_id)
        JOIN
    country ON (country.country_id = cty.country_id)
WHERE
    country.country = 'Canada';
    
-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT 
    title, description
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'Family'));
                    
-- 7e. Display the most frequently rented movies in descending order.

SELECT 
    f.title, COUNT(rental_id) AS 'Rentals'
FROM
    rental r
        JOIN
    inventory i ON (r.inventory_id = i.inventory_id)
        JOIN
    film f ON (i.film_id = f.film_id)
GROUP BY f.title
ORDER BY `Rentals` DESC;
