-- =====================================================
-- STEP 19 — Spatial drillhole locations
-- =====================================================

CREATE OR REPLACE VIEW v_drillhole_locations AS

SELECT

    dh.hole_id AS drillhole_name,

    c.geom

FROM collars c

JOIN drillholes dh
ON dh.id = c.drillhole_id;