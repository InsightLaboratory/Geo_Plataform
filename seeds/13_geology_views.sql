-- =====================================================
-- 13A — Geological sample view
-- =====================================================

CREATE OR REPLACE VIEW v_sample_geology AS
SELECT

    s.id AS sample_id,
    s.drillhole_id,
    s.interval,

    dh.hole_id AS drillhole_name,

    l.code AS lithology,
    a.code AS alteration,
    mt.code AS mineralization,

    gd.name AS domain,

    ar.value AS au_grade

FROM samples s

JOIN drillholes dh
ON dh.id = s.drillhole_id

LEFT JOIN lithology_intervals li
ON li.drillhole_id = s.drillhole_id
AND s.interval && li.interval

LEFT JOIN lithologies l
ON l.id = li.lithology_id

LEFT JOIN alteration_events ae
ON ae.drillhole_id = s.drillhole_id
AND s.interval && ae.interval

LEFT JOIN alteration_types a
ON a.id = ae.alteration_id

LEFT JOIN mineralization_intervals mi
ON mi.drillhole_id = s.drillhole_id
AND s.interval && mi.interval

LEFT JOIN mineralization_types mt
ON mt.id = mi.mineralization_id

LEFT JOIN domain_assignments da
ON da.drillhole_id = s.drillhole_id
AND s.interval && da.interval

LEFT JOIN geological_domains gd
ON gd.id = da.domain_id

LEFT JOIN assay_results ar
ON ar.sample_id = s.id
AND ar.element_id = (
    SELECT id FROM elements WHERE symbol = 'Au'
);
--13 B vista de resumen por sondaje 
CREATE OR REPLACE VIEW v_drillhole_summary AS
SELECT

    dh.id,
    dh.hole_id,

    dh.total_depth,

    COUNT(s.id) AS n_samples,

    ROUND(AVG(ar.value)::numeric,3) AS avg_au,

    MAX(ar.value) AS max_au

FROM drillholes dh

LEFT JOIN samples s
ON s.drillhole_id = dh.id

LEFT JOIN assay_results ar
ON ar.sample_id = s.id
AND ar.element_id = (
    SELECT id FROM elements WHERE symbol='Au'
)

GROUP BY dh.id;

--13_c estadistica por domimio 
CREATE OR REPLACE VIEW v_domain_statistics AS
SELECT

    gd.name AS domain,

    COUNT(*) AS samples,

    ROUND(AVG(ar.value)::numeric,3) AS avg_au,

    MIN(ar.value) AS min_au,
    MAX(ar.value) AS max_au

FROM assay_results ar

JOIN samples s
ON s.id = ar.sample_id

JOIN domain_assignments da
ON da.drillhole_id = s.drillhole_id
AND s.interval && da.interval

JOIN geological_domains gd
ON gd.id = da.domain_id

WHERE ar.element_id = (
    SELECT id FROM elements WHERE symbol='Au'
)

GROUP BY gd.name
ORDER BY avg_au DESC;