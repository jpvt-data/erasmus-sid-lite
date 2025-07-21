{{ config(materialized='table') }}

{{ automate_dv.hub(
    src_pk='id_etudiant',
    src_nk='id_etudiant',
    src_ldts='load_dts',
    src_source='source',
    source_model='stg_etudiant'
) }}


