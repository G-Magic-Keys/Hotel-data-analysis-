USE projects;
GO

-- Step 1: Define the CTE
WITH hotels AS (
    SELECT * FROM dbo.[2018$]
    UNION ALL
    SELECT * FROM dbo.[2019$]
    UNION ALL
    SELECT * FROM dbo.[2020$]
)

-- Step 2: Aggregation query for revenue
SELECT
    arrival_date_year,
    hotel,
    ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr), 0) AS revenue
FROM hotels
GROUP BY arrival_date_year, hotel;

-- Step 3: Join with market_segment$ and meal_cost$
WITH hotels AS (
    SELECT * FROM dbo.[2018$]
    UNION ALL
    SELECT * FROM dbo.[2019$]
    UNION ALL
    SELECT * FROM dbo.[2020$]
)
SELECT *
FROM hotels AS h
LEFT JOIN dbo.[market_segment$] AS ms
    ON h.market_segment = ms.market_segment
LEFT JOIN dbo.[meal_cost$] AS mc
    ON mc.meal = h.meal;
