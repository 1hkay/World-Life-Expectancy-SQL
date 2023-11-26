SELECT * 
FROM world_life_expectancy;


SELECT Country, Year, concat(country, Year), count(concat(country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, concat(country, Year)
HAVING count(concat(country, Year)) > 1
;

SELECT*
FROM(
SELECT Row_ID, 
concat(country, Year),
ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, year)) as Row_num
FROM world_life_expectancy
) AS Row_table
WHERE Row_Num > 1
;

DELETE FROM world_life_expectancy
WHERE 
Row_ID IN (
SELECT Row_ID
FROM (
SELECT Row_ID, 
concat(country, Year),
ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, year)) as Row_num
FROM world_life_expectancy
) AS Row_table
WHERE Row_Num > 1
)
;		


SELECT * 
FROM world_life_expectancy
WHERE Status = ''
;

SELECT distinct (status) 
FROM world_life_expectancy
WHERE Status <> ''
;                                                                                            

SELECT DISTINCT(country)
FROM world_life_expectancy
WHERE status = 'Developing'
;

UPDATE world_life_expectancy
SET STATUS = 'Developing'
WHERE Country IN (SELECT DISTINCT(country)
FROM world_life_expectancy
WHERE status = 'Developing')
;


UPDATE world_life_expectancy t1 
JOIN world_life_expectancy T2
ON t1.Country = t2.country
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developing' 
;

UPDATE world_life_expectancy t1 
JOIN world_life_expectancy T2
ON t1.Country = t2.country
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developed'
;

SELECT *
FROM world_life_expectancy;


SELECT *
FROM world_life_expectancy
WHERE `life expectancy` = '';                             

SELECT t1.country, t1.year, t1.`life expectancy`, 
t2.country, t2.year, t2.`life expectancy`, 
t3.country, t3.year, t3.`life expectancy`,
ROUND((t2.`life expectancy` + t3.`life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country = t2.country
AND t1.year = t2.year - 1 
JOIN world_life_expectancy t3
ON t1.country = t3.country
AND t1.year = t3.year + 1
WHERE t1.`life expectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country = t2.country
AND t1.year = t2.year - 1 
JOIN world_life_expectancy t3
ON t1.country = t3.country
AND t1.year = t3.year + 1
SET t1.`life expectancy` = ROUND((t2.`life expectancy` + t3.`life expectancy`)/2,1)
WHERE t1.`life expectancy` = ''
;













