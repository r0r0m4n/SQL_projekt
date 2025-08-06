create table t_roman_miltak_project_SQL_secondary_final as ( 
	select 
		c.country as zeme,
		e."year" as rok , 
		round(e.gdp::numeric,2) as hdp,
		e.gini as gini_koef,
		c.population as populace 
		from countries c
		join economies e
			on c.country = e.country 
		order by zeme, rok )