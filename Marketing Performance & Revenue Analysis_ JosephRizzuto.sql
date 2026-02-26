-- 13 total querires relevant to Marketing Performance & Revenue Analysis by Joseph Rizzuto.

-- QUERY 1 - GROUP BY -  Office code, city, & state.
SELECT
	officeCode,
	city,
	state,
COUNT(employeeNumber) AS employeeCnt
FROM
	employees
JOIN offices using (officeCode)
GROUP BY officeCode;
-- JOSEPH RIZZUTO


-- QUERY 2 	-- GROUP BY -- Order totals by country.
SELECT 
	country,
	orderDate,
	COUNT(*) totalOrders
FROM orders
JOIN customers USING (customerNumber)
GROUP BY country,OrderDate;
-- JOSEPH RIZZUTO


-- QUERY 3 -- HAVING -- Employee count by city.
SELECT
	officeCode
    city,
    COUNT(employeeNumber) AS employeeCnt
FROM
	employees
    JOIN offices USING (officeCode)
    WHERE officeCode IN (1,2,4,5) 
GROUP BY officeCode
HAVING employeeCnt > 4;
-- JOSEPH RIZZUTO


-- QUERY 4 -- HAVING - COUNTRY'S WITH MORE THAN 20 ORDERS.
SELECT 
	country,
	COUNT(*) AS totalOrders
FROM orders
JOIN customers USING (customerNumber)
WHERE country IN ("France","Japan","Finland","USA")
GROUP BY country
HAVING totalOrders >20;
-- JOSEPH RIZZUTO


-- QUERY 5 -- TOTAL PAYMENTS FROM EACH CUSTOMER AFTER A CERTAIN DATE.
SELECT
	customerNumber,
    customerName,
    SUM(amount) AS totalOrderValue
FROM payments
JOIN customers USING (customerNumber)
WHERE paymentDate > '2004-02-02'
GROUP BY customerNumber;
-- JOSEPH RIZZUTO


-- QUERY 6 -- Value of each order sorted by total value
SELECT 
	orderNumber,
    SUM(quantityOrdered*priceEach) AS orderTotal
FROM orderDetails
GROUP BY orderNumber
ORDER BY orderTotal DESC;
-- JOSEPH RIZZUTO


-- QUERY 7 -- Customer name & number. The value of each order sorted by total value, including name & customer number.
SELECT
	orderNumber,
    customerNumber,
    customerName,
    SUM(quantityOrdered*priceEach) AS orderTotal
FROM orderDetails
JOIN orders USING (orderNumber)
JOIN customers USING (customerNumber)
GROUP BY orderNumber
ORDER BY orderTotal DESC;
-- JOSEPH RIZZUTO


-- QUERY 8 -- Sales Rep/ employee name with corresponding customer name & number, order #, order total.
SELECT
	orderNumber,
    employeeNumber,
    firstName AS employeeName,
    customerNumber,
    customerName,
    SUM(quantityOrdered*priceEach) AS orderTotal
FROM orderDetails
JOIN orders USING (orderNumber)
JOIN customers USING (customerNumber)
JOIN employees
	ON customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY orderNumber
ORDER BY orderTotal DESC;
-- JOSEPH RIZZUTO


-- QUERY 9 -- COUNT OF ORDERS PLACED BY EACH CUSTOMER & SALESREP FOR EACH.
SELECT
	customerNumber,
    customerName,
    firstName AS employeeName,
    COUNT(*) cntOrdersByCustomer
FROM orders
JOIN customers USING (customerNumber)
JOIN employees
	ON customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY customerNumber;
-- JOSEPH RIZZUTO


-- QUERY 10 -- NUMBER OF ORDERS THROUGH EACH SALES REPRESENTATIVE.
SELECT  
COUNT(orderNumber) AS numberOfOrders,
	employeeNumber,
firstName AS employeeName
FROM orders
JOIN customers USING (customerNumber)
JOIN employees
	ON customers.salesRepEmployeeNumber = employees.employeeNumber
    GROUP BY employeeNumber;
-- JOSEPH RIZZUTO
    
    
-- QUERY 11 -- Count of orders per country.
SELECT
	country,
	COUNT(*) AS totalOrders
FROM orders
JOIN customers USING (customerNumber)
GROUP BY country;
-- JOSEPH RIZZUTO


-- QUERY 12 -- Count of orders made by each country & order date (individual ordered per order).
SELECT
	country,
    orderDate,
	COUNT(*) AS totalOrders
FROM orders
JOIN customers USING (customerNumber)
GROUP BY country,orderDate;
-- JOSEPH RIZZUTO


-- Query 13 -- Finding customers whose order value > 80,000 across total orders
SELECT
	c.customerNumber,
	c.customerName,
SUM(od.quantityOrdered * od.priceEach) AS totalOrderValue
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderDetails od USING (orderNumber)
GROUP BY
	c.customerNumber,
    c.customerName
HAVING totalOrderValue > 80000;
-- JOSEPH RIZZUTO

-- Thank you for your time.