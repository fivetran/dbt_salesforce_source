{{ config(enabled=var('contact_history_enabled', False)) }}

select * 
from {{ var('contact_history') }}