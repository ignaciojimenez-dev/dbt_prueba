{{
    config(
        materialized='incremental',
        unique_key='order_key' 
    )
}}

select
    -- Identificadores
    o_orderkey as order_key,
    o_custkey as customer_key,

    -- Estados y Prioridades
    o_orderstatus as order_status,
    o_orderpriority as order_priority,
    o_shippriority as ship_priority,

    -- Detalles financieros y temporales
    o_orderdate as order_date,
    o_totalprice as total_price,

    -- Información administrativa / Metadatos
    o_clerk as clerk_name,
    o_comment as order_comment

from {{ source('tpch', 'orders') }}

{% if is_incremental() %}
  where o_orderdate > (select max(order_date) from {{ this }})
{% endif %}