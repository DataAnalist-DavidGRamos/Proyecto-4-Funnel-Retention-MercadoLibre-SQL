/*
==================================================
PROYECTO: Análisis de Embudo y Retención - MercadoLibre
ETAPA: 06 - Segmentación del Embudo por País
AUTOR: [Tu Nombre]
FECHA: Febrero 2026
DESCRIPCIÓN: Calcular conversiones del embudo segmentadas
             por país para identificar variaciones regionales
==================================================
*/

WITH first_visits AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'first_visit'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
select_item AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name IN ('select_item', 'select_promotion')
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
add_to_cart AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'add_to_cart'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
begin_checkout AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'begin_checkout'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
add_shipping_info AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'add_shipping_info'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
add_payment_info AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'add_payment_info'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
purchase AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'purchase'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
), 
funnel_counts AS (
    SELECT
        fv.country,
        COUNT(fv.user_id) AS usuarios_first_visit,
        COUNT(si.user_id) AS usuarios_select_item,
        COUNT(atc.user_id) AS usuarios_add_to_cart,
        COUNT(bc.user_id) AS usuarios_begin_checkout,
        COUNT(asi.user_id) AS usuarios_add_shipping_info,
        COUNT(api.user_id) AS usuarios_add_payment_info,
        COUNT(p.user_id) AS usuarios_purchase
    FROM first_visits fv
    LEFT JOIN select_item si ON fv.user_id = si.user_id AND fv.country = si.country
    LEFT JOIN add_to_cart atc ON fv.user_id = atc.user_id AND fv.country = atc.country
    LEFT JOIN begin_checkout bc ON fv.user_id = bc.user_id AND fv.country = bc.country
    LEFT JOIN add_shipping_info asi ON fv.user_id = asi.user_id AND fv.country = asi.country
    LEFT JOIN add_payment_info api ON fv.user_id = api.user_id AND fv.country = api.country
    LEFT JOIN purchase p ON fv.user_id = p.user_id AND fv.country = p.country
    GROUP BY fv.country
)

-- Calcular conversiones por país
SELECT 
    country,
    ROUND(usuarios_select_item * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_select_item,
    ROUND(usuarios_add_to_cart * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_to_cart,
    ROUND(usuarios_begin_checkout * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_begin_checkout,
    ROUND(usuarios_add_shipping_info * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_shipping_info,
    ROUND(usuarios_add_payment_info * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_payment_info,
    ROUND(usuarios_purchase * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_purchase
FROM
    funnel_counts
ORDER BY
    conversion_purchase DESC;

/* Resultado:
country   | conversion_select_item | conversion_add_to_cart | conversion_begin_checkout | conversion_add_shipping_info | conversion_add_payment_info | conversion_purchase
----------|------------------------|------------------------|---------------------------|------------------------------|-----------------------------|--------------------
Uruguay   | 81.82                  | 22.73                  | 4.55                      | 4.55                         | 4.55                        | 4.55
Bolivia   | 80.65                  | 9.68                   | 3.23                      | 3.23                         | 3.23                        | 3.23
Mexico    | 79.75                  | 13.22                  | 4.13                      | 3.31                         | 2.89                        | 2.48
Peru      | 84.55                  | 10.00                  | 2.73                      | 2.73                         | 1.82                        | 1.82
Argentina | 75.00                  | 8.75                   | 4.38                      | 1.88                         | 1.88                        | 1.25
Chile     | 78.35                  | 17.53                  | 8.25                      | 3.09                         | 2.06                        | 1.03
Brazil    | 72.60                  | 8.90                   | 2.40                      | 1.37                         | 1.37                        | 0.68
Ecuador   | 74.58                  | 10.17                  | 5.08                      | 1.69                         | 1.69                        | 0.00
Colombia  | 76.36                  | 9.70                   | 4.85                      | 3.03                         | 2.42                        | 0.00
Paraguay  | 71.43                  | 9.52                   | 0.00                      | 0.00                         | 0.00                        | 0.00
*/