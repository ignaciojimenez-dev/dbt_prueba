select
    line_item_id,
    base_price,
    discounted_price
from {{ ref('fct_order_items') }}
where discounted_price > base_price