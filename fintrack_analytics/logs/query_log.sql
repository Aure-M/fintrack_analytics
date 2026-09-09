-- created_at: 2026-09-09T10:20:45.803578624+00:00
-- finished_at: 2026-09-09T10:20:45.983572714+00:00
-- elapsed: 179ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c6f40c-0002-146c-0002-b68a00252c5e
-- desc: execute adapter call
show terse schemas in database FINTRACK_DB
    limit 10000
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "fintrack_analytics", "target_name": "prod"} */;
-- created_at: 2026-09-09T10:20:46.124315757+00:00
-- finished_at: 2026-09-09T10:20:46.366610156+00:00
-- elapsed: 242ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.stg_categories
-- query_id: 01c6f40c-0002-146b-0002-b68a0024d64e
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "FINTRACK_DB"."STAGING" LIMIT 10000;
-- created_at: 2026-09-09T10:20:46.353158504+00:00
-- finished_at: 2026-09-09T10:20:46.464939553+00:00
-- elapsed: 111ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.stg_budgets
-- query_id: 01c6f40c-0002-146b-0002-b68a0024d656
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "FINTRACK_DB"."STAGING" LIMIT 10000;
-- created_at: 2026-09-09T10:20:46.376168944+00:00
-- finished_at: 2026-09-09T10:20:46.765938352+00:00
-- elapsed: 389ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.stg_categories
-- query_id: 01c6f40c-0002-146c-0002-b68a00252c66
-- desc: execute adapter call
create or replace   view FINTRACK_DB.STAGING.stg_categories
  
  
  
  
  as (
    with
source as (
    select * from fintrack_db.raw.raw_categories
),

categories as (
    select
        id as categorie_id,
        TRIM(nom) as nom_categorie,
        TRIM(type) as type_categorie,
        TRIM(groupe) as groupe_categorie
    from source
)

select * from categories
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.fintrack_analytics.stg_categories", "profile_name": "fintrack_analytics", "target_name": "prod"} */;
-- created_at: 2026-09-09T10:20:46.476442582+00:00
-- finished_at: 2026-09-09T10:20:46.776763908+00:00
-- elapsed: 300ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.stg_budgets
-- query_id: 01c6f40c-0002-146c-0002-b68a00252c6a
-- desc: execute adapter call
create or replace   view FINTRACK_DB.STAGING.stg_budgets
  
  
  
  
  as (
    with
source as (
    select * from fintrack_db.raw.raw_budgets
),

budgets as (
    select
        id as budget_id,
        compte_id,
        CAST(mois as DATE) as mois,
        categorie_id,
        CAST(montant_prevu as DECIMAL(10, 2)) as montant_prevu
    from source
)

select * from budgets
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.fintrack_analytics.stg_budgets", "profile_name": "fintrack_analytics", "target_name": "prod"} */;
-- created_at: 2026-09-09T10:20:46.804275636+00:00
-- finished_at: 2026-09-09T10:20:47.112999248+00:00
-- elapsed: 308ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.stg_comptes
-- query_id: 01c6f40c-0002-146c-0002-b68a00252c6e
-- desc: execute adapter call
create or replace   view FINTRACK_DB.STAGING.stg_comptes
  
  
  
  
  as (
    with
source as (
    select * from fintrack_db.raw.raw_comptes
),

comptes as (
    select
        id as compte_id,
        nom_client,
        TRIM(email) as email,
        TRIM(type_compte) as type_compte,
        CAST(date_ouverture AS DATE) as date_ouverture,
        CAST(solde_initial AS DECIMAL(10, 2)) as solde_initial,
        LOWER(statut) as statut
    from source
)

select * from comptes
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.fintrack_analytics.stg_comptes", "profile_name": "fintrack_analytics", "target_name": "prod"} */;
-- created_at: 2026-09-09T10:20:46.797708557+00:00
-- finished_at: 2026-09-09T10:20:47.212755257+00:00
-- elapsed: 415ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.stg_transactions
-- query_id: 01c6f40c-0002-1515-0002-b68a0025e08a
-- desc: execute adapter call
create or replace   view FINTRACK_DB.STAGING.stg_transactions
  
  
  
  
  as (
    with
source as (
    select * from fintrack_db.raw.raw_transactions
),

transactions as (
    select
        id as transaction_id,
        compte_id,
        CAST(date_transaction AS TIMESTAMP_NTZ) as date_transaction,
        CAST(montant AS DECIMAL(10, 2)) as montant,
        TRIM(type_operation) as type_operation,
        TRIM(categorie_id) as categorie_id,
        TRIM(statut) as statut,
        description
    from source
)

select * from transactions
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.fintrack_analytics.stg_transactions", "profile_name": "fintrack_analytics", "target_name": "prod"} */;
-- created_at: 2026-09-09T10:20:47.136329578+00:00
-- finished_at: 2026-09-09T10:20:47.256637039+00:00
-- elapsed: 120ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.dim_categories
-- query_id: 01c6f40c-0002-146b-0002-b68a0024d65e
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "FINTRACK_DB"."MARTS" LIMIT 10000;
-- created_at: 2026-09-09T10:20:47.227216786+00:00
-- finished_at: 2026-09-09T10:20:47.417276768+00:00
-- elapsed: 190ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.dim_comptes
-- query_id: 01c6f40c-0002-1515-0002-b68a0025e08e
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "FINTRACK_DB"."MARTS" LIMIT 10000;
-- created_at: 2026-09-09T10:20:47.426624109+00:00
-- finished_at: 2026-09-09T10:20:48.739633981+00:00
-- elapsed: 1.3s
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.dim_comptes
-- query_id: 01c6f40c-0002-146b-0002-b68a0024d666
-- desc: execute adapter call
create or replace transient  table FINTRACK_DB.MARTS.dim_comptes
    
    
    
    
    as (with

comptes as (
    select * from FINTRACK_DB.STAGING.stg_comptes
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
    )

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.fintrack_analytics.dim_comptes", "profile_name": "fintrack_analytics", "target_name": "prod"} */;
-- created_at: 2026-09-09T10:20:47.273469653+00:00
-- finished_at: 2026-09-09T10:20:48.750650329+00:00
-- elapsed: 1.5s
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.dim_categories
-- query_id: 01c6f40c-0002-1509-0002-b68a0025cb06
-- desc: execute adapter call
create or replace transient  table FINTRACK_DB.MARTS.dim_categories
    
    
    
    
    as (select * from FINTRACK_DB.STAGING.stg_categories
    )

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.fintrack_analytics.dim_categories", "profile_name": "fintrack_analytics", "target_name": "prod"} */;
-- created_at: 2026-09-09T10:20:48.825888371+00:00
-- finished_at: 2026-09-09T10:20:50.329560068+00:00
-- elapsed: 1.5s
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.fct_transactions
-- query_id: 01c6f40c-0002-1515-0002-b68a0025e096
-- desc: execute adapter call
create or replace transient  table FINTRACK_DB.MARTS.fct_transactions
    
    
    
    
    as (with __dbt__cte__int_transactions_enrichies as (
with

transactions as (
    select * from FINTRACK_DB.STAGING.stg_transactions
),

comptes as (
    select 
        compte_id,
        nom_client,
        type_compte
    from FINTRACK_DB.STAGING.stg_comptes
),

categories as (
    select 
        categorie_id,
        nom_categorie,
        type_categorie,
        groupe_categorie
    from FINTRACK_DB.STAGING.stg_categories
)


select
    t.transaction_id as transaction_id,
    t.compte_id as compte_id,
    c.nom_client as nom_client,
    c.type_compte as type_compte,
    t.date_transaction as date_transaction,
    DATE_TRUNC('month', t.date_transaction) as mois_transaction,
    t.montant as montant,
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
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (
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
from __dbt__cte__int_transactions_enrichies
where statut = 'validee'
--EPHEMERAL-SELECT-WRAPPER-END
)
    )

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.fintrack_analytics.fct_transactions", "profile_name": "fintrack_analytics", "target_name": "prod"} */;
-- created_at: 2026-09-09T10:20:50.429028828+00:00
-- finished_at: 2026-09-09T10:20:51.355182364+00:00
-- elapsed: 926ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.mart_solde_mensuel
-- query_id: 01c6f40c-0002-1515-0002-b68a0025e09a
-- desc: execute adapter call
create or replace transient  table FINTRACK_DB.MARTS.mart_solde_mensuel
    
    
    
    
    as (with transactions_mensuelles as (
    select
        compte_id,
        mois_transaction AS mois,
        -- Total des crédits du mois
        SUM(CASE WHEN type_operation = 'credit' THEN montant ELSE 0 END) AS total_credits,
        -- Total des débits du mois
        SUM(CASE WHEN type_operation = 'debit' THEN montant ELSE 0 END) AS total_debits,
        -- Solde net du mois (crédits - débits)
        SUM(montant_signe) AS solde_net_mois
    from FINTRACK_DB.MARTS.fct_transactions
    group by 
        compte_id,
        mois_transaction
),

comptes as (
    select
        compte_id,
        solde_initial
    from FINTRACK_DB.MARTS.dim_comptes
)

select
    t.compte_id,
    t.mois,
    t.total_credits,
    t.total_debits,
    t.solde_net_mois,
    -- Solde cumulé = solde_initial + somme cumulée des montant_signe
    c.solde_initial + SUM(t.solde_net_mois) OVER (
        PARTITION BY t.compte_id 
        ORDER BY t.mois
    ) AS solde_cumule
from transactions_mensuelles t
join comptes c ON t.compte_id = c.compte_id
order by 
    t.compte_id,
    t.mois
    )

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.fintrack_analytics.mart_solde_mensuel", "profile_name": "fintrack_analytics", "target_name": "prod"} */;
-- created_at: 2026-09-09T10:20:50.457518646+00:00
-- finished_at: 2026-09-09T10:20:51.818049049+00:00
-- elapsed: 1.4s
-- outcome: success
-- dialect: snowflake
-- node_id: model.fintrack_analytics.mart_budget_vs_reel
-- query_id: 01c6f40c-0002-1509-0002-b68a0025cb0a
-- desc: execute adapter call
create or replace transient  table FINTRACK_DB.MARTS.mart_budget_vs_reel
    
    
    
    
    as (with comptes_budgets_lisses as (
    select 
        b.compte_id as compte_id,
        c.nom_client as nom_client,
        b.categorie_id as categorie_id,
        b.mois as mois,
        SUM(b.montant_prevu) as montant_prevu
    from FINTRACK_DB.STAGING.stg_budgets b
    join FINTRACK_DB.STAGING.stg_comptes c on c.compte_id = b.compte_id
    group by b.compte_id, b.mois, b.categorie_id, c.nom_client
),
debit_mois as (
    select 
        t.compte_id as compte_id,
        t.mois_transaction as mois_transaction,
        SUM(t.montant) as montant_reel,
        c.categorie_id as categorie_id,
        c.nom_categorie as nom_categorie
    from FINTRACK_DB.MARTS.fct_transactions t
    join FINTRACK_DB.STAGING.stg_categories c on t.categorie_id = c.categorie_id 
    where t.type_operation = 'debit'
    group by mois_transaction, t.compte_id, c.categorie_id, c.nom_categorie
)

---------------
select 
    cb.compte_id,
    cb.categorie_id,
    dm.nom_categorie,
    cb.mois,
    sum(dm.montant_reel) as montant_reel,
    avg(cb.montant_prevu) as montant_prevu,
    avg(cb.montant_prevu) - sum(dm.montant_reel) as ecart,
    sum(dm.montant_reel) > avg(cb.montant_prevu) as depassement
from debit_mois dm
full outer join comptes_budgets_lisses cb on cb.compte_id = dm.compte_id and cb.mois = dm.mois_transaction and cb.categorie_id = dm.categorie_id
group by cb.mois, cb.compte_id, cb.categorie_id, dm.nom_categorie, dm.mois_transaction
order by
    cb.compte_id,
    cb.mois,
    cb.categorie_id
    )

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.fintrack_analytics.mart_budget_vs_reel", "profile_name": "fintrack_analytics", "target_name": "prod"} */;
