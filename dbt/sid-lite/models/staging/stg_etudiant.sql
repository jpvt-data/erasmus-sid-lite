{{ config(materialized='view') }}

select
  id_etudiant,
  prenom,
  nom,
  sexe,
  date_naissance,
  nationalite,
  discipline,
  current_timestamp as load_dts,
  'ERASMUS' as source
from {{ ref('etudiant') }}
