-- ==========================================
-- 05_geology.sql
-- Geological Interpretation Layer
-- ==========================================

-- ------------------------------------------
-- LITHOLOGY CATALOG (normalización)
-- ------------------------------------------
CREATE TABLE lithologies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code TEXT UNIQUE NOT NULL,      -- DIO, BRX, AND
    name TEXT NOT NULL,
    description TEXT
);

-- ------------------------------------------
-- LITHOLOGY INTERVALS
-- ------------------------------------------
CREATE TABLE lithology_intervals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    drillhole_id UUID NOT NULL
        REFERENCES drillholes(id)
        ON DELETE CASCADE,

    lithology_id UUID NOT NULL
        REFERENCES lithologies(id),

    interval NUMRANGE NOT NULL,

    confidence TEXT,                -- high, medium, low
    interpreted_by TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_lithology_interval
ON lithology_intervals
USING GIST (interval);

-- ------------------------------------------
-- ALTERATION CATALOG
-- ------------------------------------------
CREATE TABLE alteration_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code TEXT UNIQUE NOT NULL,      -- POT, PHY, ARG
    name TEXT NOT NULL,
    description TEXT
);

-- ------------------------------------------
-- ALTERATION EVENTS
-- ------------------------------------------
CREATE TABLE alteration_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    drillhole_id UUID NOT NULL
        REFERENCES drillholes(id)
        ON DELETE CASCADE,

    alteration_id UUID NOT NULL
        REFERENCES alteration_types(id),

    interval NUMRANGE NOT NULL,

    intensity TEXT,                 -- weak, moderate, strong
    overprints BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_alteration_interval
ON alteration_events
USING GIST (interval);

-- ------------------------------------------
-- MINERALIZATION TYPES
-- ------------------------------------------
CREATE TABLE mineralization_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code TEXT UNIQUE NOT NULL,      -- VEIN, DISSEM, STOCK
    name TEXT NOT NULL,
    description TEXT
);

-- ------------------------------------------
-- MINERALIZATION INTERVALS
-- ------------------------------------------
CREATE TABLE mineralization_intervals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    drillhole_id UUID NOT NULL
        REFERENCES drillholes(id)
        ON DELETE CASCADE,

    mineralization_id UUID NOT NULL
        REFERENCES mineralization_types(id),

    interval NUMRANGE NOT NULL,

    style TEXT,
    sulfide_percentage NUMERIC,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_mineralization_interval
ON mineralization_intervals
USING GIST (interval);