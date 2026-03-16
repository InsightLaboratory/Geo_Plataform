-- =====================================================
-- 10_AU_CONTROLLED_BY_MINERALIZATION.sql
-- =====================================================

-- Primero bajamos todo Au fuera de mineralización

UPDATE assay_results ar
SET value = 0.01 + random() * 0.19
FROM samples s
WHERE ar.sample_id = s.id
AND ar.element_id = (SELECT id FROM elements WHERE symbol = 'Au')
AND NOT EXISTS (
    SELECT 1
    FROM mineralization_intervals m
    WHERE m.drillhole_id = s.drillhole_id
    AND s.interval && m.interval
);

-- Ahora zona STK (alta ley)

UPDATE assay_results ar
SET value = 1 + random() * 4
FROM samples s
JOIN mineralization_intervals m
    ON m.drillhole_id = s.drillhole_id
    AND s.interval && m.interval
JOIN mineralization_types mt
    ON mt.id = m.mineralization_id
WHERE ar.sample_id = s.id
AND ar.element_id = (SELECT id FROM elements WHERE symbol = 'Au')
AND mt.code = 'STK';

-- Zona DIS (media ley)

UPDATE assay_results ar
SET value = 0.3 + random() * 0.9
FROM samples s
JOIN mineralization_intervals m
    ON m.drillhole_id = s.drillhole_id
    AND s.interval && m.interval
JOIN mineralization_types mt
    ON mt.id = m.mineralization_id
WHERE ar.sample_id = s.id
AND ar.element_id = (SELECT id FROM elements WHERE symbol = 'Au')
AND mt.code = 'DIS';
