{{ config(enabled=var('salesforce__event_history_enabled', False)) }}

select * 
from {{ var('event_history') }}