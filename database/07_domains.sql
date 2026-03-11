-- ==========================================
-- 07_domains.sql
-- Geological Domains Layer
-- ==========================================

-- ------------------------------------------
-- DOMAIN TYPES
-- ------------------------------------------
CREATE TABLE domain_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,   -- lithological, structural, mineralized, metallurgical
    description TEXT
);

-- ------------------------------------------
-- GEOLOGICAL DOMAINS
-- ------------------------------------------
CREATE TABLE geological_domains (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    project_id UUID NOT NULL
        REFERENCES projects(id)
        ON DELETE CASCADE,

    domain_type_id UUID NOT NULL
        REFERENCES domain_types(id),

    name TEXT NOT NULL,
    description TEXT,

    geometry GEOMETRY(MULTIPOLYGONZ, 4326),

    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_domains_geom
ON geological_domains
USING GIST (geometry);

-- ------------------------------------------
-- DOMAIN ASSIGNMENT TO INTERVALS
-- ------------------------------------------
CREATE TABLE domain_assignments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    domain_id UUID NOT NULL
        REFERENCES geological_domains(id)
        ON DELETE CASCADE,

    drillhole_id UUID NOT NULL
        REFERENCES drillholes(id)
        ON DELETE CASCADE,

    interval NUMRANGE NOT NULL,

    confidence TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_domain_assignment_interval
ON domain_assignments
USING GIST (interval);