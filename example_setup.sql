// Example Setup Commands, only use as needed

use role accountadmin;
create role demo_role;
grant role demo_role to user "xxxx.xxxx@xxxxx.xxx"

// one-time only for the entire account:
CREATE SECURITY INTEGRATION SNOWSERVICES_INGRESS_OAUTH
TYPE=oauth
OAUTH_CLIENT=snowservices_ingress
ENABLED=true;

// other roles can create their own compute pools too:
create compute pool proxy_compute_pool
    min_nodes = 1
    max_nodes = 1
    Instance_family = standard_1;

grant all on compute pool proxy_compute_pool to role demo_role;
# grant monitor on compute pool proxy_compute_pool to role demo_role;
# grant usage on compute pool proxy_compute_pool to role demo_role;

create compute pool server_compute_pool
    min_nodes = 1
    max_nodes = 1
    Instance_family = standard_2;
grant all on compute pool server_compute_pool to role demo_role;
# grant usage on compute pool server_compute_pool to role demo_role;
# grant monitor on compute pool server_compute_pool to role demo_role;

create or replace warehouse demo_warehouse with
    warehouse_size='X-SMALL'
    auto_suspend = 180
    auto_resume = true
    initially_suspended=true;
grant all on warehouse demo_warehouse to role demo_role;
create database demo_db;
grant ownership on database demo_db to role demo_role;

use role demo_role;
use database demo_db;
use warehouse demo_warehouse;

create schema if not exists data_schema;
create image repository if not exists demo_repository;

use role demo_role;
use database demo_db;
use warehouse demo_warehouse;
create schema data_schema;
create or replace image repository demo_repository;
create stage demo_stage;
