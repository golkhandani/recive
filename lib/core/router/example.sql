-- Create table for Location
CREATE TABLE location (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Use UUID type and generate a default value
    typename VARCHAR(255),
    venue_title VARCHAR(255),
    area VARCHAR(255),
    city VARCHAR(255),
    country VARCHAR(255),
    postal_code VARCHAR(20),
    region VARCHAR(255),
    localized_address_display TEXT,
    osm_id BIGINT,
    osm_licence TEXT,
    osm_venue_id BIGINT,
    coordinates GEOGRAPHY(POINT, 4326), -- Using geography for coordinates with GIST indexing
    type VARCHAR(50),
    createdAt TIMESTAMPTZ DEFAULT NOW(), -- Timestamp for creation
    updatedAt TIMESTAMPTZ DEFAULT NOW() -- Timestamp for last update
);

-- Create table for Category
CREATE TABLE category (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Use UUID type and generate a default value
    title TEXT NOT NULL,                              -- Title of the category
    subtitle TEXT,                                    -- Subtitle of the category
    description TEXT,                                 -- Description of the category
    image_url TEXT,                                   -- URL of the image associated with the category
    createdAt TIMESTAMPTZ DEFAULT NOW(),              -- Timestamp for creation
    updatedAt TIMESTAMPTZ DEFAULT NOW()               -- Timestamp for last update
);

-- Create table for Tags
CREATE TABLE tag (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Use UUID type and generate a default value
    name TEXT NOT NULL,                             -- Title of the category
    createdAt TIMESTAMPTZ DEFAULT NOW(),            -- Timestamp for creation
    updatedAt TIMESTAMPTZ DEFAULT NOW()             -- Timestamp for last update
);

-- Create table for Source
CREATE TABLE source (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Use UUID type and generate a default value
    copy_right TEXT,
    data_url TEXT,
    name VARCHAR(255),
    createdAt TIMESTAMPTZ DEFAULT NOW(),            -- Timestamp for creation
    updatedAt TIMESTAMPTZ DEFAULT NOW()             -- Timestamp for last update
);

-- Create table for Art
CREATE TABLE art (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Use UUID type and generate a default value
    description TEXT,
    material TEXT[],
    original_id INT,
    original_url TEXT,
    ownership VARCHAR(255),
    comment TEXT,
    title VARCHAR(255),
    source_id UUID,
    location_id UUID,
    createdAt TIMESTAMPTZ DEFAULT NOW(),            -- Timestamp for creation
    updatedAt TIMESTAMPTZ DEFAULT NOW(),            -- Timestamp for last update
    CONSTRAINT fk_source FOREIGN KEY (source_id) REFERENCES source (id),
    CONSTRAINT fk_location FOREIGN KEY (location_id) REFERENCES location (id)
);

-- Create table for Artist
CREATE TABLE artist (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Use UUID type and generate a default value
    typename VARCHAR(255),
    biography TEXT,
    country VARCHAR(255),
    name VARCHAR(255),
    website TEXT,
    original_id INT,
    createdAt TIMESTAMPTZ DEFAULT NOW(),            -- Timestamp for creation
    updatedAt TIMESTAMPTZ DEFAULT NOW()             -- Timestamp for last update
);

-- Create table for Image
CREATE TABLE image (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Use UUID type and generate a default value
    typename VARCHAR(255),
    image_credit TEXT,
    image_data TEXT,
    image_url TEXT,
    createdAt TIMESTAMPTZ DEFAULT NOW(),            -- Timestamp for creation
    updatedAt TIMESTAMPTZ DEFAULT NOW()             -- Timestamp for last update
);

-- Junction table for Art-Category relationship (Many-to-Many)
CREATE TABLE art_category (
    art_id UUID,
    category_id UUID,
    PRIMARY KEY (art_id, category_id),
    CONSTRAINT fk_art FOREIGN KEY (art_id) REFERENCES art (id) ON DELETE CASCADE,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE CASCADE
);

-- Junction table for Art-Tag relationship (Many-to-Many)
CREATE TABLE art_tag (
    art_id UUID,
    tag_id UUID,
    PRIMARY KEY (art_id, tag_id),
    CONSTRAINT fk_art FOREIGN KEY (art_id) REFERENCES art (id) ON DELETE CASCADE,
    CONSTRAINT fk_category FOREIGN KEY (tag_id) REFERENCES tag (id) ON DELETE CASCADE
);

-- Junction table for Art-Artist relationship (Many-to-Many)
CREATE TABLE art_artist (
    art_id UUID,
    artist_id UUID,
    PRIMARY KEY (art_id, artist_id),
    CONSTRAINT fk_art FOREIGN KEY (art_id) REFERENCES art (id) ON DELETE CASCADE,
    CONSTRAINT fk_artist FOREIGN KEY (artist_id) REFERENCES artist (id) ON DELETE CASCADE
);

-- Junction table for Art-Image relationship (One-to-Many)
CREATE TABLE art_image (
    art_id UUID,
    image_id UUID,
    PRIMARY KEY (art_id, image_id),
    CONSTRAINT fk_art FOREIGN KEY (art_id) REFERENCES art (id) ON DELETE CASCADE,
    CONSTRAINT fk_image FOREIGN KEY (image_id) REFERENCES image (id) ON DELETE CASCADE
);

-- Junction table for Category-Image relationship (One-to-Many)
CREATE TABLE category_image (
    category_id UUID,
    image_id UUID,
    PRIMARY KEY (category_id, image_id),
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE CASCADE,
    CONSTRAINT fk_image FOREIGN KEY (image_id) REFERENCES image (id) ON DELETE CASCADE
);

-- Junction table for Artist-Image relationship (One-to-Many)
CREATE TABLE artist_image (
    artist_id UUID,
    image_id UUID,
    PRIMARY KEY (artist_id, image_id),
    CONSTRAINT fk_artist FOREIGN KEY (artist_id) REFERENCES artist (id) ON DELETE CASCADE,
    CONSTRAINT fk_image FOREIGN KEY (image_id) REFERENCES image (id) ON DELETE CASCADE
);

-- Add GIST index for coordinates in location table
CREATE INDEX idx_location_coordinates ON location USING GIST (coordinates);

-- Add index for faster lookups
CREATE INDEX idx_category_title ON category (title);
CREATE INDEX idx_tags_name ON tag (name);
CREATE INDEX idx_art_title ON art (title);
CREATE INDEX idx_artist_name ON artist (name);
CREATE INDEX idx_image_typename ON image (typename);
