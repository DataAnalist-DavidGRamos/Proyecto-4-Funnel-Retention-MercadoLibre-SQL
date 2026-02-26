/*
==================================================
PROYECTO: Análisis de Embudo y Retención - MercadoLibre
ETAPA: 04 - Construcción del Embudo (CTEs por etapa)
AUTOR: [Tu Nombre]
FECHA: Febrero 2026
DESCRIPCIÓN: Crear CTEs para cada etapa del embudo
             y contar usuarios únicos por etapa
             Rango: 2025-01-01 a 2025-08-31
==================================================
*/

WITH 
-- 1. Usuarios que hicieron la Primera Visita (Inicio del Embudo)
first_visit AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'first_visit'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

-- 2. Usuarios que Seleccionaron un Ítem o Promoción (Interés)
select_item AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name IN ('select_item', 'select_promotion')
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

-- 3. Usuarios que Agregaron al Carrito (Intención)
add_to_cart AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'add_to_cart'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

-- 4. Usuarios que Iniciaron el Checkout
begin_checkout AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'begin_checkout'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

-- 5. Usuarios que Agregaron Info de Envío
add_shipping_info AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'add_shipping_info'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

-- 6. Usuarios que Agregaron Info de Pago
add_payment_info AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'add_payment_info'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

-- 7. Usuarios que Compraron (Conversión Final)
purchase AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'purchase'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
)

-- Consulta final: contar usuarios por etapa
SELECT
    COUNT(fv.user_id) AS total_first_visit,
    COUNT(si.user_id) AS total_select_item,
    COUNT(atc.user_id) AS total_add_to_cart,
    COUNT(bc.user_id)  AS total_begin_checkout,
    COUNT(asi.user_id) AS total_add_shipping_info,
    COUNT(api.user_id) AS total_add_payment_info,
    COUNT(p.user_id)   AS total_purchase
FROM 
    first_visit fv
LEFT JOIN 
    select_item si ON fv.user_id = si.user_id
LEFT JOIN 
    add_to_cart atc ON fv.user_id = atc.user_id
LEFT JOIN 
    begin_checkout bc ON fv.user_id = bc.user_id
LEFT JOIN 
    add_shipping_info asi ON fv.user_id = asi.user_id
LEFT JOIN 
    add_payment_info api ON fv.user_id = api.user_id
LEFT JOIN 
    purchase p ON fv.user_id = p.user_id;

/* Resultado:
total_first_visit | total_select_item | total_add_to_cart | total_begin_checkout | total_add_shipping_info | total_add_payment_info | total_purchase
------------------|-------------------|-------------------|----------------------|-------------------------|------------------------|---------------
1199              | 922               | 132               | 48                   | 29                      | 25                     | 15
*/