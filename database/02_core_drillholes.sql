-- ==========================================
-- 02_core_drillholes.sql
-- Physical drillhole core model
-- ==========================================

CREATE TABLE drillholes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    project_id UUID NOT NULL
        REFERENCES projects(id)
        ON DELETE CASCADE,

    hole_id TEXT NOT NULL,
    drilling_type TEXT,
    status TEXT,

    start_date DATE,
    end_date DATE,

    total_depth NUMERIC CHECK (total_depth > 0),

    created_at TIMESTAMP DEFAULT NOW(),

    UNIQUE (project_id, hole_id)
);

CREATE TABLE collars (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    drillhole_id UUID NOT NULL UNIQUE
        REFERENCES drillholes(id)
        ON DELETE CASCADE,

    geom GEOMETRY(POINTZ, 4326) NOT NULL,

    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_collars_geom
ON collars
USING GIST (geom);

CREATE TABLE surveys (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    drillhole_id UUID NOT NULL
        REFERENCES drillholes(id)
        ON DELETE CASCADE,

    depth NUMERIC NOT NULL CHECK (depth >= 0),
    azimuth NUMERIC CHECK (azimuth BETWEEN 0 AND 360),
    dip NUMERIC CHECK (dip BETWEEN -90 AND 90),

    created_at TIMESTAMP DEFAULT NOW(),

    UNIQUE (drillhole_id, depth)
);