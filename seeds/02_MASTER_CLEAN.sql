-- =====================================================
-- 02_MASTER_CLEAN.sql
-- =====================================================

BEGIN;

DELETE FROM assay_results;
DELETE FROM density_measurements;

DELETE FROM domain_assignments;
DELETE FROM geological_domains;

DELETE FROM structural_measurements;
DELETE FROM local_structures;
DELETE FROM major_structures;

DELETE FROM mineralization_intervals;
DELETE FROM alteration_events;
DELETE FROM lithology_intervals;

DELETE FROM samples;
DELETE FROM surveys;
DELETE FROM collars;
DELETE FROM drillholes;

DELETE FROM projects;
DELETE FROM company_users;
DELETE FROM users;
DELETE FROM companies;

COMMIT;