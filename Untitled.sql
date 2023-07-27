-- joining the three tables (customer, marketing and sales) to create a new table

SELECT *
FROM customer
JOIN sales ON customer.id = sales.id
JOIN marketing ON sales.id = marketing.id;

-- Average customers' income

SELECT AVG(Income)
FROM customer;

-- most common marital status
-- from the data 1 = yes, 0 = no 

SELECT 
COUNT(CASE WHEN Married = 1 THEN 1 END) AS TotalMarried,
COUNT(CASE WHEN Divorced = 1 THEN 1 END) AS TotalDivorced,
COUNT(CASE WHEN Single = 1 THEN 1 END) AS TotalSingle,
COUNT(CASE WHEN Together = 1 THEN 1 END) AS TotalTogether,
COUNT(CASE WHEN Widow = 1 THEN 1 END) AS TotalWidow
FROM customer;

-- youngest and oldest customer

SELECT MAX(Age), MIN(Age)
FROM customer;



