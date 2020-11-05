with base as (

    select *
    from {{ var('user')}}

), fields as (

    select 
      id as user_id,
      name,
      city,
      state,
      manager_id,
      user_role_id
      {% if var('user_pass_through_columns') != [] %}
      ,
      {{ var('user_pass_through_columns') | join (", ")}}
      {% endif %}
    from base

)

select *
from fields
