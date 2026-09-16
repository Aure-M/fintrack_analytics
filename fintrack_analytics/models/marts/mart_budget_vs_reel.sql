with comptes_budgets_lisses as (
    select 
        b.compte_id as compte_id,
        c.nom_client as nom_client,
        b.categorie_id as categorie_id,
        --b.mois as mois,
        {{ generer_periode('b.mois') }} as mois,
        SUM(b.montant_prevu) as montant_prevu
    from {{ref('stg_budgets')}} b
    join {{ref('stg_comptes')}} c on c.compte_id = b.compte_id
    group by b.compte_id, b.mois, b.categorie_id, c.nom_client
),
debit_mois as (
    select 
        t.compte_id as compte_id,
        t.mois_transaction as mois_transaction,
        SUM(t.montant) as montant_reel,
        c.categorie_id as categorie_id,
        c.nom_categorie as nom_categorie
    from {{ref('fct_transactions')}} t
    join {{ref('stg_categories')}} c on t.categorie_id = c.categorie_id 
    where t.type_operation = 'debit'
    group by mois_transaction, t.compte_id, c.categorie_id, c.nom_categorie
)

---------------
select 
    cb.compte_id,
    cb.categorie_id,
    dm.nom_categorie,
    cb.mois,
    sum(dm.montant_reel) as montant_reel,
    avg(cb.montant_prevu) as montant_prevu,
    avg(cb.montant_prevu) - sum(dm.montant_reel) as ecart,
    sum(dm.montant_reel) > avg(cb.montant_prevu) as depassement
from debit_mois dm
full outer join comptes_budgets_lisses cb on cb.compte_id = dm.compte_id and cb.mois = dm.mois_transaction and cb.categorie_id = dm.categorie_id
group by cb.mois, cb.compte_id, cb.categorie_id, dm.nom_categorie, dm.mois_transaction
order by
    cb.compte_id,
    cb.mois,
    cb.categorie_id
