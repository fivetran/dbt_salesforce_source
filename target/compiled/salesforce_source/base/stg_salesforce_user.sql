with base as (

    select *
    from `digital-arbor-400`.`salesforce`.`user`

), fields as (

    select 
      id as user_id,
      name,
      city,
      state,
      manager_id,
      user_role_id
    from base

)

select *
from fields