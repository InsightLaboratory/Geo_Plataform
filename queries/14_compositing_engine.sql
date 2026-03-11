-- =====================================================
-- STEP 15 — Downhole compositing engine
-- =====================================================

CREATE OR REPLACE VIEW v_downhole_composites AS

WITH base AS (

SELECT

    drillhole_name,

    from_m,
    to_m,

    au_grade,

    lithology,
    alteration,
    mineralization,
    domain

FROM v_exploration_dataset

),

composites AS (

SELECT

    drillhole_name,

    floor(from_m / 5) * 5 AS composite_from,
    floor(from_m / 5) * 5 + 5 AS composite_to,

    AVG(au_grade) AS au_composite,

    COUNT(*) AS n_samples

FROM base

GROUP BY
drillhole_name,
floor(from_m / 5)

)

SELECT
*
FROM composites
ORDER BY drillhole_name, composite_from;