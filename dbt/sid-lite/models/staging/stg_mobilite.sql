SELECT
    id_mobilite,
    id_etudiant,
    oid_etablissement_origine,
    oid_etablissement_accueil,
    date_debut,
    date_fin,
    type_mobilite,
    statut_mobilite,
    current_timestamp as load_dts,
    'ERASMUS' as source,
    cast(
        encode(
            digest(
            coalesce(cast(id_mobilite as text),'') || '|' ||
            coalesce(cast(date_debut as text),'') || '|' ||
            coalesce(cast(date_fin as text),'') || '|' ||
            coalesce(cast(type_mobilite as text),'') || '|' ||
            coalesce(cast(statut_mobilite as text),''),
            'sha256'
            ),
            'hex'
            ) as text
        ) as hashdiff_mobilite
FROM {{ ref('mobilite') }}


