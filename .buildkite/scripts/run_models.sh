#!/bin/bash

set -euo pipefail

apt-get update
apt-get install libsasl2-dev

python3 -m venv venv
. venv/bin/activate
pip install --upgrade pip setuptools
pip install -r integration_tests/requirements.txt
mkdir -p ~/.dbt
cp integration_tests/ci/sample.profiles.yml ~/.dbt/profiles.yml

db=$1
echo `pwd`
cd integration_tests
dbt deps
dbt seed --target "$db" --full-refresh
dbt run --target "$db" --full-refresh
dbt test --target "$db"
dbt run --vars '{salesforce__user_role_enabled: false}' --target "$db" --full-refresh
dbt test --target "$db"
dbt run --vars '{account_history_enabled: true, contact_history_enabled: true, event_history_enabled: true, lead_history_enabled: true, opportunity_history_enabled: true, task_history_enabled: true, user_history_enabled: true, user_role_history_enabled: true}' --target "$db" --full-refresh
dbt test --target "$db"
dbt run-operation fivetran_utils.drop_schemas_automation --target "$db"
