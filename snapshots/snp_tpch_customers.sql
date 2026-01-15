{% snapshot snp_tpch_customers %}

{{
    config(
      target_schema='snapshots',
      unique_key='c_custkey',
      strategy='check',
      check_cols=['c_address', 'c_phone', 'c_mktsegment']
    )
}}

select * from {{ source('tpch', 'customer') }}

{% endsnapshot %}