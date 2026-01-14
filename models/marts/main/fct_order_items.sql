with order_items as (
    select * from {{ ref('int_order_items_extended') }}
),

orders as (
    select * from {{ ref('stg_tpch__orders') }}
)

select
    -- IDs (Surrogate Keys y Foreign Keys)
    oi.line_item_id,
    oi.order_id,
    o.customer_id, -- Traído desde Orders
    oi.part_id,
    oi.supplier_id,
    
    -- Dimensiones Degeneradas y Fechas
    o.order_date,
    oi.ship_date,
    o.order_priority,
    oi.return_flag,
    oi.status_code,
    
    -- Métricas (Pasamos las calculadas previamente)
    oi.quantity,
    oi.base_price,
    oi.discount_percentage,
    oi.tax_percentage,
    oi.discounted_price,
    oi.net_charge_price

from order_items oi
inner join orders o 
    on oi.order_id = o.order_id