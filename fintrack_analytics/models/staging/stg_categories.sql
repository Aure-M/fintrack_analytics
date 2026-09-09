with
source as (
    select * from {{ source('raw', 'raw_categories') }}
),

categories as (
    select
        id as categorie_id,
        TRIM(nom) as nom_categorie,
        TRIM(type) as type_categorie,
        TRIM(groupe) as groupe_categorie
    from source
)

select * from categories