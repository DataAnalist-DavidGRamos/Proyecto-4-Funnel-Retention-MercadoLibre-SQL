# 📚 Diccionario de Datos - MercadoLibre

## Tabla: mercadolibre_funnel
Registra eventos de usuarios durante el proceso de compra.

| Columna | Tipo | Descripción |
|---------|------|-------------|
| user_id | STRING | Identificador único del usuario. Permite rastrear el comportamiento de un mismo usuario a lo largo del tiempo. |
| session_id | STRING | Identificador único de la sesión. Cada sesión agrupa los eventos generados durante una visita del usuario. |
| event_name | STRING | Nombre del evento realizado por el usuario (first_visit, select_item, add_to_cart, begin_checkout, add_shipping_info, add_payment_info, purchase, etc.). |
| event_times | FLOAT | Marca temporal del evento en formato Unix timestamp (milisegundos desde 1970-01-01). |
| country | STRING | País desde donde se genera la sesión o el evento. |
| device_category | STRING | Tipo de dispositivo utilizado por el usuario (mobile, desktop, tablet). |
| platform | STRING | Plataforma o sistema operativo desde donde se origina el evento (android, iOS, web). |
| product_cat | STRING | Categoría del producto asociado al evento. Vacío para eventos no relacionados con productos. |
| price | FLOAT | Precio del producto en el momento del evento (si aplica). |
| currency | STRING | Moneda en la que se registra el precio (USD, ARS, etc.). |
| referral_source | STRING | Fuente de tráfico que originó la sesión (organic, paid_search, social, direct, affiliate). |
| event_date | DATETIME | Fecha y hora legible del evento, derivada del event_times. |
| year | INTEGER | Año en que ocurrió el evento. |

## Tabla: mercadolibre_retention
Mide actividad recurrente por usuario y periodo.

| Columna | Tipo | Descripción |
|---------|------|-------------|
| user_id | STRING | Identificador único del usuario. Permite hacer seguimiento individual del comportamiento de retención. |
| signup_date | DATE | Fecha del registro del usuario (sin hora). Se usa como punto de referencia para calcular los días posteriores al registro. |
| signup_datetime | DATETIME | Fecha y hora exactas en que el usuario completó su registro. |
| country | STRING | País del usuario al momento del registro. |
| device_category | STRING | Tipo de dispositivo utilizado en el registro o durante la actividad. |
| platform | STRING | Plataforma o sistema operativo desde el cual el usuario accedió. |
| day_after_signup | INTEGER | Número de días transcurridos desde la fecha de registro hasta la fecha de actividad. Sirve para calcular cohortes de retención (D7, D14, D21, D28). |
| activity_date | DATE | Fecha en que el usuario tuvo actividad (sesión, compra, vista de producto). |
| active | INTEGER | Indicador binario de actividad: 1 si el usuario estuvo activo en esa fecha, 0 si no. |
| prob_active | FLOAT | Probabilidad estimada de que el usuario esté activo en esa fecha. |

## Eventos clave del embudo (funnel)

| Etapa | Evento(s) | Descripción |
|-------|-----------|-------------|
| 🟢 Descubrimiento | first_visit | El usuario entra por primera vez al sitio |
| 🟡 Interés | select_item, select_promotion | El usuario selecciona un producto o promoción |
| 🟠 Intención | add_to_cart | El usuario añade un producto al carrito |
| 🔵 Inicio de compra | begin_checkout | El usuario inicia el proceso de pago |
| 🟣 Información de envío | add_shipping_info | El usuario ingresa dirección o método de envío |
| 🟤 Información de pago | add_payment_info | El usuario agrega o selecciona método de pago |
| 🔴 Conversión | purchase | El usuario completa la compra |