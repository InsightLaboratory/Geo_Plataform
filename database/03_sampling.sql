-- ==========================================
-- 03_sampling.sql
-- Physical sampling intervals
-- ==========================================

CREATE TABLE samples (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    drillhole_id UUID NOT NULL
        REFERENCES drillholes(id)
        ON DELETE CASCADE,

    interval numrange NOT NULL,

    domain_id UUID, -- se conecta en modulo 07

    created_at TIMESTAMP DEFAULT NOW(),

    CHECK (lower(interval) >= 0),
    CHECK (upper(interval) > lower(interval))
);

-- Prevent overlapping physical samples per drillhole
ALTER TABLE samples
ADD CONSTRAINT exclude_sample_overlap
EXCLUDE USING GIST (
    drillhole_id WITH =,
    interval WITH &&
);