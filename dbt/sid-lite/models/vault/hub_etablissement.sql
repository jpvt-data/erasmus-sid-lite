{# hub_etablissement.sql #}
{{ config(materialized='table') }}

{%- set src_pk = 'oid_etablissement' -%}
{%- set src_nk = 'oid_etablissement' -%}
{%- set src_ldts = 'load_dts' -%}
{%- set src_source = 'source' -%}
{%- set source_model = 'stg_etablissement' -%}

{{ automate_dv.hub(
    src_pk=src_pk,
    src_nk=src_nk,
    src_ldts=src_ldts,
    src_source=src_source,
    source_model=source_model
) }}

