{{ config(
    materialized='incremental',
    unique_key='unique_virement_id',
    incremental_strategy='merge'
) }}


with

virements as (
    select * from {{ ref('int_virements_enrichis') }}
)



select
    unique_virement_id,
    virement_id,
    compte_id,
    date_virement,
    mois_virement,
    montant,
    montant_signe,
    type_operation,
    motif,
    statut
from virements
where statut = 'execute'