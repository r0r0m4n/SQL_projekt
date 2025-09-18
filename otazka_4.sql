-- 4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
WITH rust_mezd AS (
	SELECT
		rok_mzda AS rok,
		ROUND(
			(AVG(trmpspf.prumerna_mzda)::NUMERIC -
			LAG(AVG(trmpspf.prumerna_mzda)::NUMERIC) OVER (ORDER BY trmpspf.rok_mzda)) /
			LAG(AVG(trmpspf.prumerna_mzda)::NUMERIC) OVER (ORDER BY trmpspf.rok_mzda) * 100,
			2
		) AS rust_mezd_procenta
	FROM t_roman_miltak_project_sql_primary_final trmpspf
	GROUP BY rok_mzda
),
rust_cen AS (
	SELECT
		rok_potraviny AS rok,
		ROUND(
			(AVG(trmpspf.cena_potravin)::NUMERIC -
			LAG(AVG(trmpspf.cena_potravin)::NUMERIC) OVER (ORDER BY trmpspf.rok_potraviny)) /
			LAG(AVG(trmpspf.cena_potravin)::NUMERIC) OVER (ORDER BY trmpspf.rok_potraviny) * 100,
			2
		) AS rust_cen_procenta
	FROM t_roman_miltak_project_sql_primary_final trmpspf
	GROUP BY rok_potraviny
)
SELECT
	r.rok,
	r.rust_cen_procenta,
	m.rust_mezd_procenta,
	ROUND(r.rust_cen_procenta - m.rust_mezd_procenta, 2) AS rozdil_procent
FROM rust_cen r
JOIN rust_mezd m ON r.rok = m.rok
ORDER BY rok, rozdil_procent DESC;
