SELECT ARRAY_AGG(company || ' ') AS valuestocks 
FROM(
	SELECT company, RIGHT(CAST(grp_date AS VARCHAR), 2) AS end_year
	FROM(
		SELECT company, fiscal_year, 
       	fiscal_year - ROW_NUMBER() OVER (PARTITION BY company ORDER BY fiscal_year) grp_date
		FROM dividend
		) A
GROUP BY company, end_year
HAVING COUNT(*) > 2) b;