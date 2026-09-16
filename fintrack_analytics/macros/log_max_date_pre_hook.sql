{% macro log_max_date_pre_hook() %}
    -- On vérifie qu'on est en phase d'exécution et que le run est incrémental
    {% if execute and is_incremental() %}
        
        -- Requête pour récupérer la date maximale déjà présente dans la table
        {% set query %}
            SELECT MAX(date_transaction) FROM {{ this }}
        {% endset %}
        
        {% set results = run_query(query) %}
        
        {% if results and results.rows %}
            {% set max_date = results.columns[0][0] %}
            
            -- Message dans la console dbt
            {% do log(">>> [PRE-HOOK INCRÉMENTAL] Dernier max(date_transaction) traité : " ~ max_date, info=True) %}
        {% endif %}

    {% endif %}
{% endmacro %}