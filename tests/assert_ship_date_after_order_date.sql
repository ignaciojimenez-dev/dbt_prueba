-- falla si la fecha de envio menor que la fecha de creacion del pedido
-- Si devuelve 0 filas, el test pasa.

select
    l.line_item_id,
    l.ship_date,
    o.order_date
from {{ ref('stg_tpch__line_items') }} l
join {{ ref('stg_tpch__orders') }} o 
    on l.order_id = o.order_key
where l.ship_date < o.order_date