-- =============================================================
-- GEO-PLATFORM EXPLORATION DATABASE
-- Master Setup Script (Corregido)
-- =============================================================

-- 0. EXTENSIONS
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS btree_gist;

-- 1. MULTITENANT SCHEMA
DROP TABLE IF EXISTS company_users CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS companies CASCADE;

\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/database/01_Multitenant.sql'

-- 2. CORE DRILLHOLES
DROP TABLE IF EXISTS surveys CASCADE;
DROP TABLE IF EXISTS collars CASCADE;
DROP TABLE IF EXISTS drillholes CASCADE;

\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/database/02_core_drillholes.sql'

-- 3. SAMPLING
DROP TABLE IF EXISTS exclude_sample_overlap CASCADE;
DROP TABLE IF EXISTS samples CASCADE;

\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/database/03_sampling.sql'

-- 4. GEOCHEMISTRY
DROP TABLE IF EXISTS assay_results CASCADE;
DROP TABLE IF EXISTS density_measurements CASCADE;
DROP TABLE IF EXISTS qaqc_types CASCADE;
DROP TABLE IF EXISTS assay_methods CASCADE;
DROP TABLE IF EXISTS laboratories CASCADE;
DROP TABLE IF EXISTS elements CASCADE;

\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/database/04_geochemistry.sql'

-- 5. GEOLOGY
DROP TABLE IF EXISTS mineralization_intervals CASCADE;
DROP TABLE IF EXISTS mineralization_types CASCADE;
DROP TABLE IF EXISTS alteration_events CASCADE;
DROP TABLE IF EXISTS alteration_types CASCADE;
DROP TABLE IF EXISTS lithology_intervals CASCADE;
DROP TABLE IF EXISTS lithologies CASCADE;

\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/database/05_geology.sql'

-- 6. STRUCTURAL
DROP TABLE IF EXISTS structural_measurements CASCADE;
DROP TABLE IF EXISTS local_structures CASCADE;

\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/database/06_structural.sql'

-- 7. GEOLOGICAL DOMAINS
DROP TABLE IF EXISTS domain_assignments CASCADE;
DROP TABLE IF EXISTS geological_domains CASCADE;
DROP TABLE IF EXISTS domain_types CASCADE;

\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/database/07_domains.sql'

-- 8. INDEXES (comentado, no existe)
-- \i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/database/99_indexes.sql'

-- 9. SEEDS / DATA GENERATION PIPELINE
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/01_reference_data.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/02_MASTER_CLEAN.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/03_COMPANY_PROJECT.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/04_DRILLHOLES.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/05_SAMPLES.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/06_ASSAYS.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/07_LITHOLOGY_GENERATION.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/08_ALTERATION_GENERATION.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/09_MINERALIZATION_GENERATION.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/10_AU_CONTROLLED_BY_MINERALIZATION.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/11_domains.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/12_validation_queries.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/seeds/13_geology_views.sql'

\echo '✅ GEO-PLATFORM database setup completed!'

-- 10. ANALYTICS / EXPLORATION ENGINE

\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/queries/14_compositing_engine.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/queries/15_intersection_engine.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/queries/16_exploration_dashboard.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/queries/17_ml_dataset.sql'
\i '/mnt/a/ARQUITECTURA DE SOFTWARE/Geo-plataform/queries/18_spatial_drillholes.sql'

\echo '🚀 EXPLORATION ANALYTICS ENGINE LOADED!'