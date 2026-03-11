-- =====================================================
-- STEP 16 — High grade intersection detection
-- =====================================================

CREATE OR REPLACE VIEW v_high_grade_intersections AS

SELECT

    drillhole_name,

    from_m,
    to_m,

    (to_m - from_m) AS thickness,

    au_grade,

    lithology,
    alteration,
    mineralization,
    domain

FROM v_exploration_dataset

WHERE

    au_grade >= 1.0
    AND (to_m - from_m) >= 2

ORDER BY

    au_grade DESC;