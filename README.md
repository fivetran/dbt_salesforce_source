[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 
# Salesforce ([docs](https://dbt-salesforce-source.netlify.app/)) 

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

Include in your `packages.yml`

```yaml
packages:
  - package: fivetran/salesforce_source
    version: [">=0.4.0", "<0.5.0"]
```

## Configuration
By default, this package will run using your target database and the `salesforce` schema. If this is not where your Salesforce data is (perhaps your Salesforce schema is `salesforce_fivetran`), add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
vars:
  salesforce_source:
    salesforce_database: your_database_name
    salesforce_schema: your_schema_name
```

This package includes all source columns defined in the `generate_columns.sql` macro. To add additional columns to this package, do so using our pass-through column variables. This is extremely useful if you'd like to include custom fields to the package.


```yml
# dbt_project.yml

...
vars:
  salesforce_source:
    account_pass_through_columns: [account_custom_field_1, account_custom_field_2]
    opportunity_pass_through_columns: [my_opp_custom_field]
    user_pass_through_columns: [users_have_custom_fields_too, lets_add_them_all]
```

### Salesforce History Mode
If you have Salesforce [History Mode](https://fivetran.com/docs/getting-started/feature/history-mode) enabled for your connector, the source tables will include all historical records. This package is designed to deal with non-historical data. As such, if you have History Mode enabled you will want to set the desired `using_[table]_history_mode_active_records` variable(s) as `true` to filter for only active records. These variables are disabled by default; however, you may add the below variable configuration within your `dbt_project.yml` file to enable the feature.
```yml
# dbt_project.yml

...
vars:
  salesforce_source:
    using_account_history_mode_active_records: true      # false by default. Only use if you have history mode enabled.
    using_opportunity_history_mode_active_records: true  # false by default. Only use if you have history mode enabled.
    using_user_role_history_mode_active_records: true    # false by default. Only use if you have history mode enabled.
    using_user_history_mode_active_records: true         # false by default. Only use if you have history mode enabled.
```

## Database support
This package has been tested on BigQuery, Snowflake, Redshift, and Postgres.

## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `main`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Resources:
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Have questions, feedback, or need help? Book a time during our office hours [here](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or email us at solutions@fivetran.com
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Learn how to orchestrate dbt transformations with Fivetran [here](https://fivetran.com/docs/transformations/dbt)
- Learn more about Fivetran overall [in our docs](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
