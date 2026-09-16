select 
    snap_comptes_id,
    compte_id,
    nom_client,
    email,
    type_compte,
    date_ouverture,
    solde_initial,
    statut,
    valide_depuis,
    valide_jusqua,
    (CASE WHEN valide_jusqua IS NULL THEN TRUE ELSE FALSE END) as est_version_courante,
    (CASE WHEN valide_jusqua IS NULL THEN DATEDIFF('minute', CURRENT_DATE, valide_depuis) ELSE DATEDIFF('minute', valide_depuis, valide_jusqua) END) as duree_version
from {{ ref('stg_comptes_historique') }}