{{ config(enabled=var('salesforce__task_history_enabled', False)) }}

select * 
from {{ var('task_history') }} 