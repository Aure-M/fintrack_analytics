{% test test_solde_compte_epargne(model) %}

with solde_compte_epargne as (
    select 
        m.compte_id,
        m.solde_cumule,
    from {{ model }} as m
    join {{ ref('dim_comptes') }} c on c.compte_id = m.compte_id
    where c.type_compte = 'epargne'
)


select
    compte_id
from solde_compte_epargne
where solde_cumule < 0

{% endtest %}