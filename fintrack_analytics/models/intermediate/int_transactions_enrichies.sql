with

transactions as (
    select * from {{ ref('stg_transactions') }}
),

comptes as (
    select 
        compte_id,
        nom_client,
        type_compte
    from {{ ref('stg_comptes') }}
),

categories as (
    select 
        categorie_id,
        nom_categorie,
        type_categorie,
        groupe_categorie
    from {{ ref('stg_categories') }}
)


select
    t.transaction_id as transaction_id,
    t.compte_id as compte_id,
    c.nom_client as nom_client,
    c.type_compte as type_compte,
    t.date_transaction as date_transaction,
    -- DATE_TRUNC('month', t.date_transaction) as mois_transaction,
    {{ generer_periode('t.date_transaction') }} as mois_transaction,
    t.montant as montant,
    (CASE WHEN t.type_operation = 'debit' THEN -t.montant ELSE t.montant END) as montant_signe,
    t.type_operation as type_operation,
    t.categorie_id as categorie_id,
    cat.nom_categorie as nom_categorie,
    cat.type_categorie as type_categorie,
    cat.groupe_categorie as groupe_categorie,
    t.statut as statut,
    t.description as description
from transactions t
left join comptes c on t.compte_id = c.compte_id
left join categories cat on t.categorie_id = cat.categorie_id