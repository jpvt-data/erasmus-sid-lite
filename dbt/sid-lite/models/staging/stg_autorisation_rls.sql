{{ config(materialized='view') }}

select
    user_email,
    oid_etablissement,
    current_timestamp as load_dts,   -- (optionnel) pour traçabilité
    'ERASMUS' as source    -- (optionnel) pour l'origine
from {{ ref('table_autorisations_rls') }}
