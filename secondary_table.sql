CREATE TABLE t_roman_miltak_project_sql_secondary_final AS
	SELECT
		c.country AS zeme,
		e."year" AS rok,
		ROUND(e.gdp::numeric, 2) AS hdp,
		e.gini AS gini_koef,
		c.population AS populace
	FROM countries c
	JOIN economies e
		ON c.country = e.country;
