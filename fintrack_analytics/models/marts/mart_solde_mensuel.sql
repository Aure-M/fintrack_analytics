with 

transactions_mensuelles as (
    select
        compte_id,
        mois_transaction AS mois,
        -- Total des crédits du mois
        SUM(CASE WHEN type_operation = 'credit' THEN montant ELSE 0 END) AS total_credits,
        -- Total des débits du mois
        SUM(CASE WHEN type_operation = 'debit' THEN montant ELSE 0 END) AS total_debits,
        -- Solde net du mois (crédits - débits)
        SUM(montant_signe) AS solde_net_mois
    from {{ ref('fct_transactions') }}
    group by 
        compte_id,
        mois_transaction
),
virements_mensuels as (
    select
        compte_id,
        mois_virement AS mois,
        -- Total des crédits du mois
        SUM(CASE WHEN type_operation = 'credit' THEN montant ELSE 0 END) AS total_credits,
        -- Total des débits du mois
        SUM(CASE WHEN type_operation = 'debit' THEN montant ELSE 0 END) AS total_debits,
        -- Solde net du mois (crédits - débits)
        SUM(montant_signe) AS solde_net_mois
    from {{ ref('fct_virements') }}
    group by 
        compte_id,
        mois_virement
),

comptes as (
    select
        compte_id,
        solde_initial
    from {{ ref('dim_comptes') }}
)

select
    t.compte_id,
    t.mois,
    t.total_credits + v.total_credits as total_credits,
    t.total_debits + v.total_debits as total_debits,
    t.solde_net_mois + v.solde_net_mois as solde_net_mois,
    -- Solde cumulé = solde_initial + somme cumulée des montant_signe
    c.solde_initial + 
        SUM(t.solde_net_mois) OVER (
            PARTITION BY t.compte_id 
            ORDER BY t.mois
        ) +
        SUM(v.solde_net_mois) OVER (
            PARTITION BY v.compte_id 
            ORDER BY v.mois
        )
    AS solde_cumule
from transactions_mensuelles t
join virements_mensuels v ON t.compte_id = v.compte_id AND t.mois = v.mois
join comptes c ON t.compte_id = c.compte_id
order by 
    t.compte_id,
    t.mois
