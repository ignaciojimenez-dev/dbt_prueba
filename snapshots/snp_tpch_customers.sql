{% snapshot snp_tpch_customers %}

{{
    config(
      target_database='SNOWFLAKE_SAMPLE_DATA', -- Tu base de datos destino 
      target_schema='snapshots',               -- Un esquema separado 
      unique_key='c_custkey',                  -- La clave primaria de la fuente
      
      strategy='check',                        -- Estrategia: Chequear columnas específicas
      check_cols=['c_address', 'c_phone', 'c_mktsegment'] -- Si cambia esto, crea nueva versión
    )
}}

-- La query debe seleccionar de la FUENTE (Source), no de staging
select * from {{ source('tpch', 'customer') }}

{% endsnapshot %}