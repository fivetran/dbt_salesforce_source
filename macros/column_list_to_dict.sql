{% macro column_list_to_dict(column_list) %}

{# 
    This macro is a step in a workflow applied across models. It converts the list of dictionaries generated by the `get_*_columns` macros into a dictionary of dictionaries for use in the `coalesce_rename` macro. This conversion is necessary so that each column dictionary entry can be accessed by a key, rather than iterating through a list. 

    Overview:
    1. `get_*_columns`: Creates list of snake_case columns for a given source table.  
        1a. `add_renamed_columns`: Appends camelCase spellings of columns to the list.  
        1b. `add_pass_through_columns`: Appends columns specified in the passthrough variable to the list.  
    2. `column_list_to_dict`: Converts the list of columns generated in Step 1 into a dictionary, simplifying subsequent operations.  
    3. `fill_staging_columns`: Ensures all columns from Step 1 are present in the source table by filling `null` values for any missing columns. For columns with multiple spellings, a `null` column is created for the unused spelling.  
    4. `coalesce_rename`: Uses the dictionary from `column_list_to_dict` to coalesce a column with its renamed counterpart. This step generates the final column and supports custom arguments for renamed spelling, data type, and alias to override default values.  
#}

    {%- set column_dict = {} -%}
    {%- for col in column_list -%}
        {%- do column_dict.update({col.name: col}) if not col.is_rename -%}
    {%- endfor -%}
    {{ return(column_dict) }}

{% endmacro %}