with

source as (
    select * from {{ source('raw', 'raw_virements') }}
)


select
    id as virement_id,
    compte_source_id,
    compte_dest_id,
    CAST(montant AS DECIMAL(10, 2)) as montant,
    CAST(date_virement AS TIMESTAMP_NTZ) as date_virement,
    TRIM(motif) as motif,
    TRIM(statut) as statut
from source