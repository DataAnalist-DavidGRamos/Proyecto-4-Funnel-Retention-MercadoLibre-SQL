/*
==================================================
PROYECTO: Análisis de Embudo y Retención - MercadoLibre
ETAPA: 01 - Exploración Inicial
AUTOR: [Tu Nombre]
FECHA: Febrero 2026
DESCRIPCIÓN: Exploración de la tabla mercadolibre_funnel
             para entender estructura y contenido
==================================================
*/

-- 1. Ver primeros 5 registros de mercadolibre_funnel
SELECT * FROM mercadolibre_funnel 
LIMIT 5;

/* Resultado:
user_id | session_id | event_name | event_times | country | device_category | platform | product_cat | price | currency | referral_source | event_date | year
--------+------------+------------+-------------+---------+-----------------+----------+-------------+-------+----------+-----------------+------------+-----
c786f5... | sid_1129  | session_start | 1.76001e+15 | Argentina | mobile | android | | | USD | organic | 2025-10-09... | 2025
... (más resultados)
*/

-- 2. Listar tipos de eventos únicos en el embudo
SELECT DISTINCT 
    event_name
FROM 
    mercadolibre_funnel
ORDER BY 
    event_name;

/* Resultado:
event_name
add_payment_info
add_shipping_info
add_to_cart
begin_checkout
click
first_visit
page_view
purchase
repeat_purchase
scroll
select_item
select_promotion
session_start
user_engagement
view_item
view_promotion
view_search_results
*/