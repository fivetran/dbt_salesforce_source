{{ config(enabled=var('user_role_history_enabled', False)) }}

select * 
from {{ var('user_role_history') }}