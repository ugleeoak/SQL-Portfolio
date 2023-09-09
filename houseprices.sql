-- analysing house prices in london
-- using dataset gotten from kaggle
-- viewing the data 


SELECT 
	*
FROM 
	houseprices
	
	-- deleting duplicate data
	
  
 WITH duplicates AS (
	SELECT
		id,
		street,
		garden,
		size_sqft,
		price_pounds,
		ROW_NUMBER() OVER (
      PARTITION BY
        id,
		street,
		size_sqft,
		price_pounds
	ORDER BY
		id
    ) AS row_num
	FROM
		houseprices
)
DELETE
FROM
	houseprices
WHERE
	(id,
	street,
	size_sqft,
	price_pounds) IN (
	SELECT
		id,
		street,
		size_sqft,
		price_pounds
	FROM
		duplicates
	WHERE
		row_num > 1
)
	
	-- analysing the data
	-- finding the average prices of houses based on number of bedrooms


SELECT
	DISTINCT
    bedrooms,
	COUNT(bedrooms) AS house_count,
	ROUND(AVG(price_pounds)) AS average_price
FROM
	houseprices
WHERE
	bedrooms IS NOT NULL
GROUP BY
	bedrooms
ORDER BY
	bedrooms
	
	
	-- finding the most expensive and cheapest houses in the data

WITH max_min_prices AS (
    SELECT
        MAX(price_pounds) AS max_price,
        MIN(price_pounds) AS min_price
    FROM
        houseprices
)
SELECT
    h.id,
    h.bedrooms,
    h.street,
    h.price_pounds
FROM
    houseprices h
JOIN
    max_min_prices m
ON
    h.price_pounds = m.max_price OR h.price_pounds = m.min_price;


