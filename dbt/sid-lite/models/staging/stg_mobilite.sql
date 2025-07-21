{{ config(materialized='view') }}

select
    id_mobilite,
    id_etudiant,
    oid_etablissement_origine,
    oid_etablissement_accueil,
    date_debut,
    date_fin,
    type_mobilite,
    statut_mobilite,
    current_timestamp as load_dts,    -- champ pour Data Vault
    'ERASMUS' as source               -- champ pour Data Vault
from {{ ref('mobilite') }}
