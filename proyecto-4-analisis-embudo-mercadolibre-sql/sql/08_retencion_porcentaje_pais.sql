/*
==================================================
PROYECTO: Análisis de Embudo y Retención - MercadoLibre
ETAPA: 08 - Porcentaje de Retención por País
AUTOR: [Tu Nombre]
FECHA: Febrero 2026
DESCRIPCIÓN: Calcular % de retención acumulada por país
             a los 7, 14, 21 y 28 días desde el registro
==================================================
*/

SELECT
    country,
    -- Porcentaje de Retención al Día 7 (D7)
    ROUND(
        (COUNT(DISTINCT CASE WHEN day_after_signup >= 7 AND active = 1 THEN user_id END) * 100.0) / 
        NULLIF(COUNT(DISTINCT user_id), 0)
    , 1) AS retention_d7_pct,
    
    -- Porcentaje de Retención al Día 14 (D14)
    ROUND(
        (COUNT(DISTINCT CASE WHEN day_after_signup >= 14 AND active = 1 THEN user_id END) * 100.0) / 
        NULLIF(COUNT(DISTINCT user_id), 0)
    , 1) AS retention_d14_pct,
    
    -- Porcentaje de Retención al Día 21 (D21)
    ROUND(
        (COUNT(DISTINCT CASE WHEN day_after_signup >= 21 AND active = 1 THEN user_id END) * 100.0) / 
        NULLIF(COUNT(DISTINCT user_id), 0)
    , 1) AS retention_d21_pct,
    
    -- Porcentaje de Retención al Día 28 (D28)
    ROUND(
        (COUNT(DISTINCT CASE WHEN day_after_signup >= 28 AND active = 1 THEN user_id END) * 100.0) / 
        NULLIF(COUNT(DISTINCT user_id), 0)
    , 1) AS retention_d28_pct
    
FROM
    mercadolibre_retention
    
WHERE
    activity_date BETWEEN '2025-01-01' AND '2025-08-31'
    
GROUP BY
    country
    
ORDER BY
    country;

/* Resultado:
country    | retention_d7_pct | retention_d14_pct | retention_d21_pct | retention_d28_pct
-----------|------------------|-------------------|-------------------|------------------
Argentina  | 85.1             | 52.3              | 22.5              | 1.8
Bolivia    | 80.8             | 46.8              | 19.2              | 2.5
Brazil     | 87.2             | 54.4              | 24.4              | 2.5
Chile      | 83.7             | 51.8              | 22.1              | 1.7
Colombia   | 84.5             | 52.0              | 21.8              | 1.6
Ecuador    | 79.1             | 50.0              | 20.6              | 2.5
Mexico     | 86.1             | 55.8              | 25.5              | 3.1
Paraguay   | 80.9             | 49.1              | 22.1              | 2.1
Peru       | 84.3             | 51.1              | 22.9              | 3.2
Uruguay    | 86.1             | 48.8              | 23.0              | 2.5
*/