use role ACCOUNTADMIN;
-- Base de données
create database FINTRACK_DB;

-- Schémas
create schema RAW;
create schema STAGING;
create schema MARTS;

-- Warehouses
create warehouse FINTRACK_WH with WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60 AUTO_RESUME = TRUE;

-- Roles, Permissions 
create role FINTRACK_ROLE;
grant all on database FINTRACK_DB to role FINTRACK_ROLE;
grant all on all schemas in database FINTRACK_DB to role FINTRACK_ROLE;
grant usage on warehouse FINTRACK_COMPUTE_WH to role FINTRACK_ROLE;

