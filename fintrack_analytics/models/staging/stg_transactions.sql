with
source as (
    select * from {{ source('raw', 'raw_transactions') }}
),

transactions as (
    select
        id as transaction_id,
        compte_id,
        CAST(date_transaction AS TIMESTAMP_NTZ) as date_transaction,
        CAST(montant AS DECIMAL(10, 2)) as montant,
        TRIM(type_operation) as type_operation,
        TRIM(categorie_id) as categorie_id,
        TRIM(statut) as statut,
        description
    from source
)

select * from transactions