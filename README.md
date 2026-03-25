# 🗺️ MercadoLibre Growth & Retention - SQL Funnels
![SQL](https://img.shields.io/badge/SQL-Pro-yellow)
![Growth](https://img.shields.io/badge/Analysis-Funnel%20%26%20Retention-yellow)
## 📌 Objetivo
Análisis forense de embudos de conversión y retención por cohortes para MercadoLibre.
## 🛠️ Ingeniería Analítica
* **CTEs**: Embudo de 5 etapas (visit -> purchase).
* **Cohortes**: Tasas de supervivencia D7, D14, D21, D28 en SQL.
## 🔬 Hallazgos (Ref. Libro Blanco)
* 📏 **Conversión Final**: 1.25%.
* 🚨 **Cuello de Botella**: 85.68% de pérdida entre Selección y Carrito (UX Crítica).
* 📉 **Abismo D28**: La retención colapsa del 25% al 2.7% (falta de hábito).
* 🗺️ **Anomalía Regional**: 0% conversión en Ecuador/Colombia (bloqueos técnicos).
# 📊 Análisis de Embudo y Retención para MercadoLibre

## 📌 Descripción del Proyecto
Proyecto de análisis de producto para MercadoLibre, donde actué como analista de datos en el equipo de Crecimiento y Retención. El objetivo fue entender en qué etapa del proceso se pierden usuarios y cómo mejorar su retención a lo largo del tiempo.

## 🎯 Objetivos
- Construir el embudo de conversión completo desde `first_visit` hasta `purchase`
- Identificar los principales puntos de fuga (mayor caída porcentual)
- Analizar la retención de usuarios por cohortes mensuales (D7, D14, D21, D28)
- Segmentar resultados por país para detectar variaciones regionales
- Proponer mejoras accionables basadas en los datos

## 🛠️ Herramientas Utilizadas
- **SQL** (PostgreSQL / BigQuery)
- **Hojas de cálculo** para validaciones complementarias
- **Markdown** para documentación
- **GitHub** para control de versiones

## 📂 Estructura del Proyecto
Ver [Carpeta de proyecto](proyecto-4-analisis-embudo-mercadolibre-sql)
```
📦 proyecto-4-analisis-embudo-mercadolibre-sql
 ┣ 📂 data                  # Diccionario de datos y documentación de tablas
 ┃ ┗ 📜 diccionario_datos.md   # Descripción de columnas de mercadolibre_funnel y mercadolibre_retention
 ┃
 ┣ 📂 docs                   # Documentación y análisis cualitativo
 ┃ ┣ 📜 reflexiones_analista.md  # Respuestas a preguntas conceptuales sobre el análisis
 ┃ ┗ 📜 validaciones_qa.md       # (Opcional) Validaciones de calidad de datos
 ┃
 ┣ 📂 informes               # Entregables finales para stakeholders
 ┃ ┗ 📜 resumen_ejecutivo_cfi.md # Informe ejecutivo con metodología Contexto-Hallazgo-Implicación
 ┃
 ┣ 📂 outputs                # Resultados del análisis en formato CSV
 ┃ ┗ 📂 tablas               # Archivos planos con métricas calculadas
 ┃    ┣ 📜 embudo_conversiones.csv      # Usuarios por etapa del embudo
 ┃    ┣ 📜 conversion_por_pais.csv       # Tasas de conversión segmentadas por país
 ┃    ┣ 📜 retencion_por_pais.csv        # % de retención (D7, D14, D21, D28) por país
 ┃    ┗ 📜 retencion_por_cohorte.csv     # % de retención por cohorte mensual
 ┃
 ┣ 📂 sql                    # Consultas SQL organizadas por etapa de análisis
 ┃ ┣ 📜 01_exploracion_funnel.sql        # Primeros registros de mercadolibre_funnel
 ┃ ┣ 📜 02_exploracion_retention.sql     # Primeros registros de mercadolibre_retention
 ┃ ┣ 📜 03_eventos_unicos.sql            # Listado de eventos distintos en el embudo
 ┃ ┣ 📜 04_construccion_embudo.sql       # CTEs por etapa y conteo de usuarios
 ┃ ┣ 📜 05_conversiones_embudo.sql       # % de conversión desde first_visit
 ┃ ┣ 📜 06_embudo_por_pais.sql           # Segmentación del embudo por país
 ┃ ┣ 📜 07_retencion_por_pais.sql        # Conteo de usuarios activos acumulados por país
 ┃ ┣ 📜 08_retencion_porcentaje_pais.sql # % de retención por país
 ┃ ┣ 📜 09_definir_cohortes.sql          # Asignación de cohorte mensual a cada usuario
 ┃ ┗ 📜 10_retencion_por_cohorte.sql     # % de retención por cohorte mensual
 ┃
 ┣ 📜 .gitignore              # Archivos excluidos del control de versiones
 ┗ 📜 README.md                # Descripción general del proyecto (este archivo)
```

### 📁 **data/**
Contiene el diccionario de datos con la descripción detallada de cada columna de las tablas `mercadolibre_funnel` y `mercadolibre_retention`. Esencial para entender la estructura y el significado de los datos.

### 📁 **docs/**
Documentación complementaria que incluye las reflexiones del analista sobre los resultados, respuestas a preguntas conceptuales y validaciones de calidad de datos.

### 📁 **informes/**
Resumen ejecutivo dirigido a stakeholders (director de producto, equipo de crecimiento) utilizando la metodología C-F-I (Contexto, Hallazgo, Implicación) para comunicar resultados de manera clara y accionable.

### 📁 **outputs/tablas/**
Resultados del análisis en formato CSV, listos para ser utilizados en visualizaciones, dashboards o presentaciones. Incluye métricas de embudo, conversión por país y retención por cohorte.

### 📁 **sql/** [consultas SQL](proyecto-4-analisis-embudo-mercadolibre-sql/sql)
Todas las consultas SQL utilizadas en el análisis, organizadas numéricamente por etapa del proyecto. Cada archivo incluye comentados los resultados obtenidos para trazabilidad y reproducibilidad.

## 🔍 Principales Hallazgos

### Embudo de Conversión (Ene-Ago 2025)

| Etapa | Usuarios | Conversión desde first_visit | Caída |
|-------|----------|------------------------------|-------|
| first_visit | 1,199 | 100% | - |
| select_item | 922 | 76.9% | -23.1% |
| **add_to_cart** | **132** | **11.01%** | **-85.68%** |
| begin_checkout | 48 | 4.00% | -63.64% |
| purchase | 15 | 1.25% | -68.75% |

**📌 Punto crítico:** La mayor caída ocurre entre "seleccionar un producto" y "agregar al carrito" → **se pierde el 85.68% de los usuarios**.

### Conversión por País (a compra)

| País | Conversión a compra |
|------|---------------------|
| Uruguay | 4.55% |
| Bolivia | 3.23% |
| México | 2.48% |
| Perú | 1.82% |
| Argentina | 1.25% |
| Chile | 1.03% |
| Brasil | 0.68% |
| Ecuador | 0.00% |
| Colombia | 0.00% |
| Paraguay | 0.00% |

**⚠️ Alerta:** Ecuador, Colombia y Paraguay tienen **0% de conversión** → falla total (técnica, logística o pagos).

### Retención por Cohorte (Ene-Jun 2025)

| Cohorte | D7 | D14 | D21 | D28 |
|---------|----|-----|-----|-----|
| Promedio Ene-Jun | 86.6% | 55.4% | 25.0% | **2.7%** |

**📌 Punto crítico:** La retención cae de **25.0% en D21 a solo 2.7% en D28** → pérdida del **90% de usuarios activos en una semana**.

### Anomalía: Cohorte Agosto 2025

| Cohorte | D7 | D14 | D21 | D28 |
|---------|----|-----|-----|-----|
| Ago 2025 | 70.8% | 29.7% | 7.5% | **0.2%** |

**🚨 Alerta:** Caída masiva y repentina → requiere investigación urgente.

## 💡 Recomendaciones Estratégicas

### 🔴 Acciones Inmediatas
1. **Investigar países con 0% conversión** (Ecuador, Colombia, Paraguay)
2. **Investigar cohorte Agosto 2025** (cambio en producto o adquisición)

### 🟡 Acciones Corto Plazo
3. **Optimizar etapa select_item → add_to_cart** (recuperar el 85% de usuarios perdidos)
4. **Mejorar retención D21 → D28** (campañas de re-engagement en semana 3)

### 🟢 Acciones Mediano Plazo
5. **Revisar estrategias en países con baja retención** (Colombia, Chile)
6. **Monitoreo continuo de cohortes** para detectar anomalías tempranas

## 📊 Resultados Completos

Los archivos CSV con todos los resultados están en:
- `outputs/tablas/embudo_conversiones.csv`
- `outputs/tablas/conversion_por_pais.csv`
- `outputs/tablas/retencion_por_pais.csv`
- `outputs/tablas/retencion_por_cohorte.csv`

## 📝 Informe Ejecutivo

Ver [resumen ejecutivo completo](proyecto-4-analisis-embudo-mercadolibre-sql/informes/resumen_ejecutivo_cfi.md).

## 🧠 Reflexiones del Analista

Ver [reflexiones conceptuales](proyecto-4-analisis-embudo-mercadolibre-sql/docs/reflexiones_analista.md) sobre el comportamiento de usuarios y recomendaciones.


[https://www.linkedin.com/in/david-g-ramos/]
[https://dataanalist-davidgramos.github.io/mi-sitio-web/]
