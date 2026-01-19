with customers as (
    select * from {{ ref('stg_tpch__customers') }}
),
locations as (
    select * from {{ ref('int_locations_joined') }}
)

select
    c.customer_id,
    c.customer_name,
    c.customer_address,
    c.customer_phone,
    c.account_balance,
    c.market_segment,
    -- Datos geograficos enriquecidos desde intermediate
    l.nation_name,
    l.region_name
from customers c
left join locations l on c.nation_id = l.nation_id