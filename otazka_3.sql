-- 3 Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 

WITH potraviny AS (
	SELECT 
		trmpspf.rok_potraviny,
		trmpspf.kategorie_potravin, 
		ROUND(AVG(trmpspf.cena_potravin)::numeric, 2) AS prumerna_cena_potravin 
	FROM t_roman_miltak_project_sql_primary_final trmpspf
	WHERE trmpspf.rok_potraviny IN (2006, 2018)
	GROUP BY rok_potraviny, kategorie_potravin
),
pivotovane_roky AS (
	SELECT 
		kategorie_potravin,
		MIN(CASE WHEN rok_potraviny = 2006 THEN prumerna_cena_potravin END) AS prum_cena_2006,
		MIN(CASE WHEN rok_potraviny = 2018 THEN prumerna_cena_potravin END) AS prum_cena_2018
	FROM potraviny 
	GROUP BY kategorie_potravin
)
SELECT 
	kategorie_potravin,
	prum_cena_2006,
	prum_cena_2018,
	prum_cena_2018 - prum_cena_2006 AS rozdil_prum_cen,
	ROUND(((prum_cena_2018 - prum_cena_2006) / prum_cena_2006 * 100)::numeric, 2) AS rozdil_procent
FROM pivotovane_roky
ORDER BY rozdil_procent ASC;



