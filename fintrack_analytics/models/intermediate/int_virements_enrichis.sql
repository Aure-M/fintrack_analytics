with 

debits as (
    select 
        CONCAT(virement_id,'_debit') as unique_virement_id,
        virement_id,
        compte_source_id as compte_id,
        -montant as montant_signe,
        montant,
        'debit' as type_operation,
        -- DATE_TRUNC('month', date_virement) as mois_virement,
        {{ generer_periode('date_virement') }} as mois_virement,
        date_virement,
        motif,
        statut
    from {{ ref('stg_virements') }}
),
credits as (
    select 
        CONCAT(virement_id,'_credit') as unique_virement_id,
        virement_id,
        compte_dest_id as compte_id,
        montant as montant_signe,
        montant,
        'credit' as type_operation,
        --DATE_TRUNC('month', date_virement) as mois_virement,
        {{ generer_periode('date_virement') }} as mois_virement,
        date_virement,
        motif,
        statut
    from {{ ref('stg_virements') }}
),

virements_enrichis as (
    select * from debits
    union all
    select * from credits
    order by date_virement desc
)


select * from virements_enrichis