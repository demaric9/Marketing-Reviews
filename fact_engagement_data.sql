-- fact_engagement_data table
SELECT * FROM dbo.engagement_data;
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'engagement_data';
SELECT DISTINCT ContentType FROM dbo.engagement_data;

-- EDA
SELECT * FROM dbo.engagement_data
WHERE EngagementID is null
	OR ContentID is null
	OR ContentType is null
	OR Likes is null
	OR EngagementDate is null
	OR CampaignID is null
	OR ProductID is null
	OR ViewsClicksCombined is null;

-- no columns null
SELECT EngagementID, COUNT(*) as cnt
FROM dbo.engagement_data 
GROUP BY EngagementID HAVING COUNT(*) >= 2;

-- Normalize the table
SELECT 
	EngagementID, -- unique identifier
	ContentID, 
	CampaignID,
	ProductID,
	CASE 
		WHEN ContentType LIKE '%socialmedia%' THEN 'Social_Media'
		WHEN ContentType LIKE '%video%' THEN 'Video'
		ELSE 'Blog'
	END AS ContentType,
	LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS Views,
	RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks,
	Likes,
	CONVERT(DATE, EngagementDate) AS EngagementDate
FROM 
	dbo.engagement_data
WHERE
	ContentType != 'Newsletter';
