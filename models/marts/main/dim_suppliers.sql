with suppliers as (
    select * from {{ ref('stg_tpch__suppliers') }}
),
locations as (
    select * from {{ ref('int_locations_joined') }}
)

select
    s.supplier_id,
    s.supplier_name,
    s.supplier_address,
    s.supplier_phone,
    s.account_balance,
    -- Datos geograficos enriquecidos en interm
    l.nation_name,
    l.region_name
from suppliers s
left join locations l on s.nation_id = l.nation_id