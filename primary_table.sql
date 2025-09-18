CREATE TABLE t_roman_miltak_project_sql_primary_final AS
	SELECT
		cp2.payroll_year AS rok_mzda,
		cpib."name" AS odvetvi,
		cp2.value AS prumerna_mzda,
		cpc."name" AS kategorie_potravin,
		cp.value AS cena_potravin,
		cpc.price_value AS mnozstvi,
		cpc.price_unit AS jednotka
	FROM czechia_price cp
	JOIN czechia_payroll cp2
		ON cp2.payroll_year = DATE_PART('year', cp.date_from)
		AND cp2.value_type_code = 5958
		AND cp2.calculation_code = 100
	JOIN czechia_payroll_industry_branch cpib
		ON cp2.industry_branch_code = cpib.code
	JOIN czechia_price_category cpc
		ON cp.category_code = cpc.code;
