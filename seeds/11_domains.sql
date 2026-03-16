-- =====================================================
-- 11_DOMAINS.sql
-- Domain modeling + automatic assignment
-- =====================================================

--------------------------------------------------------
-- 11A — DOMAIN TYPES (idempotente)
--------------------------------------------------------

INSERT INTO domain_types (name, description)
VALUES
('LITHOLOGY', 'Dominio basado en litologia'),
('ALTERATION', 'Dominio basado en alteracion'),
('MINERALIZATION', 'Dominio basado en mineralizacion'),
('COMBINED', 'Dominio geologico combinado para estimacion')
ON CONFLICT (name) DO NOTHING;


--------------------------------------------------------
-- 11B — CREAR DOMINIOS
--------------------------------------------------------

DO $$
DECLARE
    v_project_id UUID;
    v_domain_type_id UUID;
BEGIN

SELECT id INTO v_project_id
FROM projects
ORDER BY created_at DESC
LIMIT 1;

SELECT id INTO v_domain_type_id
FROM domain_types
WHERE name = 'COMBINED';

INSERT INTO geological_domains
(project_id, domain_type_id, name, description)
VALUES
(v_project_id, v_domain_type_id, 'DOM_STK', 'Dominio stockwork alta ley'),
(v_project_id, v_domain_type_id, 'DOM_DIS', 'Dominio diseminado'),
(v_project_id, v_domain_type_id, 'DOM_BG', 'Dominio background');

END $$;


--------------------------------------------------------
-- 11C — DOMAIN ASSIGNMENTS AUTOMÁTICOS
--------------------------------------------------------

DO $$
DECLARE
    v_dom_stk UUID;
    v_dom_dis UUID;
    v_dom_bg UUID;
BEGIN

-- Obtener IDs dinámicos de dominios

SELECT id INTO v_dom_stk
FROM geological_domains
WHERE name = 'DOM_STK';

SELECT id INTO v_dom_dis
FROM geological_domains
WHERE name = 'DOM_DIS';

SELECT id INTO v_dom_bg
FROM geological_domains
WHERE name = 'DOM_BG';


--------------------------------------------------------
-- STK DOMAINS
--------------------------------------------------------

INSERT INTO domain_assignments
(domain_id, drillhole_id, interval, confidence)

SELECT
    v_dom_stk,
    m.drillhole_id,
    m.interval,
    0.9
FROM mineralization_intervals m
JOIN mineralization_types mt
    ON mt.id = m.mineralization_id
WHERE mt.code = 'STK';


--------------------------------------------------------
-- DIS DOMAINS
--------------------------------------------------------

INSERT INTO domain_assignments
(domain_id, drillhole_id, interval, confidence)

SELECT
    v_dom_dis,
    m.drillhole_id,
    m.interval,
    0.85
FROM mineralization_intervals m
JOIN mineralization_types mt
    ON mt.id = m.mineralization_id
WHERE mt.code = 'DIS';


--------------------------------------------------------
-- BACKGROUND DOMAINS
--------------------------------------------------------

INSERT INTO domain_assignments
(domain_id, drillhole_id, interval, confidence)

SELECT DISTINCT
    v_dom_bg,
    s.drillhole_id,
    s.interval,
    0.6
FROM samples s
WHERE NOT EXISTS (
    SELECT 1
    FROM mineralization_intervals m
    WHERE m.drillhole_id = s.drillhole_id
    AND s.interval && m.interval
);

END $$;