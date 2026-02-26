/*
==================================================
PROYECTO: Análisis de Embudo y Retención - MercadoLibre
ETAPA: 07 - Retención Acumulada por País
AUTOR: [Tu Nombre]
FECHA: Febrero 2026
DESCRIPCIÓN: Contar usuarios activos acumulados por país
             a los 7, 14, 21 y 28 días desde el registro
             Rango: 2025-01-01 a 2025-08-31
==================================================
*/

-- Conteo de usuarios activos acumulados por país
SELECT
    country,
    -- Usuarios activos acumulados al día 7 (D7)
    COUNT(DISTINCT CASE WHEN day_after_signup >= 7 AND active = 1 THEN user_id END) AS users_d7,
    
    -- Usuarios activos acumulados al día 14 (D14)
    COUNT(DISTINCT CASE WHEN day_after_signup >= 14 AND active = 1 THEN user_id END) AS users_d14,
    
    -- Usuarios activos acumulados al día 21 (D21)
    COUNT(DISTINCT CASE WHEN day_after_signup >= 21 AND active = 1 THEN user_id END) AS users_d21,
    
    -- Usuarios activos acumulados al día 28 (D28)
    COUNT(DISTINCT CASE WHEN day_after_signup >= 28 AND active = 1 THEN user_id END) AS users_d28
    
FROM
    mercadolibre_retention
    
WHERE
    activity_date BETWEEN '2025-01-01' AND '2025-08-31'
    
GROUP BY
    country
    
ORDER BY
    country;

/* Resultado:
country    | users_d7 | users_d14 | users_d21 | users_d28
-----------|----------|-----------|-----------|----------
Argentina  | 1122     | 690       | 297       | 24
Bolivia    | 387      | 224       | 92        | 12
Brazil     | 2641     | 1649      | 740       | 76
Chile      | 782      | 484       | 206       | 16
Colombia   | 1384     | 851       | 357       | 27
Ecuador    | 473      | 299       | 123       | 15
Mexico     | 2075     | 1345      | 615       | 75
Paraguay   | 380      | 231       | 104       | 10
Peru       | 739      | 448       | 201       | 28
Uruguay    | 210      | 119       | 56        | 6
*/