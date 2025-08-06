
create table t_roman_miltak_project_SQL_primary_final as (
	select 
		cp2.payroll_year as rok_mzda,
		cpib."name" as odvetvi,
		cp2.value as prumerna_mzda,
		cpc."name" as kategorie_potravin,
		cp.value as cena_potravin,
		cpc.price_value as mnozstvi,
		cpc.price_unit as jednotka
	from czechia_price cp  
	join czechia_payroll cp2 
		on cp2.payroll_year = date_part('year', cp.date_from )
		and cp2.value_type_code  = 5958
		and cp2.calculation_code = 100
	join czechia_payroll_industry_branch cpib 
		on cp2.industry_branch_code = cpib.code  
	join czechia_price_category cpc 
		on cp.category_code = cpc.code )

