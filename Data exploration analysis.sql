SELECT *
FROM world_life_expectancy;



SELECT country,
 MIN(`Life expectancy`),
 MAX(`Life expectancy`),
 ROUND(MAX(`Life expectancy`) -  MIN(`Life expectancy`), 1) AS Life_increase_15_years
FROM world_life_expectancy
GROUP BY country 
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_increase_15_years DESC
;

SELECT year, ROUND(AVG((`Life expectancy`)),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
GROUP BY year 
ORDER BY year
;

SELECT country, ROUND(AVG(`Life expectancy`),1)AS Life_exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY country
HAVING Life_exp > 0
AND GDP > 0
ORDER BY Life_exp ASC
;


SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_count, 
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) Hight_GDP_count,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_count, 
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) low_GDP_count
FROM world_life_expectancy
;

SELECT status , ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY status;

SELECT status , COUNT(DISTINCT country),  ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY status;

SELECT country, ROUND(AVG(`Life expectancy`),1) AS Life_exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY country
HAVING Life_exp > 0
AND BMI > 0
ORDER BY BMI ASC
;


SELECT country, 
year,
`Life expectancy`, 
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(partition by country ORDER BY year) AS Rolling_total
FROM world_life_expectancy
WHERE country LIKE '%united%'
;




