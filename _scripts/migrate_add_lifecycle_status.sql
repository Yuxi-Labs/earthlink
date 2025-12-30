-- Migration: Add lifecycle and status columns to agents table
-- Date: 2025-12-31
-- Purpose: Support new agent lifecycle and status tracking architecture

-- Add lifecycle column (default to 'spawned' for existing agents)
ALTER TABLE agents 
ADD COLUMN IF NOT EXISTS lifecycle VARCHAR(50) DEFAULT 'spawned' NOT NULL;

-- Add status column (default to 'idle' for existing agents)
ALTER TABLE agents 
ADD COLUMN IF NOT EXISTS status VARCHAR(50) DEFAULT 'idle' NOT NULL;

-- Make the legacy state column nullable (if not already)
ALTER TABLE agents 
ALTER COLUMN state DROP NOT NULL;

-- Update existing agents to have proper initial values
UPDATE agents 
SET lifecycle = 'spawned', status = 'idle' 
WHERE lifecycle IS NULL OR status IS NULL;

-- Add comments for documentation
COMMENT ON COLUMN agents.lifecycle IS 'Agent developmental stage (10 stages: spawned, oriented, explores, learns, adapts, differentiates, acts, transforms, expires, archived)';
COMMENT ON COLUMN agents.status IS 'Agent operational state (9 states: idle, exploring, learning, interacting, executing, adapting, overloaded, corrupted, retired)';
COMMENT ON COLUMN agents.state IS 'Legacy state field - to be removed after migration validation';
