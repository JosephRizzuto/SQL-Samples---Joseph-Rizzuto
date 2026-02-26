--  12 Total querires analyzing customer insights prepared by Joseph Rizzuto.


-- Query 1-- Finding products that have same product lines
SELECT productName
FROM products
WHERE productline = 
	(SELECT productline
    FROM products
    WHERE productName = "1917 Grand Touring Sedan");
-- Joseph Rizzuto


-- Query 2 -- Finding products that are more expensive than partiuclar item.
SELECT * 
FROM products
WHERE productLine REGEXP "car" AND MSRP > (
	SELECT MSRP
    FROM products
    WHERE productName = "1936 Merceds-Benz 550k Special Roadster"
    );
-- Joseph Rizzuto


-- Query 3 -- Products more expensive than average cost of all other products.
SELECT * 
FROM products
WHERE productLine REGEXP "car" AND MSRP > (
	SELECT AVG(MSRP)
    FROM products
    WHERE productLine IN ("Classic Cars", "Vintage Cars")
    );
-- Joseph Rizzuto


-- Query 4 -- Product priced higher than AVG price within their product line.
SELECT *
FROM products p
WHERE MSRP > (
	SELECT AVG(MSRP)
    FROM products
    WHERE productLine = p.productLine
);
-- Joseph Rizzuto


-- Query 5 -- COUNT of customers who never placed an order.
SELECT COUNT(customerNumber)
FROM customers
WHERE customerNumber NOT IN (
	SELECT DISTINCT customerNumber
    FROM orders
);
-- Joseph Rizzuto


-- Query 6 -- Each individual customerNumber of who never placed an order.
SELECT customerNumber
FROM customers
LEFT JOIN orders USING (customerNumber)
WHERE orderNumber IS NULL;
-- Joseph Rizzuto


-- Query 7 -- Order Details for particular order JOIN.
SELECT COUNT(*)
FROM customers
WHERE customerNumber IN(
	SELECT customerNumber
    FROM orderDetails
    JOIN orders USING (orderNumber)
    WHERE productCode = "S24_1444"
);
-- Joseph Rizzuto


-- Query 8 -- Full customer details (and order info) for every customer who purchased particular product.
SELECT DISTINCT *
FROM customers
JOIN orders USING (customerNumber)
JOIN orderDetails USING (orderNumber)
WHERE productCode = "S24_1444";
-- Joseph Rizzuto


-- Query 9 -- MAX  price of a truck.
SELECT MAX(MSRP)
FROM products
WHERE productLine LIKE "%truck%";
-- Joseph Rizzuto


-- Query 10-- SELECT all clients who have made at Least 2 payments
SELECT *
FROM customers
WHERE customerNumber =ANY(
	SELECT customerNumber
    FROM payments
   GROUP BY customerNumber
   HAVING COUNT(*)>=2
);
-- Joseph Rizzuto


-- Query 11-- Value above or below average each payment is.
SELECT *,
    (SELECT AVG(amount) FROM payments) AS avgPayment,
    amount - (SELECT AVG(amount) FROM payments) AS "Difference"
FROM payments;
-- Joseph Rizzuto


-- Query 12 -- Payments that are higher than the average payment.
SELECT * 
FROM
	(SELECT *,
		(SELECT AVG(amount) FROM payments) AS avgPayment,
        amount - (SELECT avgPayment) AS Difference
	FROM payments) AS invoiceSummary 
WHERE difference >0;
-- Joseph Rizzuto

-- Thank you for your time.