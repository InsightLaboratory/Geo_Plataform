-- =====================================================
-- 05_SAMPLES.sql
-- =====================================================

DO $$
DECLARE
    r RECORD;
    start_depth NUMERIC;
    end_depth NUMERIC;
BEGIN

FOR r IN SELECT id,total_depth FROM drillholes LOOP

    start_depth := 0;

    WHILE start_depth < r.total_depth LOOP

        end_depth := start_depth + 2;

        IF end_depth > r.total_depth THEN
            end_depth := r.total_depth;
        END IF;

        INSERT INTO samples (drillhole_id, interval, sample_type)
        VALUES (
            r.id,
            numrange(start_depth,end_depth,'[)'),
            'PRIMARY'
        );

        start_depth := end_depth;

    END LOOP;

END LOOP;

END $$;
