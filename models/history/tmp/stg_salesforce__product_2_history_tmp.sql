{{ config(enabled=var('salesforce__product_2_history_enabled', False)) }}

select * 
from {{ var('product_2_history') }}