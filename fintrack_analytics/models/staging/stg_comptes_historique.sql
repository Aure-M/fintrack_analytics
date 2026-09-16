
with

source as (
    select * from {{ source('snapshots', 'snap_comptes') }}
),

comptes_historique as (
    select
        dbt_scd_id as snap_comptes_id,
        id as compte_id,
        nom_client,
        TRIM(email) as email,
        TRIM(type_compte) as type_compte,
        CAST(date_ouverture AS DATE) as date_ouverture,
        CAST(solde_initial AS DECIMAL(10, 2)) as solde_initial,
        LOWER(statut) as statut,
        CAST (dbt_valid_from as TIMESTAMP_NTZ) as valide_depuis,
        CAST (dbt_valid_to as TIMESTAMP_NTZ) as valide_jusqua
    from source
)


select * from comptes_historique