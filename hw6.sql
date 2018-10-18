USE sakila;

select first_name, last_name  from actor;
 
SELECT CONCAT(UPPER(actor.first_name), ' ', UPPER(actor.last_name))  

AS ACTOR_NAME

FROM actor;
 
 
 SELECT actor_id, first_name, last_name  FROM ACTOR
 
 WHERE first_name = 'Joe';
 
 
 SELECT actor_id, first_name, last_name  FROM ACTOR
 WHERE last_name LIKE  '%GEN%';
 
  
 SELECT actor_id, first_name, last_name  FROM ACTOR
 WHERE last_name LIKE  '%LI%'
 ORDER BY last_name, first_name;
 
 SELECT country_id, country FROM country
 WHERE country in ('AFGHANISTAN', 'BANGLADESH', 'CHINA');

ALTER TABLE actor

ADD COLUMN description BLOB;

ALTER TABLE actor

DROP COLUMN description;

SELECT last_name, COUNT(last_name)
FROM actor
group by last_name;

SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(actor.last_name) >= 2;

UPDATE actor
SET first_name = 'Harpo'
WHERE first_name = 'GROUCHO' AND last_name = 'Williams';

UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' AND last_name = 'Williams';

select * from actor
where first_name = 'GROUCHO';

SHOW CREATE TABLE sakila.address;



SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address on staff.address_id = address.address_id;

SELECT staff.first_name, staff.last_name, COUNT(payment.payment_id) as 'Total Payment'

FROM payment
INNER JOIN staff on staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name;


SELECT film.title, COUNT(film_actor.actor_id) AS 'FILM COUNT'
FROM film
INNER JOIN film_actor on film.film_id = film_actor.film_id
GROUP BY film.title;

SELECT title, COUNT(inventory_id)
FROM film 
INNER JOIN inventory
ON film.film_id = inventory.film_id
WHERE title = "Hunchback Impossible";

SELECT customer.first_name, customer.last_name, SUM(amount)
from payment
INNER JOIN customer 
ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY last_name ASC;


SELECT title FROM film
WHERE language_id in
(SELECT language_id
FROM  language
WHERE name = 'ENGLISH')
and (title LIKE 'K%') or (title like 'Q%');


SELECT last_name, first_name
FROM actor
WHERE actor_id in
(SELECT actor_id FROM film_actor
WHERE film_id in 
(SELECT film_id FROM film
WHERE title = "Alone Trip"));

SELECT country, last_name, first_name, email
FROM country 
LEFT JOIN customer
ON country.country_id = customer.customer_id
WHERE country = 'Canada';

SELECT title, category
FROM film_list
WHERE category = 'Family';

SELECT inventory.film_id, film_text.title, COUNT(rental.inventory_id)
FROM inventory
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_text  
ON inventory.film_id = film_text.film_id
GROUP BY rental.inventory_id
ORDER BY COUNT(rental.inventory_id) DESC;


SELECT store.store_id, SUM(amount)
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment
ON payment.staff_id = staff.staff_id
GROUP BY store.store_id
ORDER BY SUM(amount);

SELECT store.store_id, city, country
FROM store
INNER JOIN customer
ON store.store_id = customer.store_id
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id;

SELECT name, SUM(payment.amount)
FROM category
INNER JOIN film_category
INNER JOIN inventory
ON inventory.film_id = film_category.film_id
INNER JOIN rental
ON rental.inventory_id = inventory.inventory_id
INNER JOIN payment
GROUP BY name
LIMIT 5;



CREATE VIEW top_five_genres AS

SELECT name, SUM(payment.amount)
FROM category
INNER JOIN film_category
INNER JOIN inventory
ON inventory.film_id = film_category.film_id
INNER JOIN rental
ON rental.inventory_id = inventory.inventory_id
INNER JOIN payment
GROUP BY name
LIMIT 5;
SELECT * FROM top_five_genres;

DROP VIEW top_five_genres;
