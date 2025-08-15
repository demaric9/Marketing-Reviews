SELECT * FROM dbo.customer_reviews;
SELECT COUNT(*) FROM dbo.customer_reviews;
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer_reviews';

-- EDA
SELECT * FROM dbo.customer_reviews
WHERE ReviewID is null;

SELECT * FROM dbo.customer_reviews
WHERE CustomerID is null;

SELECT * FROM dbo.customer_reviews
WHERE ProductID is null;

SELECT * FROM dbo.customer_reviews
WHERE ReviewDate is null;

SELECT * FROM dbo.customer_reviews
WHERE Rating is null;

SELECT * FROM dbo.customer_reviews
WHERE ReviewText is null;

SELECT * FROM dbo.customer_reviews
WHERE rating < 0;

SELECT ReviewID, COUNT(*) FROM dbo.customer_reviews
GROUP BY ReviewID 
HAVING COUNT(*) >= 2; 

SELECT CustomerID, COUNT(*) as count_of_reviews FROM dbo.customer_reviews
GROUP BY CustomerID
HAVING COUNT(*) >= 2
ORDER BY count_of_reviews DESC; -- same customer with many reviews

-- no duplicate value
-- no columns null

SELECT 
	ReviewID, -- unique identifier
	CustomerID,
	ProductID,
	CONVERT(DATE, ReviewDate) AS ReviewDate,
	Rating,
	REPLACE(ReviewText, '  ', ' ') as ReviewText
FROM dbo.customer_reviews;

SELECT COUNT(*) FROM dbo.customer_reviews
WHERE rating = 5;




