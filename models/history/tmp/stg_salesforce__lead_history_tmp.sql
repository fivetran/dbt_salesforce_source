{{ config(enabled=var('lead_history_enabled', False)) }}

select * 
from {{ var('lead_history') }}