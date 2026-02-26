/*
==================================================
PROYECTO: Análisis de Embudo y Retención - MercadoLibre
ETAPA: 09 - Definición de Cohortes Mensuales
AUTOR: [Tu Nombre]
FECHA: Febrero 2026
DESCRIPCIÓN: Asignar a cada usuario su cohorte de registro
             en formato YYYY-MM (mes de primera actividad)
==================================================
*/

-- Asignar cohorte mensual a cada usuario
SELECT
    user_id,
    -- Captura la fecha de registro más antigua por usuario
    MIN(signup_date) AS signup_date,
    -- Trunca esa fecha al mes y la formatea como 'YYYY-MM' para definir la cohorte
    TO_CHAR(DATE_TRUNC('month', MIN(signup_date)), 'YYYY-MM') AS cohort
FROM
    mercadolibre_retention
-- Agrupa las filas para obtener una única cohorte por usuario
GROUP BY
    user_id
-- Ordena y limita el resultado para validación
ORDER BY
    user_id
LIMIT 5;

/* Resultado:
user_id                                   | signup_date | cohort
-------------------------------------------|-------------|--------
0002b1ba-9c7f-4989-87cb-54109b84c2cb      | 2025-05-02  | 2025-05
0011c921-8b74-4984-9f90-b50daae0442b      | 2025-02-19  | 2025-02
00147274-7efe-42fd-aaaf-a1b7aefb834f      | 2025-02-01  | 2025-02
0017b94f-3a9f-4850-a011-4b3b3141c201      | 2025-08-05  | 2025-08
00198c1f-bc1e-403e-b46a-67b0b3ac7657      | 2025-05-01  | 2025-05
*/