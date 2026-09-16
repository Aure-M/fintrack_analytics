with 

source as (
    select * from {{ source('raw', 'raw_alertes') }}
),

seuils as (
    select * from {{ ref('seuils_alerte') }}
)


select
    src.id as alerte_id,
    src.compte_id,
    src.categorie_id,
    CAST(src.mois AS DATE) as mois,
    TRIM(src.type_alerte) as type_alerte,
    CAST(src.montant_prevu AS DECIMAL(10, 2)) as montant_prevu,
    CAST(src.montant_reel AS DECIMAL(10, 2)) as montant_reel,
    CAST(src.date_generation AS TIMESTAMP_NTZ) as date_generation,
    src.acquittee,
    sa.seuil_pct,
    sa.severite
from source src
join seuils sa on src.type_alerte = sa.code_alerte