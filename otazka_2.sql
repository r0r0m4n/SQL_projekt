-- 2 Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
SELECT 
    trmpspf.rok_mzda AS rok,
    AVG(trmpspf.prumerna_mzda) AS prum_mzda,
    trmpspf.kategorie_potravin AS potravina,
    AVG(trmpspf.cena_potravin) AS prum_cena,
    ROUND(AVG(trmpspf.prumerna_mzda) / AVG(trmpspf.cena_potravin)::NUMERIC) AS kupni_sila,
    trmpspf.jednotka
FROM 
    t_roman_miltak_project_sql_primary_final trmpspf
WHERE 
    trmpspf.rok_mzda IN ('2006', '2018')
    AND (
        trmpspf.kategorie_potravin ILIKE '%chléb%' OR 
        trmpspf.kategorie_potravin ILIKE '%mléko%'
    )
GROUP BY 
    trmpspf.rok_mzda, 
    trmpspf.kategorie_potravin, 
    trmpspf.jednotka;


