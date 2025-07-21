{{ config(materialized='view') }}

select
    oid_etablissement,
    nom_etablissement,
    pays,
    type_organisation
from {{ ref('etablissement') }}
