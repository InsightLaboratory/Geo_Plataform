-- ==========================================
-- 04_geochemistry.sql
-- Analytical data + QA/QC framework
-- ==========================================

-- -----------------------------
-- ELEMENTS (normalización)
-- -----------------------------
CREATE TABLE elements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    symbol TEXT NOT NULL UNIQUE,         -- Au, Ag, Cu
    name TEXT NOT NULL,
    default_unit TEXT NOT NULL           -- ppm, ppb, %
);

-- -----------------------------
-- LABORATORIES
-- -----------------------------
CREATE TABLE laboratories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    accreditation TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- ASSAY METHODS
-- -----------------------------
CREATE TABLE assay_methods (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code TEXT NOT NULL UNIQUE,           -- FA50, ICP-MS
    description TEXT,
    detection_limit NUMERIC,
    unit TEXT
);

-- -----------------------------
-- QA/QC TYPES
-- -----------------------------
CREATE TABLE qaqc_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE            -- Standard, Blank, Duplicate
);

-- -----------------------------
-- SAMPLES UPDATE (QA/QC flag)
-- -----------------------------
ALTER TABLE samples
ADD COLUMN sample_type TEXT DEFAULT 'PRIMARY';

-- PRIMARY | STANDARD | BLANK | DUPLICATE

-- -----------------------------
-- ASSAY RESULTS
-- -----------------------------
CREATE TABLE assay_results (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    sample_id UUID NOT NULL
        REFERENCES samples(id)
        ON DELETE CASCADE,

    element_id UUID NOT NULL
        REFERENCES elements(id)
        ON DELETE CASCADE,

    method_id UUID
        REFERENCES assay_methods(id),

    laboratory_id UUID
        REFERENCES laboratories(id),

    value NUMERIC NOT NULL,
    unit TEXT NOT NULL,

    is_below_detection BOOLEAN DEFAULT FALSE,

    created_at TIMESTAMP DEFAULT NOW(),

    UNIQUE (sample_id, element_id, method_id)
);

-- -----------------------------
-- DENSITY (separado del assay)
-- -----------------------------
CREATE TABLE density_measurements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    sample_id UUID NOT NULL UNIQUE
        REFERENCES samples(id)
        ON DELETE CASCADE,

    density NUMERIC NOT NULL CHECK (density > 0),

    method TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------
-- INDEXES
-- -----------------------------
CREATE INDEX idx_assay_sample
ON assay_results(sample_id);

CREATE INDEX idx_assay_element
ON assay_results(element_id);