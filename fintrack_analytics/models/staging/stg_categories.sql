with
source as (
    select * from {{ source('raw', 'raw_categories') }}
),

mapping_groupes as (
    select * from {{ ref('mapping_groupes') }}
),
categories as (
    select
        src.id as categorie_id,
        TRIM(src.nom) as nom_categorie,
        TRIM(src.type) as type_categorie,
        TRIM(src.groupe) as groupe_categorie,
        mg.ordre_affichage,
        mg.priorite_dashboard
    from source src
    join mapping_groupes mg on TRIM(src.groupe) = mg.groupe
)

select * from categories