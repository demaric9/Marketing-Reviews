-- Table dim_product categorize and cleaning
SELECT * FROM dbo.products;

-- EDA
SELECT * FROM dbo.products 
WHERE productID is null;

SELECT * FROM dbo.products 
WHERE ProductName is null;

SELECT * FROM dbo.products 
WHERE Price is null;

SELECT * FROM dbo.products 
WHERE Category is null;

SELECT ProductID, COUNT(*) FROM dbo.products 
GROUP BY ProductID HAVING COUNT(*) >= 2;  -- No duplicate value

-- No columns null
-- Data categorize
-- Since the Category column is the same (Sport) so we will remove the column
SELECT
	ProductID, -- unique identifier
	ProductName,
	Price, 
	CASE 
		WHEN Price < 50 THEN 'Low'
		WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
		ELSE 'High'
	END AS PriceCategory

FROM dbo.products
