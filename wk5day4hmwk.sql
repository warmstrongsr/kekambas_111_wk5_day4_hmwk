--Week 5 - Thursday Questions
--
--1. Create a Stored Procedure that will insert a new film into the film table with the
--following arguments: title, description, release_year, language_id, rental_duration,
--rental_rate, length, replace_cost, rating

SELECT *
FROM film

CREATE OR REPLACE PROCEDURE add_new_film(
    title varchar(255),
    description text,
    release_year int,
    language_id int,
    rental_duration int,
    rental_rate numeric(4, 2),
    length int,
    replace_cost numeric(5, 2),
    rating varchar(10)
)
LANGUAGE plpgsql
AS $$
BEGIN 
    INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update)
    VALUES(title, description, release_year, language_id, rental_duration, rental_rate, length, replace_cost, rating::mpaa_rating, now());
END;
$$;

CALL add_new_film('Homework Film', 'Some Film', 2023, 1, 5, 3.99, 120, 12.99, 'PG-13');

--film_id|title                  |description              
---------+-----------------------+-------------------------
--   1002|Homework Film          |Some Film                
--   1000|Zorro Ark              |A Intrepid Panorama of a 
--    999|Zoolander Fiction      |A Fateful Reflection of a
--    998|Zhivago Core           |A Fateful Yarn of a Compo



--2. Create a Stored Function that will take in a category_id and return the number of
--films in that category

SELECT*
FROM film_category 

CREATE OR REPLACE FUNCTION film_category_count(num INT)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
    DECLARE category_count INTEGER;
BEGIN 
    SELECT COUNT(*) INTO category_count
    FROM film_category 
    WHERE category_id = (num); 
    RETURN category_count;
    END;
$$;

SELECT film_category_count(3);

--film_category_count|
---------------------+
--                 64|
