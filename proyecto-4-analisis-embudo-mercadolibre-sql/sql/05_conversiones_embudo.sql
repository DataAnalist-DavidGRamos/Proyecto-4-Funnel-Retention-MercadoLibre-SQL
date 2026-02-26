/*
==================================================
PROYECTO: Análisis de Embudo y Retención - MercadoLibre
ETAPA: 05 - Tasas de Conversión del Embudo
AUTOR: [Tu Nombre]
FECHA: Febrero 2026
DESCRIPCIÓN: Calcular porcentaje de conversión desde
             first_visit hacia cada etapa del embudo
==================================================
*/

WITH first_visit AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'first_visit'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
select_item AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name IN ('select_item', 'select_promotion')
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
add_to_cart AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'add_to_cart'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
begin_checkout AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'begin_checkout'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
add_shipping_info AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'add_shipping_info'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
add_payment_info AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'add_payment_info'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
purchase AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'purchase'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
), 
funnel_counts AS (
    SELECT
        COUNT(fv.user_id) AS usuarios_first_visit,
        COUNT(si.user_id) AS usuarios_select_item,
        COUNT(atc.user_id) AS usuarios_add_to_cart,
        COUNT(bc.user_id) AS usuarios_begin_checkout,
        COUNT(asi.user_id) AS usuarios_add_shipping_info,
        COUNT(api.user_id) AS usuarios_add_payment_info,
        COUNT(p.user_id) AS usuarios_purchase
    FROM first_visit fv
    LEFT JOIN select_item si ON fv.user_id = si.user_id
    LEFT JOIN add_to_cart atc ON fv.user_id = atc.user_id
    LEFT JOIN begin_checkout bc ON fv.user_id = bc.user_id
    LEFT JOIN add_shipping_info asi ON fv.user_id = asi.user_id
    LEFT JOIN add_payment_info api ON fv.user_id = api.user_id
    LEFT JOIN purchase p ON fv.user_id = p.user_id
)

-- Calcular conversiones desde first_visit
SELECT
    -- Conversión a select_item
    ROUND(
        usuarios_select_item * 100.0 / NULLIF(usuarios_first_visit, 0), 
        2
    ) AS conversion_select_item,
    
    -- Conversión a add_to_cart
    ROUND(
        usuarios_add_to_cart * 100.0 / NULLIF(usuarios_first_visit, 0), 
        2
    ) AS conversion_add_to_cart,
    
    -- Conversión a begin_checkout
    ROUND(
        usuarios_begin_checkout * 100.0 / NULLIF(usuarios_first_visit, 0), 
        2
    ) AS conversion_begin_checkout,
    
    -- Conversión a add_shipping_info
    ROUND(
        usuarios_add_shipping_info * 100.0 / NULLIF(usuarios_first_visit, 0), 
        2
    ) AS conversion_add_shipping_info,
    
    -- Conversión a add_payment_info
    ROUND(
        usuarios_add_payment_info * 100.0 / NULLIF(usuarios_first_visit, 0), 
        2
    ) AS conversion_add_payment_info,
    
    -- Conversión final a purchase
    ROUND(
        usuarios_purchase * 100.0 / NULLIF(usuarios_first_visit, 0), 
        2
    ) AS conversion_purchase
FROM
    funnel_counts;

/* Resultado:
conversion_select_item | conversion_add_to_cart | conversion_begin_checkout | conversion_add_shipping_info | conversion_add_payment_info | conversion_purchase
-----------------------|------------------------|---------------------------|------------------------------|-----------------------------|--------------------
76.90                  | 11.01                  | 4.00                      | 2.42                         | 2.09                        | 1.25
*/