-- ==========================================
-- 06_structural.sql
-- Structural System
-- ==========================================

-- ------------------------------------------
-- MAJOR STRUCTURES (regional scale)
-- ------------------------------------------
CREATE TABLE major_structures (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL
        REFERENCES projects(id)
        ON DELETE CASCADE,

    name TEXT NOT NULL,
    structure_type TEXT,      -- fault, shear zone, intrusive contact
    geometry GEOMETRY(MULTILINESTRINGZ, 4326),

    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_major_structures_geom
ON major_structures
USING GIST (geometry);

-- ------------------------------------------
-- LOCAL STRUCTURES (drillhole scale)
-- ------------------------------------------
CREATE TABLE local_structures (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    drillhole_id UUID NOT NULL
        REFERENCES drillholes(id)
        ON DELETE CASCADE,

    structure_type TEXT,          -- vein, fracture, fault
    interval NUMRANGE NOT NULL,

    description TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_local_structures_interval
ON local_structures
USING GIST (interval);

-- ------------------------------------------
-- STRUCTURAL MEASUREMENTS
-- ------------------------------------------
CREATE TABLE structural_measurements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    local_structure_id UUID
        REFERENCES local_structures(id)
        ON DELETE CASCADE,

    depth NUMERIC NOT NULL,

    strike NUMERIC CHECK (strike >= 0 AND strike <= 360),
    dip NUMERIC CHECK (dip >= 0 AND dip <= 90),

    dip_direction NUMERIC CHECK (dip_direction >= 0 AND dip_direction <= 360),

    measurement_type TEXT,       -- bedding, fault, vein

    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_structural_depth
ON structural_measurements(depth);

