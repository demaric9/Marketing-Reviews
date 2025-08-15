-- Table dim_customer
SELECT * FROM dbo.customers;
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customers';
-- EDA 

SELECT * FROM dbo.customers 
WHERE CustomerID is null;

SELECT * FROM dbo.customers 
WHERE CustomerName is null;

SELECT * FROM dbo.customers 
WHERE Email is null;

SELECT * FROM dbo.customers
WHERE Gender is null;

SELECT * FROM dbo.customers
WHERE Age is null;

SELECT * FROM dbo.customers
WHERE GeographyID is null;

SELECT GeographyID FROM dbo.geography;

SELECT GeographyID FROM dbo.customers
WHERE GeographyID NOT IN (
	SELECT GeographyID FROM dbo.geography
); -- check whether the geoID in customers is null (means not link to the geography table => no address)
   -- all clear

SELECT CustomerID, COUNT(*) FROM dbo.customers
GROUP BY CustomerID HAVING COUNT(*) >= 2; -- No duplicate value

-- No columns null
-- Since the geographyID is both on customer and geography, we will join them in order to enrich the customer 

SELECT 
	c.CustomerID, -- unique identifier
	c.CustomerName,
	c.Email,
	c.Gender,
	c.Age,
	g.City,
	g.Country
FROM dbo.customers c
LEFT JOIN dbo.geography g
	ON c.GeographyID = g.GeographyID

-- Since the geographyID in customer is all exists on geography table, left join is no big deal