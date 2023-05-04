<p align="center">
    <a alt="License"
        href="https://github.com/fivetran/dbt_salesforce_source/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_,<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
    <a alt="Fivetran Quickstart Compatibile"
        href="https://fivetran.com/docs/transformations/dbt/quickstart">
        <img src="https://img.shields.io/badge/Fivetran_Quickstart_Compatible%3F-yes-green.svg" /></a>
</p>

# Salesforce Source dbt Package ([Docs](https://fivetran.github.io/dbt_salesforce_source/)) 
# 📣 What does this dbt package do?
<!--section="salesforce_source_model"-->
- Cleans, tests, and prepares your Salesforce data from [Fivetran's connector](https://fivetran.com/docs/applications/salesforce) for analysis.
- Generates a comprehensive data dictionary of your Salesforce data via the [dbt docs site](https://fivetran.github.io/dbt_salesforce_source/)
- Materializes staging tables which leverage data in the format described by [this ERD](https://fivetran.com/docs/applications/salesforce/#schemainformation) and is intended to work simultaneously with our [Salesforce modeling package](https://github.com/fivetran/dbt_salesforce)
    - Refer to our [Docs site](https://fivetran.github.io/dbt_salesforce_source/#!/overview/salesforce_source/models/?g_v=1) for more details about these materialized models. 
<!--section-end-->

# 🎯 How do I use the dbt package?
## Step 1: Pre-Requisites
- **Connector**: Have the Fivetran Salesforce connector syncing data into your warehouse. 
- **Database support**: This package has been tested on **Postgres**, **Databricks**, **Redshift**, **Snowflake**, and **BigQuery**.

### Databricks Dispatch Configuration
If you are using a Databricks destination with this package you will need to add the below (or a variation of the below) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

## Step 2: Installing the Package (skip if also using the `salesforce` transformation package)
Include the following salesforce_source package version in your `packages.yml`
> Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

```yaml
packages:
  - package: fivetran/salesforce_source
    version: [">=0.7.0", "<0.8.0"] # we recommend using ranges to capture non-breaking changes automatically
```
## Step 3: Configure Your Variables
### Database and Schema Variables
By default, this package will run using your target database and the `salesforce` schema. If this is not where your Salesforce data is (perhaps your Salesforce schema is `salesforce_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    salesforce_database: your_database_name
    salesforce_schema: your_schema_name
    salesforce__<default_source_table_name>_identifier: your_table_name
```

### Disabling Models
It is possible that your Salesforce connector does not sync every table that this package expects. If your syncs exclude certain tables, it is because you either don't use that functionality in Salesforce or actively excluded some tables from your syncs. 

To disable the corresponding functionality in this package, you must add the corresponding variable(s) to your `dbt_project.yml`, which are listed below. By default, that is if none of these variables are added, all variables are assumed to be true. Add variables only for the tables you would like to disable:

```yml
vars:
  salesforce__user_role_enabled: false # Disable if you do not have the user_role table
  salesforce__lead_enabled: false # Disable if you do not have the lead table
  salesforce__event_enabled: false # Disable if you do not have the event table
  salesforce__task_enabled: false # Disable if you do not have the task table
  salesforce__opportunity_line_item_enabled: false # Disable if you do not have the opportunity_line_item table
  salesforce__order_enabled: false # Disable if you do not have the order table
  salesforce__product_2_enabled: false # Disable if you do not have the product_2 table
```
The corresponding metrics from the disabled tables will not populate in the downstream models.

### Salesforce History Mode
If you have Salesforce [History Mode](https://fivetran.com/docs/getting-started/feature/history-mode) enabled for your connector, the source tables will include all historical records. This package is designed to deal with non-historical data. As such, if you have History Mode enabled you will want to set the desired `using_[table]_history_mode_active_records` variable(s) as `true` to filter for only active records. These variables are disabled by default; however, you may add the below variable configuration within your `dbt_project.yml` file to enable the feature.
```yml
# dbt_project.yml

...
vars:
  using_account_history_mode_active_records: true      # false by default. Only use if you have history mode enabled.
  using_opportunity_history_mode_active_records: true  # false by default. Only use if you have history mode enabled.
  using_user_role_history_mode_active_records: true    # false by default. Only use if you have history mode enabled.
  using_user_history_mode_active_records: true         # false by default. Only use if you have history mode enabled.
  using_contact_history_mode_active_records: true      # false by default. Only use if you have history mode enabled.
  using_lead_history_mode_active_records: true         # false by default. Only use if you have history mode enabled.
  using_task_history_mode_active_records: true         # false by default. Only use if you have history mode enabled.
  using_event_history_mode_active_records: true        # false by default. Only use if you have history mode enabled.
  using_product_2_history_mode_active_records: true    # false by default. Only use if you have history mode enabled.
  using_order_history_mode_active_records: true        # false by default. Only use if you have history mode enabled.
  using_opportunity_line_item_history_mode_active_records: true       # false by default. Only use if you have history mode enabled.
```
### Change the Source Table References
If an individual source table has a different name than expected, provide the name of the table as it appears in your warehouse to the respective variable:
> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_salesforce_source/blob/main/dbt_project.yml) variable declarations to see the expected names.

```yml
# dbt_project.yml
...
config-version: 2
vars:
    salesforce_<default_source_table_name>_identifier: your_table_name
```  

### 🚨 Snowflake Users
If you do **not** use the default all-caps naming conventions for Snowflake, you may need to provide the case-sensitive spelling of your source tables that are also Snowflake reserved words. 

In this package, this would apply to the `ORDER` source. If you are receiving errors for this source, include the below identifier in your `dbt_project.yml` file:

```yml
vars:
    salesforce_order_identifier: "Order" # as an example, must include the double-quotes and correct case!
```  

## (Optional) Step 4: Additional Configurations
### Change the Build Schema
By default, this package builds the Salesforce staging models within a schema titled (<target_schema> + `_stg_salesforce`) in your target database. If this is not where you would like your Salesforce staging data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
models:
    salesforce_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```
### Adding Formula Fields as Pass Through Columns
The source tables Fivetran syncs do not include formula fields. If your company uses them, you can generate them by referring to the [Salesforce Formula Utils](https://github.com/fivetran/dbt_salesforce_formula_utils) package. To pass through the fields, add the [latest version of the package](https://github.com/fivetran/dbt_salesforce_formula_utils#installing-the-macro-package). We recommend confirming your formula field models successfully populate before integrating with the Salesforce package. 

Include the following within your `dbt_project.yml` file:
```yml
# Using the opportunity source table as example, update the opportunity variable to reference your newly created model that contains the formula fields:
  opportunity: "{{ ref('my_opportunity_formula_table') }}"

# In addition, add the desired field names as pass through columns
  salesforce__opportunity_pass_through_columns:
    - name: "salesforce__opportunity_field"
      alias: "opportunity_field_x"
```

### Adding Passthrough Columns
This package includes all source columns defined in the `generate_columns.sql` macro.  You can add more columns using our passthrough column variables. These variables allow for the passthrough fields to be aliased (`alias`) and casted (`transform_sql`) if desired, but not required. Datatype casting is configured via a sql snippet within the `transform_sql` key. You may add the desired sql while omitting the `as field_name` at the end and your custom pass-though fields will be casted accordingly. Use the below format for declaring the respective pass-through variables:


```yml
# dbt_project.yml

...
vars:
  salesforce__account_pass_through_columns: 
    - name: "salesforce__account_field"
      alias: "renamed_field"
      transform_sql: "cast(renamed_field as string)"
  salesforce__contact_pass_through_columns: 
    - name: "salesforce__contact_field"
      alias: "contact_field_x"
  salesforce__event_pass_through_columns: 
    - name: "salesforce__event_field"
      transform_sql: "cast(salesforce__event_field as int64)"
  salesforce__lead_pass_through_columns: 
    - name: "salesforce__lead_field"
  salesforce__opportunity_pass_through_columns: 
    - name: "salesforce__opportunity_field"
      alias: "opportunity_field_x"
  salesforce__opportunity_line_item_pass_through_columns: 
    - name: "salesforce__opportunity_line_item_field"
      alias: "opportunity_line_item_field_x"
    - name: "field_name_2"
  salesforce__order_pass_through_columns: 
    - name: "salesforce__order_field"
      alias: "order_field_x"
    - name: "another_field"
      alias: "field_abc"
  salesforce__product_2_pass_through_columns: 
    - name: "salesforce__product_2_field"
      alias: "product_2_field_x"
  salesforce__task_pass_through_columns: 
    - name: "salesforce__task_field"
      alias: "task_field_x"
  salesforce__user_role_pass_through_columns: 
    - name: "salesforce__user_role_field"
      alias: "user_role_field_x"
  salesforce__user_pass_through_columns: 
    - name: "salesforce__user_field"
```

## (Optional) Step 5: Orchestrate your models with Fivetran Transformations for dbt Core™
Fivetran offers the ability for you to orchestrate your dbt project through the [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt) product. Refer to the linked docs for more information on how to setup your project for orchestration through Fivetran. 
# 🔍 Does this package have dependencies?
This dbt package is dependent on the following dbt packages. For more information on the below packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> **If you have any of these dependent packages in your own `packages.yml` I highly recommend you remove them to ensure there are no package version conflicts.**
```yml
packages:
    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]

    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]

    - package: dbt-labs/spark_utils
      version: [">=0.3.0", "<0.4.0"]
```
# 🙌 How is this package maintained and can I contribute?
## Package Maintenance
The Fivetran team maintaining this package **only** maintains the latest version of the package. We highly recommend you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/salesforce_source/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_salesforce_source/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

## Contributions
These dbt packages are developed by a small team of analytics engineers at Fivetran. However, the packages are made better by community contributions! 

We highly encourage and welcome contributions to this package. Check out [this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) on the best workflow for contributing to a package!

# 🏪 Are there any resources available?
- If you encounter any questions or want to reach out for help, please refer to the [GitHub Issue](https://github.com/fivetran/dbt_salesforce_source/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran, or would like to request a future dbt package to be developed, then feel free to fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
- Have questions or want to be part of the community discourse? Create a post in the [Fivetran community](https://community.fivetran.com/t5/user-group-for-dbt/gh-p/dbt-user-group) and our team along with the community can join in on the discussion!
