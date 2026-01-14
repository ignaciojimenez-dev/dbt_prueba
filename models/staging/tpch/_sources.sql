version: 2

sources:
  - name: tpch
    database: SNOWFLAKE_SAMPLE_DATA
    schema: TPCH_SF1
    tables:
      - name: orders
      - name: customer
      - name: lineitem
      - name: part       # Productos
      - name: supplier   # Proveedores
      - name: nation     # Países ( enriquecer dimensiones)
      - name: region
      - name: partsupp     