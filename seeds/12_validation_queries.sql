-- =====================================================
-- 12_VALIDATION_QUERIES.sql
-- Geological model validation
-- =====================================================


--------------------------------------------------------
-- 1. Drillhole overview
--------------------------------------------------------

SELECT
    COUNT(*) AS n_drillholes,
    ROUND(AVG(total_depth)::numeric,2) AS avg_depth,
    MIN(total_depth) AS min_depth,
    MAX(total_depth) AS max_depth
FROM drillholes;


--------------------------------------------------------
-- 2. Samples generated
--------------------------------------------------------

SELECT
    COUNT(*) AS total_samples,
    ROUND(AVG(upper(interval)-lower(interval))::numeric,2) AS avg_sample_length
FROM samples;


--------------------------------------------------------
-- 3. Assay coverage
--------------------------------------------------------

SELECT
    e.symbol,
    COUNT(*) AS assays
FROM assay_results ar
JOIN elements e
    ON e.id = ar.element_id
GROUP BY e.symbol
ORDER BY assays DESC;


--------------------------------------------------------
-- 4. Lithology distribution
--------------------------------------------------------

SELECT
    l.code,
    COUNT(*) AS intervals
FROM lithology_intervals li
JOIN lithologies l
    ON l.id = li.lithology_id
GROUP BY l.code
ORDER BY intervals DESC;


--------------------------------------------------------
-- 5. Alteration distribution
--------------------------------------------------------

SELECT
    a.code,
    COUNT(*) AS intervals
FROM alteration_events ae
JOIN alteration_types a
    ON a.id = ae.alteration_id
GROUP BY a.code
ORDER BY intervals DESC;


--------------------------------------------------------
-- 6. Mineralization distribution
--------------------------------------------------------

SELECT
    mt.code,
    COUNT(*) AS intervals
FROM mineralization_intervals mi
JOIN mineralization_types mt
    ON mt.id = mi.mineralization_id
GROUP BY mt.code;


--------------------------------------------------------
-- 7. Domain assignments
--------------------------------------------------------

SELECT
    gd.name AS domain,
    COUNT(*) AS intervals
FROM domain_assignments da
JOIN geological_domains gd
    ON gd.id = da.domain_id
GROUP BY gd.name
ORDER BY intervals DESC;


--------------------------------------------------------
-- 8. Gold grade by domain
--------------------------------------------------------

SELECT 
    gd.name AS domain,
    ROUND(AVG(ar.value)::numeric,3) AS avg_au,
    MIN(ar.value) AS min_au,
    MAX(ar.value) AS max_au,
    COUNT(*) AS n_samples
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


--------------------------------------------------------
-- 9. Check sample overlap integrity
--------------------------------------------------------

SELECT drillhole_id, COUNT(*)
FROM samples
GROUP BY drillhole_id;


--------------------------------------------------------
-- 10. Structural measurements check
--------------------------------------------------------

SELECT COUNT(*) AS structural_measurements
FROM structural_measurements;


--ley de oro

SELECT 
    gd.name,
    ROUND(AVG(ar.value)::numeric,3) AS avg_au,
    COUNT(*) AS samples
FROM assay_results ar
JOIN samples s ON s.id = ar.sample_id
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