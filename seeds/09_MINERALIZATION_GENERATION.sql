-- =====================================================
-- 09_MINERALIZATION_GENERATION.sql (FIXED)
-- =====================================================

DO $$
DECLARE
    r RECORD;
    v_min_id UUID;
BEGIN

FOR r IN SELECT id, total_depth FROM drillholes LOOP

    -- Zona principal (120–260)
    IF r.total_depth > 120 THEN
        
        SELECT id INTO v_min_id 
        FROM mineralization_types 
        WHERE code = 'STK';

        INSERT INTO mineralization_intervals
        (drillhole_id, interval, mineralization_id)
        VALUES
        (
            r.id,
            numrange(120, LEAST(260, r.total_depth), '[)'),
            v_min_id
        );

    END IF;

    -- Zona secundaria (300–380)
    IF r.total_depth > 300 THEN
        
        SELECT id INTO v_min_id 
        FROM mineralization_types 
        WHERE code = 'DIS';

        INSERT INTO mineralization_intervals
        (drillhole_id, interval, mineralization_id)
        VALUES
        (
            r.id,
            numrange(300, LEAST(380, r.total_depth), '[)'),
            v_min_id
        );

    END IF;

END LOOP;

END $$;
