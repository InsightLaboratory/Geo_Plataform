-- =====================================================
-- 07_LITHOLOGY_GENERATION.sql
-- =====================================================

DO $$
DECLARE
    r RECORD;
    v_start NUMERIC;
    v_end NUMERIC;
    v_lith_id UUID;
BEGIN

FOR r IN SELECT id, total_depth FROM drillholes LOOP

    v_start := 0;

    WHILE v_start < r.total_depth LOOP

        v_end := v_start + 50;

        IF v_end > r.total_depth THEN
            v_end := r.total_depth;
        END IF;

        -- Determinar litología según profundidad media
        IF (v_start + v_end)/2 < 100 THEN
            SELECT id INTO v_lith_id FROM lithologies WHERE code = 'TUF';
        ELSIF (v_start + v_end)/2 < 250 THEN
            SELECT id INTO v_lith_id FROM lithologies WHERE code = 'AND';
        ELSIF (v_start + v_end)/2 < 400 THEN
            SELECT id INTO v_lith_id FROM lithologies WHERE code = 'BRX';
        ELSE
            SELECT id INTO v_lith_id FROM lithologies WHERE code = 'DIO';
        END IF;

        INSERT INTO lithology_intervals
        (drillhole_id, interval, lithology_id)
        VALUES
        (
            r.id,
            numrange(v_start, v_end, '[)'),
            v_lith_id
        );

        v_start := v_end;

    END LOOP;

END LOOP;

END $$;
