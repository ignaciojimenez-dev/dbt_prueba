-- Replicando TPC-H Q1: Pricing Summary Report
with fct_orders as (
    select * from {{ ref('fct_order_items') }}
)

select
    return_flag,
    status_code,
    
    -- Agregaciones (Sumas y Promedios)
    sum(quantity) as sum_qty,
    sum(base_price) as sum_base_price,
    sum(discounted_price) as sum_disc_price, -- Usamos la col pre-calculada
    sum(net_charge_price) as sum_charge,     -- Usamos la col pre-calculada
    
    avg(quantity) as avg_qty,
    avg(base_price) as avg_price,
    avg(discount_percentage) as avg_disc,
    
    count(*) as count_order

from
    fct_orders

where
    -- Lógica del filtro de fecha Q1: 
    -- "within 60-120 days of the greatest ship date contained in the database"
    -- Para el reto usamos la fecha fija del ejemplo: 1998-12-01 menos 90 días
    ship_date <= dateadd(day, -90, to_date('1998-12-01'))

group by
    return_flag,
    status_code

order by
    return_flag,
    status_code