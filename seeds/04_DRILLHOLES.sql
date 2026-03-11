-- =====================================================
-- 04_DRILLHOLES.sql
-- =====================================================

SELECT setseed(0.42);

DO $$
DECLARE
    v_project_id UUID;
    v_drillhole_id UUID;

    v_center_lat NUMERIC := -31.5355;
    v_center_lon NUMERIC := -68.5364;
    v_num_drillholes INT := 4;

    v_i INT;
    v_random_lat NUMERIC;
    v_random_lon NUMERIC;
    v_depth NUMERIC;
BEGIN

    SELECT id INTO v_project_id
    FROM projects
    ORDER BY created_at DESC
    LIMIT 1;

    FOR v_i IN 1..v_num_drillholes LOOP

        v_random_lat := v_center_lat + (random() - 0.5) * 0.01;
        v_random_lon := v_center_lon + (random() - 0.5) * 0.01;
        v_depth := 400 + (random() * 300);

        INSERT INTO drillholes (
            project_id,
            hole_id,
            drilling_type,
            status,
            total_depth
        )
        VALUES (
            v_project_id,
            'DH-' || v_i,
            'Diamond',
            'Completed',
            v_depth
        )
        RETURNING id INTO v_drillhole_id;

        INSERT INTO collars (drillhole_id, geom)
        VALUES (
            v_drillhole_id,
            ST_SetSRID(ST_MakePoint(v_random_lon, v_random_lat, 0),4326)
        );

        INSERT INTO surveys (drillhole_id, depth, azimuth, dip)
        VALUES (v_drillhole_id,0,0,-60);

    END LOOP;

END $$;
