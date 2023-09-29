{{ config(enabled=var('opportunity_history_enabled', False)) }}

select * 
from {{ var('opportunity_history') }}