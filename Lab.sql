-- 1. Get all pairs of actors that worked together.
SELECT a1.actor_id AS actor1_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
       a2.actor_id AS actor2_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name
FROM film_actor fa1
JOIN film_actor fa2 ON fa2.film_id = fa1.film_id AND fa2.actor_id != fa1.actor_id
JOIN actor a1 ON a1.actor_id = fa1.actor_id
JOIN actor a2 ON a2.actor_id = fa2.actor_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.
SELECT r1.customer_id AS customer1_id, c1.first_name AS customer1_first_name, c1.last_name AS customer1_last_name,
       r2.customer_id AS customer2_id, c2.first_name AS customer2_first_name, c2.last_name AS customer2_last_name,
       r1.inventory_id, f.title
FROM rental r1
JOIN rental r2 ON r2.inventory_id = r1.inventory_id AND r2.customer_id != r1.customer_id
JOIN customer c1 ON c1.customer_id = r1.customer_id
JOIN customer c2 ON c2.customer_id = r2.customer_id
JOIN inventory i ON i.inventory_id = r1.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE r1.inventory_id IN (
    SELECT r.inventory_id
    FROM rental r
    GROUP BY r.inventory_id
    HAVING COUNT(*) > 3
)
GROUP BY r1.customer_id, r2.customer_id, r1.inventory_id;

-- 3. Get all possible pairs of actors and films.
SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title
FROM actor a, film f;