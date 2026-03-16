-- =====================================================
-- 08_ALTERATION_GENERATION.sql (FIXED)
-- =====================================================

DO $$
DECLARE
    r RECORD;
    v_start NUMERIC;
    v_end NUMERIC;
    v_alt_id UUID;
BEGIN

FOR r IN SELECT id, total_depth FROM drillholes LOOP

    v_start := 0;

    WHILE v_start < r.total_depth LOOP

        v_end := v_start + 50;

        IF v_end > r.total_depth THEN
            v_end := r.total_depth;
        END IF;

        -- Determinar alteración según profundidad media
        IF (v_start + v_end)/2 < 120 THEN
            SELECT id INTO v_alt_id FROM alteration_types WHERE code = 'ARG';
        ELSIF (v_start + v_end)/2 < 280 THEN
            SELECT id INTO v_alt_id FROM alteration_types WHERE code = 'PHY';
        ELSIF (v_start + v_end)/2 < 450 THEN
            SELECT id INTO v_alt_id FROM alteration_types WHERE code = 'POT';
        ELSE
            SELECT id INTO v_alt_id FROM alteration_types WHERE code = 'PRO';
        END IF;

        INSERT INTO alteration_events
        (drillhole_id, interval, alteration_id, intensity)
        VALUES
        (
            r.id,
            numrange(v_start, v_end, '[)'),
            v_alt_id,
            random() * 5  -- intensidad 0–5
        );

        v_start := v_end;

    END LOOP;

END LOOP;

END $$;
