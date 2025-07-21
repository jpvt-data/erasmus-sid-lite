{{ config(materialized='view') }}

select
    m.id_mobilite,
    m.date_debut,
    m.date_fin,
    m.type_mobilite,
    m.statut_mobilite,
    -- Etudiant
    etu.id_etudiant,
    etu.nom as nom_etudiant,
    etu.prenom as prenom_etudiant,
    etu.date_naissance,
    etu.sexe,
    etu.nationalite,
    -- Etablissement d'origine
    e_orig.oid_etablissement as oid_etablissement_origine,
    e_orig.nom_etablissement as nom_etab_origine,
    e_orig.pays as pays_etab_origine,
    e_orig.type_organisation as type_etab_origine,
    -- Etablissement d'accueil
    e_acc.oid_etablissement as oid_etablissement_accueil,
    e_acc.nom_etablissement as nom_etab_accueil,
    e_acc.pays as pays_etab_accueil,
    e_acc.type_organisation as type_etab_accueil,
    -- Techniques
    m.load_dts,
    m.source
from stg_mobilite m
left join stg_etudiant etu on m.id_etudiant = etu.id_etudiant
left join stg_etablissement e_orig on m.oid_etablissement_origine = e_orig.oid_etablissement
left join stg_etablissement e_acc on m.oid_etablissement_accueil = e_acc.oid_etablissement
