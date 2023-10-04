{{ config(enabled=var('salesforce__lead_history_enabled', False)) }}

select * 
from {{ var('lead_history') }}