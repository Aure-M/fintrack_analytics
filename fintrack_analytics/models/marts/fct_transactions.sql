select
    transaction_id,
    compte_id,
    categorie_id,
    date_transaction,
    mois_transaction,
    montant,
    type_operation,
    (CASE WHEN type_operation = 'credit' THEN montant ELSE -montant END) as montant_signe,
    nom_client,
    nom_categorie,
    groupe_categorie,
    statut
from {{ ref("int_transactions_enrichies") }}
where statut = 'validee'