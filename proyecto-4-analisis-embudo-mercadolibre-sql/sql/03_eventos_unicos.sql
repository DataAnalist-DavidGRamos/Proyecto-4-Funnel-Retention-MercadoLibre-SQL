/*
==================================================
PROYECTO: Análisis de Embudo y Retención - MercadoLibre
ETAPA: 03 - Eventos Únicos del Embudo
AUTOR: [Tu Nombre]
FECHA: Febrero 2026
DESCRIPCIÓN: Confirmar la secuencia del embudo listando
             los eventos únicos en la tabla funnel
==================================================
*/

-- Listar eventos únicos ordenados alfabéticamente
SELECT DISTINCT 
    event_name
FROM 
    mercadolibre_funnel
ORDER BY 
    event_name;

/* Resultado (16 eventos):
- add_payment_info
- add_shipping_info
- add_to_cart
- begin_checkout
- click
- first_visit
- page_view
- purchase
- repeat_purchase
- scroll
- select_item
- select_promotion
- session_start
- user_engagement
- view_item
- view_promotion
- view_search_results
*/