{{ config(materialized='view') }}

select
    oid_etablissement,
    nom_etablissement,
    pays,
    type_organisation,
    current_timestamp as load_dts,      -- champ obligatoire pour Data Vault (horodatage du chargement)
    'ERASMUS' as source                -- champ obligatoire pour Data Vault (identifiant de la source)
from {{ ref('etablissement') }}

