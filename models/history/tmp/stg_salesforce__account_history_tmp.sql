{{ config(enabled=var('salesforce__account_history_enabled', False)) }}

select *
from {{ var('account_history') }} 
limit 5