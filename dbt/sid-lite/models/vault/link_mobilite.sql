{{ config(materialized='incremental') }}

{%- set source_model = "stg_mobilite" -%}
{%- set src_pk = "id_mobilite" -%}
{%- set src_fk = ["id_etudiant", "oid_etablissement_origine", "oid_etablissement_accueil"] -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "source" -%}

{{ automate_dv.link(
    src_pk=src_pk,
    src_fk=src_fk,
    src_ldts=src_ldts,
    src_source=src_source,
    source_model=source_model
) }}
