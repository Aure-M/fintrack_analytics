{{ config(
    materialized='incremental',
    unique_key='transaction_id',
    incremental_strategy='merge',
    pre_hook="{{ log_max_date_pre_hook() }}"
) }}

with enrichies as (
    select * from {{ ref('int_transactions_enrichies') }}
)

select
    transaction_id,
    compte_id,
    categorie_id,
    date_transaction,
    mois_transaction,
    montant,
    montant_signe,
    type_operation,
    nom_client,
    nom_categorie,
    groupe_categorie,
    statut
from enrichies
where statut = 'validee'