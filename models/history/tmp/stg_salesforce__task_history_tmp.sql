{{ config(enabled=var('task_history_enabled', False)) }}

select * 
from {{ var('task_history') }} 