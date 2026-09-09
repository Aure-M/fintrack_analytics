with

comptes as (
    select * from {{ ref('stg_comptes') }}
)

select
    compte_id,
    nom_client,
    email,
    type_compte,
    date_ouverture,
    solde_initial,
    statut,
    DATEDIFF('day', date_ouverture, CURRENT_DATE) as anciennete
from comptes