-- 5) Má výška HDP vliv na změny ve mzdách a cenách potravin?
-- Pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
WITH hdp_data AS (
	SELECT
		rok,
		hdp,
		LAG(hdp) OVER (ORDER BY rok) AS hdp_predchozi_rok,
		ROUND((hdp - LAG(hdp) OVER (ORDER BY rok)) / LAG(hdp) OVER (ORDER BY rok) * 100, 2) AS procentualni_zmena_hdp
	FROM t_roman_miltak_project_sql_secondary_final
	WHERE zeme = 'Czech Republic'
		AND rok BETWEEN 2006 AND 2018
),
mzdy_ceny_data AS (
	SELECT
		rok_mzda AS rok,
		ROUND(AVG(prumerna_mzda), 2) AS prumerna_mzda,
		ROUND(AVG(cena_potravin)::NUMERIC, 2) AS prumerna_cena,
		LAG(ROUND(AVG(prumerna_mzda), 2)) OVER (ORDER BY rok_mzda) AS mzda_predchozi,
		LAG(ROUND(AVG(cena_potravin)::NUMERIC, 2)) OVER (ORDER BY rok_mzda) AS cena_predchozi
	FROM t_roman_miltak_project_sql_primary_final
	GROUP BY rok_mzda
)
SELECT
	h.rok,
	h.hdp,
	h.hdp_predchozi_rok,
	ROUND(h.hdp - h.hdp_predchozi_rok, 2) AS rozdil_hdp,
	h.procentualni_zmena_hdp,
	ROUND((m.prumerna_mzda - m.mzda_predchozi) / m.mzda_predchozi * 100, 2) AS procentualni_zmena_mzdy,
	ROUND((m.prumerna_cena - m.cena_predchozi) / m.cena_predchozi * 100, 2) AS procentualni_zmena_ceny
FROM hdp_data h
JOIN mzdy_ceny_data m ON h.rok = m.rok
ORDER BY h.rok;
