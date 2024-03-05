SELECT *
FROM sets

SELECT *
FROM themes

--What 5 sets have the most lego parts?
SELECT TOP 5 set_names,num_parts
FROM sets
GROUP BY set_names,num_parts
ORDER BY num_parts DESC

--What theme has the most sets?
SELECT TOP 1 legothemes.theme_names,COUNT(legosets.set_names) AS CountSets
FROM sets AS legosets
INNER JOIN themes AS legothemes
ON legosets.theme_id=legothemes.theme_id
GROUP BY legothemes.theme_names
ORDER BY CountSets DESC

--Find what sets were released between the years 2018 and 2023. Include theme id, theme name, set number, set name, and year 
SELECT legothemes.theme_id,legothemes.theme_names,legosets.set_num,legosets.set_names,legosets.year
FROM sets AS legosets
INNER JOIN themes AS legothemes
ON legosets.theme_id=legothemes.theme_id
WHERE year between 2018 and 2023
GROUP BY legothemes.theme_id,legothemes.theme_names,legosets.set_num,legosets.set_names,legosets.year
ORDER BY year ASC

--What is the average part count per year?
SELECT sets.year,AVG(num_parts) AS AvgParts
FROM sets
GROUP BY sets.year
ORDER BY sets.year


