/*
==================================================
PROYECTO: Análisis de Embudo y Retención - MercadoLibre
ETAPA: 10 - Retención por Cohorte Mensual
AUTOR: [Tu Nombre]
FECHA: Febrero 2026
DESCRIPCIÓN: Calcular % de retención por cohorte de registro
             a los 7, 14, 21 y 28 días (Ene-Ago 2025)
==================================================
*/

WITH cohort AS (
    -- Definir cohorte mensual para cada usuario
    SELECT
        user_id,
        TO_CHAR(DATE_TRUNC('month', MIN(signup_date)), 'YYYY-MM') AS cohort
    FROM
        mercadolibre_retention
    GROUP BY
        user_id
),

activity AS (
    -- Unir cohorte con datos de actividad
    SELECT
        r.user_id,
        c.cohort,
        r.day_after_signup,
        r.active
    FROM
        mercadolibre_retention r
    LEFT JOIN
        cohort c ON r.user_id = c.user_id
    WHERE
        r.activity_date BETWEEN '2025-01-01' AND '2025-08-31'
)

-- Calcular retención por cohorte
SELECT
    cohort,
    -- Retención al Día 7 (D7)
    ROUND(
        (100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 7 AND active = 1 THEN user_id END)) / 
        NULLIF(COUNT(DISTINCT user_id), 0)
    , 1) AS retention_d7_pct,
    
    -- Retención al Día 14 (D14)
    ROUND(
        (100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 14 AND active = 1 THEN user_id END)) / 
        NULLIF(COUNT(DISTINCT user_id), 0)
    , 1) AS retention_d14_pct,
    
    -- Retención al Día 21 (D21)
    ROUND(
        (100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 21 AND active = 1 THEN user_id END)) / 
        NULLIF(COUNT(DISTINCT user_id), 0)
    , 1) AS retention_d21_pct,
    
    -- Retención al Día 28 (D28)
    ROUND(
        (100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 28 AND active = 1 THEN user_id END)) / 
        NULLIF(COUNT(DISTINCT user_id), 0)
    , 1) AS retention_d28_pct
    
FROM
    activity
GROUP BY
    cohort
ORDER BY
    cohort;

/* Resultado:
cohort  | retention_d7_pct | retention_d14_pct | retention_d21_pct | retention_d28_pct
--------|------------------|-------------------|-------------------|------------------
2025-01 | 86.2             | 56.2              | 24.1              | 3.0
2025-02 | 86.8             | 56.0              | 24.6              | 2.7
2025-03 | 87.7             | 56.8              | 26.6              | 3.0
2025-04 | 87.2             | 53.9              | 23.0              | 2.0
2025-05 | 86.0             | 54.5              | 26.2              | 3.0
2025-06 | 85.9             | 55.1              | 25.2              | 2.1
2025-07 | 86.4             | 56.4              | 25.9              | 2.7
2025-08 | 70.8             | 29.7              | 7.5               | 0.2
*/