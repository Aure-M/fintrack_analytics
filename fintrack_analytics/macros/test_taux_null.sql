{% test test_taux_null(model, column_name, seuil_pct) %}

WITH calcul_taux AS (
    SELECT
        (COUNT(CASE WHEN {{ column_name }} IS NULL THEN 1 END) * 100.0) / NULLIF(COUNT(*), 0) AS pct_null
    FROM {{ model }}
)

SELECT
    pct_null
FROM calcul_taux
WHERE pct_null > {{ seuil_pct }}

{% endtest %}