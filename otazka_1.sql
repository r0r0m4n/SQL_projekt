--1) Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
-- porovnání první a poslední rok 
WITH vybrane_roky AS (
    SELECT
        odvetvi,
        rok_mzda,
        AVG(prumerna_mzda) AS prumerna_mzda
    FROM t_roman_miltak_project_sql_primary_final
    WHERE rok_mzda IN (2006, 2018)
    GROUP BY odvetvi, rok_mzda
),
pivotovane_roky AS (
    SELECT
        odvetvi,
        MAX(CASE WHEN rok_mzda = 2006 THEN prumerna_mzda END) AS prum_mzda_2006,
        MAX(CASE WHEN rok_mzda = 2018 THEN prumerna_mzda END) AS prum_mzda_2018
    FROM vybrane_roky
    GROUP BY odvetvi
)
SELECT
    odvetvi,
    prum_mzda_2006,
    prum_mzda_2018,
    prum_mzda_2018 - prum_mzda_2006 AS rozdil_kc,
    ROUND(100 * (prum_mzda_2018 - prum_mzda_2006) / prum_mzda_2006, 2) AS rozdil_procent,
    CASE
        WHEN prum_mzda_2018 > prum_mzda_2006 THEN 'mzdy rostou'
        WHEN prum_mzda_2018 < prum_mzda_2006 THEN 'mzdy klesají'
        ELSE 'beze změny'
    END AS komentar_trendu
FROM pivotovane_roky
ORDER BY odvetvi;

