{{ config(enabled=var('salesforce__opportunity_history_enabled', False)) }}

select * 
from {{ var('opportunity_history') }}