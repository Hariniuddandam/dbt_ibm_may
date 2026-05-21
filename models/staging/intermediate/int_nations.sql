{{config(materialized='incremental',unique_key='nation_id') }}

select * from {{ ref('stg_nations') }}