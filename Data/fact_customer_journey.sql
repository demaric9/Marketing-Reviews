-- fact_customer_journey table
SELECT * FROM dbo.customer_journey;
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer_journey';

-- EDA
SELECT * FROM dbo.customer_journey
WHERE JourneyID is null
	OR CustomerID is null
	OR ProductID is null
	OR VisitDate is null
	OR Stage is null
	OR Action is null
	OR Duration is null;

SELECT COUNT(*) FROM dbo.customer_journey
WHERE Duration is null;   

-- 613 value Duration null

SELECT JourneyID
FROM dbo.customer_journey
WHERE Duration IS NULL
GROUP BY JourneyID
HAVING COUNT(DISTINCT VisitDate) = 1;

SELECT JourneyID FROM dbo.customer_journey
WHERE Action = 'Purchase';

SELECT COUNT(*) FROM dbo.customer_journey
WHERE Action = 'Purchase';


-- JourneyID duplicate, we need to specify entire column to get it separate
-- Normalize the table 
-- Using PARTITION to normalize the Duration column by Visit date
-- Using ROW_NUMBER to deduplicate the JourneyID by entire columns

WITH cleaned_customer_journey AS (
	SELECT
		JourneyID,
		CustomerID,
		ProductID,
		CONVERT(DATE, VisitDate) AS VisitDate,
		UPPER(Stage) AS Stage,
		Action,
		Duration,
		AVG(Duration) OVER(PARTITION BY VisitDate) AS Avg_duration,
		ROW_NUMBER() OVER(
			PARTITION BY JourneyID,CustomerID,ProductID,VisitDate,Stage,Action
			ORDER BY JourneyID
		) as rn
	FROM dbo.customer_journey
)
SELECT
	JourneyID,
    CustomerID,
    ProductID,
    VisitDate,
    Stage,
    Action,
	COALESCE(Duration, Avg_duration) AS Duration
FROM cleaned_customer_journey
WHERE rn = 1
ORDER BY JourneyID;
