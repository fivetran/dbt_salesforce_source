{{ config(enabled=var('user_history_enabled', False)) }}

select * 
from {{ var('user_history') }}