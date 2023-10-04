{{ config(enabled=var('salesforce__contact_history_enabled', False)) }}

select * 
from {{ var('contact_history') }}