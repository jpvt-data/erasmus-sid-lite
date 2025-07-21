{{ config(materialized='view') }}

select
    id_etudiant,
    prenom,
    nom,
    sexe,
    date_naissance,
    nationalite,
    discipline
from {{ ref('etudiant') }}
