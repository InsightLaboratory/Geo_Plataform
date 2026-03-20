-- =====================================================
-- FIX: Create v_drillhole_locations with all required fields
-- =====================================================

DROP VIEW IF EXISTS v_drillhole_locations CASCADE;

CREATE OR REPLACE VIEW v_drillhole_locations AS
SELECT
    dh.id AS drillhole_id,
    dh.hole_id,
    dh.hole_id AS drillhole_name,
    c.geom,
    dh.total_depth AS max_depth
FROM public.collars c
INNER JOIN public.drillholes dh
    ON dh.id = c.drillhole_id
WHERE dh.status = 'Completed'
ORDER BY dh.hole_id;
