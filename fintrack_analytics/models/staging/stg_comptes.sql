with
source as (
    select * from {{ source('raw', 'raw_comptes') }}
),

comptes as (
    select
        id as compte_id,
        nom_client,
        TRIM(email) as email,
        TRIM(type_compte) as type_compte,
        CAST(date_ouverture AS DATE) as date_ouverture,
        CAST(solde_initial AS DECIMAL(10, 2)) as solde_initial,
        LOWER(statut) as statut
    from source
)

select * from comptes