{{
    config(
        materialized='incremental',
        unique_key='line_item_id',
        on_schema_change='fail' 
    )
}}

with source as (
    select * from {{ source('tpch', 'lineitem') }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['l_orderkey', 'l_linenumber']) }} as line_item_id, 
        l_orderkey as order_id,
        l_partkey as part_id,
        l_suppkey as supplier_id,
        l_linenumber as line_number,
        l_quantity as quantity,
        l_extendedprice as base_price,
        l_discount as discount_percentage,
        l_tax as tax_percentage,
        l_returnflag as return_flag,
        l_linestatus as status_code,
        l_shipdate as ship_date,
        l_commitdate as commit_date,
        l_receiptdate as receipt_date,
        l_shipinstruct as ship_instructions,
        l_shipmode as ship_mode
    from source
)

select * from renamed

{% if is_incremental() %}
  where ship_date > (select max(ship_date) from {{ this }})
{% endif %}