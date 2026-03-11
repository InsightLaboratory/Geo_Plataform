-- =====================================================
-- 06_ASSAYS.sql
-- =====================================================

DO $$
DECLARE
    r RECORD;
    v_mid NUMERIC;
    v_au NUMERIC;
    v_cu NUMERIC;

    v_au_id UUID;
    v_cu_id UUID;
    v_method_id UUID;
    v_lab_id UUID;
BEGIN

SELECT id INTO v_au_id FROM elements WHERE symbol='Au';
SELECT id INTO v_cu_id FROM elements WHERE symbol='Cu';
SELECT id INTO v_method_id FROM assay_methods WHERE code='FA_AAS';
SELECT id INTO v_lab_id FROM laboratories WHERE name='ALS Mendoza';

FOR r IN
    SELECT id,
           (lower(interval)+upper(interval))/2 AS mid_depth
    FROM samples
LOOP

    v_mid := r.mid_depth;

    v_au :=
        CASE
            WHEN v_mid BETWEEN 80 AND 180 THEN random()*5 + 2
            WHEN v_mid < 80 THEN random()*1.5
            ELSE random()*0.5
        END;

    v_cu :=
        CASE
            WHEN v_mid > 250 THEN random()*2 + 1
            ELSE random()*0.3
        END;

    INSERT INTO assay_results
    (sample_id, element_id, method_id, laboratory_id, value, unit)
    VALUES
    (r.id, v_au_id, v_method_id, v_lab_id, v_au, 'ppb');

    INSERT INTO assay_results
    (sample_id, element_id, method_id, laboratory_id, value, unit)
    VALUES
    (r.id, v_cu_id, v_method_id, v_lab_id, v_cu, '%');

END LOOP;

END $$;
