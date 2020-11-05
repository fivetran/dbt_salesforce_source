# Salesforce 

This package models Salesforce data from [Fivetran's connector](https://fivetran.com/docs/applications/salesforce). It uses data in the format described by [this ERD](https://docs.google.com/presentation/d/1fB6aCiX_C1lieJf55TbS2v1yv9sp-AHNNAh2x7jnJ48/edit#slide=id.g3cb9b617d1_0_237).

This package enriches your Fivetran data by doing the following:
* Adds descriptions to tables and columns that are synced using Fivetran
* Adds freshness tests to source data
* Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
* Models staging tables, which will be used in our transform package

## Models

This package contains staging models, designed to work simultaneously with our [Salesforce modeling package](https://github.com/fivetran/dbt_salesforce).  The staging models:
* Remove any rows that are soft-deleted
* Name columns consistently across all packages:
    * Boolean fields are prefixed with `is_` or `has_`
    * Timestamps are appended with `_at`
    * ID primary keys are prefixed with the name of the table.  For example, the user table's ID column is renamed user_id.


## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

## Configuration
By default, this package will run using your target database and the `salesforce` schema. If this is not where your Salesforce data is (perhaps your Salesforce schema is `salesforce_fivetran`), add the following configuration to your `dbt_project.yml` file. You can also pass through additional columns for the account, opportunity, and user models.

```yml
# dbt_project.yml

...
config-version: 2

vars:
    salesforce_source:
        salesforce_database: your_database_name
        salesforce_schema: your_schema_name
        account_pass_through_columns:
            - "custom_column_name"
        opportunity_pass_through_columns:
            - "custom_column_name"
        user_pass_through_columns:
            - "custom_column_name"
```

## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `master`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Resources:
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Learn more about Fivetran [in the Fivetran docs](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
