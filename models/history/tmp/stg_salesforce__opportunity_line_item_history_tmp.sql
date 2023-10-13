{{ config(enabled=var('salesforce__opportunity_line_item_history_enabled', False)) }}

select * 
from {{ var('opportunity_line_item_history') }}