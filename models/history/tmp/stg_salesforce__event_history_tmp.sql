{{ config(enabled=var('event_history_enabled', False)) }}

select * 
from {{ var('event_history') }}