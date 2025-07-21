{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "stg_mobilite"
src_pk: "id_mobilite"
src_hashdiff: "hashdiff_mobilite"
src_payload:
  - "date_debut"
  - "date_fin"
  - "type_mobilite"
  - "statut_mobilite"
src_ldts: "load_dts"
src_source: "source"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(src_pk=metadata_dict["src_pk"],
                   src_hashdiff=metadata_dict["src_hashdiff"],
                   src_payload=metadata_dict["src_payload"],
                   src_ldts=metadata_dict["src_ldts"],
                   src_source=metadata_dict["src_source"],
                   source_model=metadata_dict["source_model"])   }}
