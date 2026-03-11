-- =====================================================
-- STEP 17 — Exploration dashboard
-- =====================================================

CREATE OR REPLACE VIEW v_project_dashboard AS

SELECT

    COUNT(DISTINCT drillhole_name) AS drillholes,

    SUM(to_m - from_m) AS total_sampled_meters,

    COUNT(*) AS total_samples,

    ROUND(AVG(au_grade)::numeric,3) AS avg_au,

    MAX(au_grade) AS max_au

FROM v_exploration_dataset;