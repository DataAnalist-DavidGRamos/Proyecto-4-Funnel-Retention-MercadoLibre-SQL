# 📊 Resumen Ejecutivo: Análisis de Embudo y Retención - MercadoLibre

---

## Contexto

Se analizó el comportamiento de los usuarios de MercadoLibre entre el **1 de enero y el 31 de agosto de 2025** para responder dos preguntas clave del equipo de Crecimiento y Retención:

1. **Embudo de conversión:** ¿En qué etapa del proceso de compra se pierden más usuarios y cómo varía por país?
2. **Retención:** ¿Qué tan bien retenemos a los usuarios a lo largo del tiempo, por cohorte mensual y por país?

Se trabajó con dos tablas:
- `mercadolibre_funnel`: eventos del proceso de compra (first_visit → purchase)
- `mercadolibre_retention`: actividad recurrente de usuarios (D7, D14, D21, D28)

---

## Hallazgos Clave

### 1. El punto de fuga más crítico del embudo

| Etapa | Usuarios | Conversión desde first_visit | Caída respecto a etapa anterior |
|-------|----------|------------------------------|----------------------------------|
| first_visit | 1,199 | 100% | - |
| select_item | 922 | 76.9% | -23.1% |
| **add_to_cart** | **132** | **11.01%** | **-85.68%** |
| begin_checkout | 48 | 4.00% | -63.64% |
| purchase | 15 | 1.25% | -68.75% |

**La mayor caída ocurre entre "seleccionar un producto" y "agregar al carrito": se pierde el 85.68% de los usuarios.**  
Este es el punto de mayor fricción y la mayor oportunidad de mejora.

---

### 2. Variación por país (conversión final a compra)

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

**Países con 0% de conversión (Ecuador, Colombia, Paraguay):**  
Esto no es un problema de optimización, sino una **falla total** (técnica, logística, pagos o configuración) que impide completar transacciones. Requiere investigación inmediata.

---

### 3. Retención por cohorte (Ene-Jun 2025)

| Cohorte | D7 | D14 | D21 | D28 |
|---------|----|-----|-----|-----|
| Ene 2025 | 86.2% | 56.2% | 24.1% | 3.0% |
| Feb 2025 | 86.8% | 56.0% | 24.6% | 2.7% |
| Mar 2025 | 87.7% | 56.8% | 26.6% | 3.0% |
| Abr 2025 | 87.2% | 53.9% | 23.0% | 2.0% |
| May 2025 | 86.0% | 54.5% | 26.2% | 3.0% |
| Jun 2025 | 85.9% | 55.1% | 25.2% | 2.1% |
| **Promedio** | **86.6%** | **55.4%** | **25.0%** | **2.7%** |

**Punto crítico:** La retención cae de **25.0% en D21 a solo 2.7% en D28**.  
Casi el **90% de los usuarios activos en la tercera semana abandonan antes de completar el mes.**

---

### 4. Anomalía crítica: Cohorte Agosto 2025

| Cohorte | D7 | D14 | D21 | D28 |
|---------|----|-----|-----|-----|
| Ago 2025 | 70.8% | 29.7% | 7.5% | 0.2% |

**Caída masiva y repentina.** Indica un evento externo o cambio en el producto que afectó gravemente la retención. Requiere investigación urgente.

---

### 5. Retención por país (D28)

| País | Retención D28 |
|------|---------------|
| Perú | 3.2% |
| México | 3.1% |
| Bolivia | 2.5% |
| Brasil | 2.5% |
| Ecuador | 2.5% |
| Uruguay | 2.5% |
| Paraguay | 2.1% |
| Argentina | 1.8% |
| Chile | 1.7% |
| Colombia | 1.6% |

**Mejor desempeño:** Perú y México (ligeramente arriba del promedio)  
**Peor desempeño:** Colombia y Chile (requieren revisión de estrategias de retención)

---

## Implicaciones y Recomendaciones

### 🔴 **Acción Inmediata (Alta Prioridad)**

1. **Investigar países con 0% conversión (Ecuador, Colombia, Paraguay)**
   - Revisar configuración de pagos, logística, disponibilidad de productos
   - Validar si hay bloqueos técnicos o regulatorios

2. **Investigar cohorte Agosto 2025**
   - ¿Hubo cambios en el producto, campañas de marketing, errores técnicos?
   - Analizar si la caída se debió a adquisición de baja calidad o problemas de producto

---

### 🟡 **Acciones a Corto Plazo (Siguiente Sprint)**

3. **Optimizar la etapa select_item → add_to_cart (pérdida del 85.68%)**
   - Revisar página de producto: información, precios, costos de envío, usabilidad
   - Implementar pruebas A/B en botones, llamados a la acción, imágenes
   - Este es el punto de mayor impacto potencial en conversión

4. **Mejorar retención en el periodo D21 → D28**
   - Diseñar campañas de re-engagement en la tercera semana
   - Enviar notificaciones push, emails con ofertas personalizadas
   - Demostrar valor recurrente antes del abandono masivo

---

### 🟢 **Acciones a Mediano Plazo**

5. **Revisar estrategias en países con baja retención (Colombia, Chile)**
   - Analizar si el producto se adapta a las necesidades locales
   - Evaluar campañas de marketing en esos mercados

6. **Establecer monitoreo continuo de cohortes**
   - Detectar anomalías tempranas como la de Agosto 2025
   - Activar alertas cuando la retención caiga por debajo de umbrales

---

## Conclusión

El análisis revela que **el principal problema no es la adquisición (first_visit funciona), sino la conversión a carrito y la retención más allá de las tres semanas.**

- **Mayor oportunidad de mejora:** Etapa select_item → add_to_cart (recuperar el 85% de usuarios perdidos)
- **Mayor riesgo de abandono:** Periodo D21 → D28 (pérdida del 90% de usuarios activos)
- **Señales de alerta:** Países con 0% conversión y cohorte Agosto 2025 requieren investigación inmediata

**Próximos pasos:** Implementar mejoras en la página de producto y campañas de re-engagement en semana 3, mientras se investigan las anomalías críticas.