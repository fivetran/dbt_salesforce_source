{{ config(enabled=var('salesforce__user_history_enabled', False)) }}

select * 
from {{ var('user_history') }}