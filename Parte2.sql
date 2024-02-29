--1.
SELECT product_id, product_name, unit_price 
FROM products 
WHERE unit_price BETWEEN 15 AND 20;
--2.
SELECT p.product_id, p.product_name, c.category_name 
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE p.discontinued = 1;
--3.
SELECT product_id, product_name, unit_price 
FROM products 
WHERE unit_price > (SELECT AVG(unit_price) FROM products);
--4
SELECT o.order_id, SUM((od.unit_price * od.quantity) * (1 - od.discount)) AS total_order_amount 
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
WHERE o.shipped_date IS NULL
GROUP BY o.order_id;
--5
SELECT MAX(unit_price) AS most_expensive, MIN(unit_price) AS least_expensive 
FROM products;
--6
SELECT customer_id, COUNT(*) AS total_orders 
FROM orders 
GROUP BY customer_id 
ORDER BY total_orders DESC 
LIMIT 1;
--7
SELECT p.product_name, SUM((od.unit_price * od.quantity) * (1 - od.discount)) AS revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;
