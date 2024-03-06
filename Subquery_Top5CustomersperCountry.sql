-- This is a query to find the top 5 customers within each country

SELECT D.country,
	COUNT(DISTINCT A.customer_id) AS all_customer_count,
	COUNT(DISTINCT top_5_customers.customer_id) AS top_customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
LEFT JOIN
  (SELECT A.customer_id,
	A.first_name,
	A.last_name,
	D.country_id,
	C.city,
	SUM(E.amount) AS total_amount_paid
   FROM customer A
   INNER JOIN address B ON A.address_id = B.address_id
   INNER JOIN city C ON B.city_id = C.city_id
   INNER JOIN country D ON C.country_id = D.country_id
   INNER JOIN payment E ON A.customer_id = E.customer_id
   WHERE C.city IN ('Aurora',
					'Acua',
					'Citrus Heights',
					'Iwaki',
					'Ambattur',
					'Shanwei',
					'So Leopoldo',
					'Teboksary',
					'Tianjin',
					'Cianju')
   GROUP BY A.customer_id,
   			A.first_name,
   			A.last_name,
   			D.country_id,
   			C.city
   ORDER BY total_amount_paid DESC
   LIMIT 5) top_5_customers ON A.customer_id = top_5_customers.customer_id
GROUP BY D.country
ORDER BY all_customer_count DESC
LIMIT 5;