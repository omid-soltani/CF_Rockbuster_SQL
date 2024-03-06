-- This is a query to find the top 5 customers within each country using CTEs

WITH top_customers AS
		(SELECT c.customer_id,
	 		c.first_name,
	 		c.last_name,
	 		co.country_id,
	 		ci.city,
	 		SUM(p.amount) AS total_amount_paid
		FROM customer c
		INNER JOIN address a ON c.address_id = a.address_id
		INNER JOIN city ci ON a.city_id = ci.city_id
		INNER JOIN country co ON ci.country_id = co.country_id
		INNER JOIN payment p ON c.customer_id = p.customer_id 
		WHERE ci.city IN ('Aurora',
							'Acua',
							'Citrus Heights',
							'Iwaki',
							'Ambattur',
							'Shanwei',
							'So Leopoldo',
							'Teboksary',
							'Tianjin',
							'Cianju')
   GROUP BY c.customer_id,
   			c.first_name,
   			c.last_name,
   			co.country_id,
   			ci.city
   ORDER BY total_amount_paid DESC
   LIMIT 5) 
SELECT co.country,
		COUNT(DISTINCT c.customer_id) AS all_customer_count,
		COUNT(DISTINCT tc.customer_id) AS top_customer_count
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
LEFT JOIN top_customers tc ON c.customer_id = tc.customer_id
GROUP BY co.country
ORDER BY all_customer_count DESC
LIMIT 5;