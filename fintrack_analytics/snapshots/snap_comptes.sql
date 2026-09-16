{% snapshot snap_comptes %}

{{
    config(
      target_schema='snapshots',
      unique_key='id',
      strategy='check',
      check_cols=['statut', 'email', 'type_compte']
    )
}}

SELECT * FROM {{ source('raw', 'raw_comptes') }}

{% endsnapshot %}