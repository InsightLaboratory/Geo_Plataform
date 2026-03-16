-- =====================================================
-- 03_COMPANY_PROJECT.sql
-- =====================================================

INSERT INTO companies (name)
VALUES ('Demo Exploration Co');

INSERT INTO projects (company_id, name, location, crs)
VALUES (
    (SELECT id FROM companies ORDER BY created_at DESC LIMIT 1),
    'Andean Synthetic Project',
    'San Juan - Argentina',
    4326
);
