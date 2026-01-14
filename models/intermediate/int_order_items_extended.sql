with line_items as (
    select * from {{ ref('stg_tpch__line_items') }}
)

select
    -- IDs y Claves
    line_item_id,
    order_id,
    part_id,
    supplier_id,
    
    -- Atributos necesarios para agrupación
    return_flag,
    status_code,
    ship_date,
    
    -- Métricas Originales
    quantity,
    base_price,
    discount_percentage,
    tax_percentage,
    
    -- Métrica Calculada: Precio con descuento
    -- Fórmula: Precio * (1 - Descuento)
    base_price * (1 - discount_percentage) as discounted_price,
    
    -- Métrica Calculada: Precio con descuento + Impuestos (Neto)
    -- Fórmula: Precio * (1 - Descuento) * (1 + Impuesto)
    base_price * (1 - discount_percentage) * (1 + tax_percentage) as net_charge_price

from line_items