-- Retrieve all columns from the 'sets' table
SELECT *
FROM sets;

-- Retrieve all columns from the 'themes' table
SELECT *
FROM themes;

-- Identify the 5 sets with the most LEGO parts
SELECT TOP 5 set_names, num_parts
FROM sets
GROUP BY set_names, num_parts
ORDER BY num_parts DESC;

-- Determine the theme with the most sets
SELECT TOP 1 legothemes.theme_names, COUNT(legosets.set_names) AS CountSets
FROM sets AS legosets
INNER JOIN themes AS legothemes ON legosets.theme_id = legothemes.theme_id
GROUP BY legothemes.theme_names
ORDER BY CountSets DESC;

-- Find sets released between 2018 and 2023, including theme ID, theme name, set number, set name, and year
SELECT legothemes.theme_id, legothemes.theme_names, legosets.set_num, legosets.set_names, legosets.year
FROM sets AS legosets
INNER JOIN themes AS legothemes ON legosets.theme_id = legothemes.theme_id
WHERE year BETWEEN 2018 AND 2023
GROUP BY legothemes.theme_id, legothemes.theme_names, legosets.set_num, legosets.set_names, legosets.year
ORDER BY year ASC;

-- Calculate the average part count per year
SELECT sets.year, AVG(num_parts) AS AvgParts
FROM sets
GROUP BY sets.year
ORDER BY sets.year;

-- Identify the top 5 themes with the highest average part count
SELECT TOP 5 legothemes.theme_names, AVG(sets.num_parts) AS AvgParts
FROM sets
INNER JOIN themes AS legothemes ON sets.theme_id = legothemes.theme_id
GROUP BY legothemes.theme_names
ORDER BY AvgParts DESC;

-- Categorize sets into small, medium, or large based on part count
SELECT
    CASE
        WHEN num_parts <= 50 THEN 'Small'
        WHEN num_parts <= 100 THEN 'Medium'
        ELSE 'Large'
    END AS SizeCategory,
    COUNT(*) AS NumSets
FROM sets
GROUP BY
    CASE
        WHEN num_parts <= 50 THEN 'Small'
        WHEN num_parts <= 100 THEN 'Medium'
        ELSE 'Large'
    END;

-- Find sets with similar part counts to identify any patterns or clusters
SELECT
    A.set_names AS Set1,
    B.set_names AS Set2,
    A.num_parts
FROM
    sets A
INNER JOIN
    sets B ON A.num_parts = B.num_parts AND A.set_names <> B.set_names;

-- Calculate the year-over-year growth rate of LEGO sets
SELECT
    year,
    COUNT(*) AS NumSets,
    LAG(COUNT(*)) OVER (ORDER BY year) AS PrevYearNumSets,
    100.0 * (COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY year)) / LAG(COUNT(*)) OVER (ORDER BY year) AS GrowthRate
FROM
    sets
GROUP BY
    year
ORDER BY
    year;
