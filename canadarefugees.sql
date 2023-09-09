
-- analysing canada refugee data 

SELECT
	*
FROM 
	canadarefugee;

-- finding out which country canada admitted the highest number of refugee from 2012 to 2022
		

SELECT 
    DISTINCT country_of_origin,
    SUM(total_count) AS total
FROM 
    canadarefugee
GROUP BY 
    country_of_origin
ORDER BY 
    total DESC;
    
  -- what is the total number of resettled refugees per year
   
 SELECT 
 	 DISTINCT year,
 	 SUM(total_count) AS total
 FROM 
 	 canadarefugee
 GROUP BY 
 	 year;
 	 
 -- what countries of origin for the majority of aslyum claims (top 5)
 	 
 SELECT
 	DISTINCT country_of_origin,
 	SUM(Asylum_seekers) AS total_asylum_seekers
 FROM
 	canadarefugee
 WHERE country_of_origin <> 'unknown'
 GROUP BY 
 	country_of_origin
 ORDER BY 
 	total_asylum_seekers DESC
 LIMIT 5;

 -- what is the tatal number of asylum claims made each year

 SELECT 
 	 DISTINCT year,
 	 SUM(Asylum_seekers) AS total_asylum_seekers
 FROM 
 	 canadarefugee
 GROUP BY 
 	 year;
 	 
 	 