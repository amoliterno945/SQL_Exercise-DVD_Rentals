#Setting up recurringly referenced variables
SET @total =(SELECT SUM(TOTALAMOUNT) FROM summarytable);
SET @total_count =(SELECT COUNT(TOTALAMOUNT) FROM summarytable);

#Question A
SELECT SUM(TOTALAMOUNT)/@total
FROM summarytable
GROUP BY Customer_type;

#Question B 
SELECT CATEGORYNAME, count(*)/@total_count,SUM(TOTALAMOUNT)/@total 
FROM summarytable
GROUP BY CATEGORYNAME;

#Question C 
SELECT 
	DATE_FORMAT(ORDERDATE, '%m/%Y') AS MonthYear, 
    #ORDERDATE AS Yr, 
	SUM(TOTALAMOUNT) as MonthYear_Sum,
    
    #SUM(TOTALAMOUNT) OVER (PARTITION BY DATE_FORMAT(ORDERDATE, '%Y')  ORDER BY ORDERDATE ASC) AS YTD_Sum 
	(SELECT SUM(s.TOTALAMOUNT) 
	FROM summarytable s
	WHERE DATE_FORMAT(s.ORDERDATE, '%m/%Y') <= MonthYear AND
	YEAR(s.ORDERDATE) = YEAR(ORDERDATE) #Yr
    ) AS YTD_Sum 
    
FROM summarytable
GROUP BY MonthYear;

#Question D
SELECT
	CASE WHEN Age < 18 THEN '<18'
		WHEN Age>= 18 AND Age < 30 THEN '18 - 30'
		WHEN Age>= 31 AND Age < 40 THEN '31 - 40'
		WHEN Age>= 40 AND Age < 50 THEN '41 - 50'
		WHEN Age>= 50 THEN '>50'
	END as AgeGroups,
    SUM(TOTALAMOUNT) / @total AS percent_of_sales
FROM (SELECT Age,TOTALAMOUNT FROM summarytable) as alias1
GROUP by AgeGroups;
