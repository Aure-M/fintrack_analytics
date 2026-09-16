{% macro log_dbt_run(results) %}
    {% if execute %}
        -- 1. Récupération des métadonnées
        {% set run_id = invocation_id %}
        {% set nb_models = results | length %}
        
        -- Utilisation d'un namespace pour accumuler dans la boucle
        {% set ns = namespace(errors=0, total_duration=0) %}
        
        {% for res in results %}
            {% if res.status in ['error', 'fail'] %}
                {% set ns.errors = ns.errors + 1 %}
            {% endif %}
            
            {% if res.execution_time is not none %}
                {% set ns.total_duration = ns.total_duration + res.execution_time %}
            {% endif %}
        {% endfor %}
        
        {% set status = 'ERROR' if ns.errors > 0 else 'SUCCESS' %}
        {% set duration_sec = ns.total_duration | round(2) %}

        -- 2. Requête d'insertion
        {% set insert_query %}
            INSERT INTO {{ target.database }}.marts.dbt_run_log (
                run_id,
                started_at,
                completed_at,
                status,
                nb_models
            )
            VALUES (
                '{{ run_id }}',
                DATEADD(second, -{{ duration_sec }}, CURRENT_TIMESTAMP()),
                CURRENT_TIMESTAMP(),
                '{{ status }}',
                {{ nb_models }}
            );
        {% endset %}

        {% do run_query(insert_query) %}
        {% do log("Hook on-run-end : exécution enregistrée avec le run_id " ~ run_id, info=True) %}
    {% endif %}
{% endmacro %}