DROP VIEW IF EXISTS summarytable;
CREATE VIEW summarytable AS  
	SELECT
		o.ORDERID,
		o.ORDERDATE,
		c.CUSTOMERID,
		o.TOTALAMOUNT,
		ol.QUANTITY,
		cat.CATEGORYNAME,
		p.TITLE,
		c.CITY,
		c.STATE,
		c.COUNTRY,
		c.AGE,
		c.INCOME,
		c.GENDER,
		
		(SELECT
			CASE
				WHEN
					(SELECT
						count(*)
					FROM
						orders o1 
							LEFT JOIN
						customers c1 ON c1.CUSTOMERID = o1.CUSTOMERID
					WHERE 
						c1.CUSTOMERID = c.CUSTOMERID AND
						o1.ORDERDATE < o.ORDERDATE) = 0
				THEN
					'new'
				ELSE
					'existing'
		END AS Customer_type0) AS Customer_type,

		#sum(ol.QUANTITY) OVER (PARTITION BY c.CUSTOMERID ORDER BY o.ORDERDATE ASC) as Cumulative_order_count

		(SELECT SUM(ol2.QUANTITY) 
		FROM
			orders o2 
				LEFT JOIN
			customers c2 ON c2.CUSTOMERID = o2.CUSTOMERID
				INNER JOIN
			orderlines ol2 ON ol2.ORDERID = o2.ORDERID
		WHERE c2.CUSTOMERID = c.CUSTOMERID AND
			o2.ORDERDATE <= o.ORDERDATE
		ORDER BY o2.ORDERDATE ASC) AS Cumulative_order_count,

		#sum(o.TOTALAMOUNT) OVER (PARTITION BY c.CUSTOMERID ORDER BY o.ORDERDATE ASC) as Cumulative_$_amount,

		(SELECT SUM(o3.TOTALAMOUNT) 
		FROM
			orders o3 
				LEFT JOIN
			customers c3 ON c3.CUSTOMERID = o3.CUSTOMERID
				INNER JOIN
			orderlines ol3 ON ol3.ORDERID = o3.ORDERID
		WHERE c3.CUSTOMERID = c.CUSTOMERID AND
			o3.ORDERDATE <= o.ORDERDATE
		ORDER BY o3.ORDERDATE ASC) AS Cumulative_$_amount

	FROM
		orders o 
			LEFT JOIN
		customers c ON c.CUSTOMERID = o.CUSTOMERID
			INNER JOIN
		orderlines ol ON ol.ORDERID = o.ORDERID
			INNER JOIN
		products p ON p.PROD_ID = ol.PROD_ID
			INNER JOIN
		categories cat on cat.CATEGORY = p.CATEGORY
	ORDER BY o.ORDERDATE ASC;

		



    