/*
==================================================
PROYECTO: Análisis de Embudo y Retención - MercadoLibre
ETAPA: 02 - Exploración Retención
AUTOR: [Tu Nombre]
FECHA: Febrero 2026
DESCRIPCIÓN: Exploración de la tabla mercadolibre_retention
             para entender estructura y contenido
==================================================
*/

-- Ver primeros 5 registros de mercadolibre_retention
SELECT * FROM mercadolibre_retention 
LIMIT 5;

/* Resultado:
user_id | signup_datetime | country | device_category | platform | activity_date | prob_active | day_after_signup | active | signup_date
--------+-----------------+---------+-----------------+----------+---------------+-------------+------------------+--------+------------
00198c... | 2025-05-01... | Brazil | tablet | web | 2025-05-09 | 0.1697 | 8 | 0 | 2025-05-01
... (más resultados)
*/