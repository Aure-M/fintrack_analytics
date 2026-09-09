select sm.compte_id, sm.mois
from {{ ref('mart_solde_mensuel') }} as sm
join {{ ref('dim_comptes') }} as c on sm.compte_id = c.compte_id
where sm.solde_cumule < 0 and c.type_compte = 'epargne'
