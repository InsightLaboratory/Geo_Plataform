-- =====================================================
-- STEP 18 — Machine learning dataset
-- =====================================================

CREATE OR REPLACE VIEW v_ml_dataset AS

SELECT

    drillhole_name,

    from_m,
    to_m,

    (from_m + to_m)/2 AS mid_depth,

    lithology,
    alteration,
    mineralization,
    domain,

    au_grade

FROM v_exploration_dataset

WHERE au_grade IS NOT NULL;