with
source as (
    select * from {{ source('raw', 'raw_budgets') }}
),

budgets as (
    select
        id as budget_id,
        compte_id,
        CAST(mois as DATE) as mois,
        categorie_id,
        CAST(montant_prevu as DECIMAL(10, 2)) as montant_prevu
    from source
)

select * from budgets