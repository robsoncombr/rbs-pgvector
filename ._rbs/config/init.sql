-- Enable the pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Enable PostGIS and related extensions
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;
CREATE EXTENSION IF NOT EXISTS postgis_raster;
CREATE EXTENSION IF NOT EXISTS hstore;

-- Enable pgRouting
CREATE EXTENSION IF NOT EXISTS pgrouting;

-- Optional: Create a table to test pgvector
CREATE TABLE IF NOT EXISTS document_embeddings (
    id SERIAL PRIMARY KEY,
    content TEXT,
    embedding VECTOR(1536) -- Ensure it matches the expected dimension
);

-- Optional: Create a table to test PostGIS
CREATE TABLE IF NOT EXISTS locations (
    id SERIAL PRIMARY KEY,
    name TEXT,
    geom GEOMETRY(Point, 4326) -- Store latitude/longitude as a point
);

-- Optional: Insert sample data for testing pgvector
-- Ensure the array has exactly 1536 dimensions
INSERT INTO document_embeddings (content, embedding)
VALUES 
    ('Sample text 1', ARRAY_FILL(0.1, ARRAY[1536])::VECTOR(1536)), -- Fill with 1536 dimensions
    ('Sample text 2', ARRAY_FILL(0.2, ARRAY[1536])::VECTOR(1536)); -- Fill with 1536 dimensions

-- Optional: Insert sample data for testing PostGIS
INSERT INTO locations (name, geom)
VALUES 
    ('São Paulo', ST_SetSRID(ST_MakePoint(-46.6333, -23.5505), 4326)), -- São Paulo, Brazil
    ('New York', ST_SetSRID(ST_MakePoint(-74.006, 40.7128), 4326)),    -- New York, USA
    ('London', ST_SetSRID(ST_MakePoint(-0.1278, 51.5074), 4326)),      -- London, UK
    ('Tokyo', ST_SetSRID(ST_MakePoint(139.6917, 35.6895), 4326));      -- Tokyo, Japan

-- Optional: Create indexes for better performance
CREATE INDEX ON document_embeddings USING ivfflat (embedding vector_l2_ops);
CREATE INDEX ON locations USING GIST (geom);

-- Optional: Add a cleanup script to ensure no test data is left behind
DO $$ 
BEGIN
    -- Drop tables if they exist (for cleanup purposes)
    DROP TABLE IF EXISTS document_embeddings;
    DROP TABLE IF EXISTS locations;

    -- Recreate tables to ensure a clean state
    CREATE TABLE IF NOT EXISTS document_embeddings (
        id SERIAL PRIMARY KEY,
        content TEXT,
        embedding VECTOR(1536)
    );

    CREATE TABLE IF NOT EXISTS locations (
        id SERIAL PRIMARY KEY,
        name TEXT,
        geom GEOMETRY(Point, 4326)
    );

    -- Re-insert sample data for testing
    INSERT INTO document_embeddings (content, embedding)
    VALUES 
        ('Sample text 1', ARRAY_FILL(0.1, ARRAY[1536])::VECTOR(1536)), -- Fill with 1536 dimensions
        ('Sample text 2', ARRAY_FILL(0.2, ARRAY[1536])::VECTOR(1536)); -- Fill with 1536 dimensions

    INSERT INTO locations (name, geom)
    VALUES 
        ('São Paulo', ST_SetSRID(ST_MakePoint(-46.6333, -23.5505), 4326)), -- São Paulo, Brazil
        ('New York', ST_SetSRID(ST_MakePoint(-74.006, 40.7128), 4326)),    -- New York, USA
        ('London', ST_SetSRID(ST_MakePoint(-0.1278, 51.5074), 4326)),      -- London, UK
        ('Tokyo', ST_SetSRID(ST_MakePoint(139.6917, 35.6895), 4326));      -- Tokyo, Japan

    -- Print a success message
    RAISE NOTICE 'All extensions, tables, and test data have been initialized successfully!';
END $$;
