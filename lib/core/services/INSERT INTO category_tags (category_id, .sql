CREATE TABLE category (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    image_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE tag (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE category_tags (
    category_id UUID REFERENCES category(id) ON DELETE CASCADE,
    tag_id UUID REFERENCES tag(id) ON DELETE CASCADE,
    PRIMARY KEY (category_id, tag_id)
);

-- Trigger function to update `updated_at` on row modification
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply trigger function to `category` table
CREATE TRIGGER update_category_timestamp
BEFORE UPDATE ON category
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply trigger function to `tag` table
CREATE TRIGGER update_tag_timestamp
BEFORE UPDATE ON tag
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

INSERT INTO category (id, title, description, created_at, updated_at) VALUES
(UUID_GENERATE_V4(), 'Drag', 'A performance art blending fashion, makeup, and theatrical expression, challenging traditional gender norms.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Painting', 'The application of pigment on surfaces like canvas or paper to create visual artwork, using tools like brushes and knives.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Sculpture', 'Three-dimensional art formed by shaping materials such as stone, metal, clay, or wood.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Photography', 'Capturing images with a camera, reflecting moments, people, and landscapes.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Digital Art', 'Artwork made using digital tools and software for painting, 3D modeling, and animation.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Printmaking', 'Art created by transferring ink from a matrix onto another surface, like paper or fabric.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Ceramics', 'Art crafted from clay, often shaped and hardened in a kiln.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Illustration', 'Visual artwork that complements text, seen in books, ads, and magazines.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Mixed Media', 'Art combining materials like paint, fabric, and found objects to create layered effects.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Textile Art', 'Artwork using fibers and textiles, including weaving, embroidery, and knitting.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Installation', 'Large-scale, often immersive art created for a specific space, encouraging viewer interaction.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Collage', 'Art created by assembling materials like paper, fabric, and photos onto a surface.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Architecture', 'The art and science of designing buildings and structures that are functional and aesthetically pleasing.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Street Art', 'Public art created in urban areas, often with social and political messages.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Performance Art', 'Live art where the artist uses their body to convey messages or stories, often challenging norms.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Glass Art', 'Art shaped by techniques like blowing, molding, or fusing glass.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Graphic Design', 'Visual art creating graphics for branding, advertising, and web or print layouts.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Woodworking', 'Art involving crafting wood into functional or decorative pieces.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Calligraphy', 'Decorative handwriting or lettering used in manuscripts, sign painting, and art.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Video Art', 'Art that uses video as its main medium, exploring time, movement, and viewer interaction.', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Conceptual Art', 'Art where the concept or idea takes precedence over the physical form or technical skill.', NOW(), NOW());

INSERT INTO tag (id, name, created_at, updated_at) VALUES
(UUID_GENERATE_V4(), 'Performance', NOW(), NOW()),
(UUID_GENERATE_V4(), 'LGBTQ+', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Fashion', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Gender', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Theatrical', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Canvas', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Color', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Expression', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Realism', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Abstract', NOW(), NOW()),
(UUID_GENERATE_V4(), '3D Art', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Carving', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Bronze', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Marble', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Clay', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Camera', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Lens', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Digital', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Film', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Portrait', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Landscape', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Computer', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Software', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Animation', NOW(), NOW()),
(UUID_GENERATE_V4(), 'CGI', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Modern', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Ink', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Press', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Etching', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Screenprint', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Limited Edition', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Pottery', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Kiln', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Craft', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Drawing', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Commercial', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Storytelling', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Editorial', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Design', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Collage', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Texture', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Layers', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Assemblage', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Experimental', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Fabric', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Fiber', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Embroidery', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Tapestry', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Spatial', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Interactive', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Environment', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Site-Specific', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Immersive', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Cutout', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Paper', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Photomontage', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Vintage', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Structure', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Modernism', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Graffiti', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Urban', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Murals', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Public', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Activism', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Live', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Body', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Expressive', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Temporal', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Blown Glass', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Stained Glass', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Transparent', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Decorative', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Typography', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Layout', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Branding', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Furniture', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Tools', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Script', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Traditional', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Moving Image', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Projection', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Ideas', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Minimalism', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Avant-garde', NOW(), NOW()),
(UUID_GENERATE_V4(), 'Theory', NOW(), NOW());


INSERT INTO category_tags (category_id, tag_id) VALUES
-- Drag
((SELECT id FROM category WHERE title = 'Drag'), (SELECT id FROM tag WHERE name = 'Performance')),
((SELECT id FROM category WHERE title = 'Drag'), (SELECT id FROM tag WHERE name = 'LGBTQ+')),
((SELECT id FROM category WHERE title = 'Drag'), (SELECT id FROM tag WHERE name = 'Fashion')),
((SELECT id FROM category WHERE title = 'Drag'), (SELECT id FROM tag WHERE name = 'Gender')),
((SELECT id FROM category WHERE title = 'Drag'), (SELECT id FROM tag WHERE name = 'Theatrical')),

-- Painting
((SELECT id FROM category WHERE title = 'Painting'), (SELECT id FROM tag WHERE name = 'Canvas')),
((SELECT id FROM category WHERE title = 'Painting'), (SELECT id FROM tag WHERE name = 'Color')),
((SELECT id FROM category WHERE title = 'Painting'), (SELECT id FROM tag WHERE name = 'Expression')),
((SELECT id FROM category WHERE title = 'Painting'), (SELECT id FROM tag WHERE name = 'Realism')),
((SELECT id FROM category WHERE title = 'Painting'), (SELECT id FROM tag WHERE name = 'Abstract')),

-- Sculpture
((SELECT id FROM category WHERE title = 'Sculpture'), (SELECT id FROM tag WHERE name = '3D Art')),
((SELECT id FROM category WHERE title = 'Sculpture'), (SELECT id FROM tag WHERE name = 'Carving')),
((SELECT id FROM category WHERE title = 'Sculpture'), (SELECT id FROM tag WHERE name = 'Bronze')),
((SELECT id FROM category WHERE title = 'Sculpture'), (SELECT id FROM tag WHERE name = 'Marble')),
((SELECT id FROM category WHERE title = 'Sculpture'), (SELECT id FROM tag WHERE name = 'Clay')),

-- Photography
((SELECT id FROM category WHERE title = 'Photography'), (SELECT id FROM tag WHERE name = 'Camera')),
((SELECT id FROM category WHERE title = 'Photography'), (SELECT id FROM tag WHERE name = 'Lens')),
((SELECT id FROM category WHERE title = 'Photography'), (SELECT id FROM tag WHERE name = 'Digital')),
((SELECT id FROM category WHERE title = 'Photography'), (SELECT id FROM tag WHERE name = 'Film')),
((SELECT id FROM category WHERE title = 'Photography'), (SELECT id FROM tag WHERE name = 'Portrait')),
((SELECT id FROM category WHERE title = 'Photography'), (SELECT id FROM tag WHERE name = 'Landscape')),

-- Digital Art
((SELECT id FROM category WHERE title = 'Digital Art'), (SELECT id FROM tag WHERE name = 'Computer')),
((SELECT id FROM category WHERE title = 'Digital Art'), (SELECT id FROM tag WHERE name = 'Software')),
((SELECT id FROM category WHERE title = 'Digital Art'), (SELECT id FROM tag WHERE name = 'Animation')),
((SELECT id FROM category WHERE title = 'Digital Art'), (SELECT id FROM tag WHERE name = 'CGI')),
((SELECT id FROM category WHERE title = 'Digital Art'), (SELECT id FROM tag WHERE name = 'Modern')),

-- Printmaking
((SELECT id FROM category WHERE title = 'Printmaking'), (SELECT id FROM tag WHERE name = 'Press')),
((SELECT id FROM category WHERE title = 'Printmaking'), (SELECT id FROM tag WHERE name = 'Limited Edition')),
((SELECT id FROM category WHERE title = 'Printmaking'), (SELECT id FROM tag WHERE name = 'Etching')),
((SELECT id FROM category WHERE title = 'Printmaking'), (SELECT id FROM tag WHERE name = 'Screenprint')),

-- Ceramics
((SELECT id FROM category WHERE title = 'Ceramics'), (SELECT id FROM tag WHERE name = 'Pottery')),
((SELECT id FROM category WHERE title = 'Ceramics'), (SELECT id FROM tag WHERE name = 'Kiln')),
((SELECT id FROM category WHERE title = 'Ceramics'), (SELECT id FROM tag WHERE name = 'Craft')),

-- Illustration
((SELECT id FROM category WHERE title = 'Illustration'), (SELECT id FROM tag WHERE name = 'Drawing')),
((SELECT id FROM category WHERE title = 'Illustration'), (SELECT id FROM tag WHERE name = 'Commercial')),
((SELECT id FROM category WHERE title = 'Illustration'), (SELECT id FROM tag WHERE name = 'Editorial')),

-- Mixed Media
((SELECT id FROM category WHERE title = 'Mixed Media'), (SELECT id FROM tag WHERE name = 'Collage')),
((SELECT id FROM category WHERE title = 'Mixed Media'), (SELECT id FROM tag WHERE name = 'Texture')),
((SELECT id FROM category WHERE title = 'Mixed Media'), (SELECT id FROM tag WHERE name = 'Layers')),
((SELECT id FROM category WHERE title = 'Mixed Media'), (SELECT id FROM tag WHERE name = 'Assemblage')),

-- Textile Art
((SELECT id FROM category WHERE title = 'Textile Art'), (SELECT id FROM tag WHERE name = 'Fabric')),
((SELECT id FROM category WHERE title = 'Textile Art'), (SELECT id FROM tag WHERE name = 'Fiber')),
((SELECT id FROM category WHERE title = 'Textile Art'), (SELECT id FROM tag WHERE name = 'Embroidery')),
((SELECT id FROM category WHERE title = 'Textile Art'), (SELECT id FROM tag WHERE name = 'Tapestry')),

-- Installation
((SELECT id FROM category WHERE title = 'Installation'), (SELECT id FROM tag WHERE name = 'Spatial')),
((SELECT id FROM category WHERE title = 'Installation'), (SELECT id FROM tag WHERE name = 'Interactive')),
((SELECT id FROM category WHERE title = 'Installation'), (SELECT id FROM tag WHERE name = 'Environment')),
((SELECT id FROM category WHERE title = 'Installation'), (SELECT id FROM tag WHERE name = 'Site-Specific')),
((SELECT id FROM category WHERE title = 'Installation'), (SELECT id FROM tag WHERE name = 'Immersive')),

-- Collage
((SELECT id FROM category WHERE title = 'Collage'), (SELECT id FROM tag WHERE name = 'Cutout')),
((SELECT id FROM category WHERE title = 'Collage'), (SELECT id FROM tag WHERE name = 'Paper')),
((SELECT id FROM category WHERE title = 'Collage'), (SELECT id FROM tag WHERE name = 'Photomontage')),

-- Architecture
((SELECT id FROM category WHERE title = 'Architecture'), (SELECT id FROM tag WHERE name = 'Structure')),
((SELECT id FROM category WHERE title = 'Architecture'), (SELECT id FROM tag WHERE name = 'Modernism')),
((SELECT id FROM category WHERE title = 'Architecture'), (SELECT id FROM tag WHERE name = 'Design')),

-- Street Art
((SELECT id FROM category WHERE title = 'Street Art'), (SELECT id FROM tag WHERE name = 'Graffiti')),
((SELECT id FROM category WHERE title = 'Street Art'), (SELECT id FROM tag WHERE name = 'Urban')),
((SELECT id FROM category WHERE title = 'Street Art'), (SELECT id FROM tag WHERE name = 'Murals')),
((SELECT id FROM category WHERE title = 'Street Art'), (SELECT id FROM tag WHERE name = 'Public')),
((SELECT id FROM category WHERE title = 'Street Art'), (SELECT id FROM tag WHERE name = 'Activism')),

-- Performance Art
((SELECT id FROM category WHERE title = 'Performance Art'), (SELECT id FROM tag WHERE name = 'Live')),
((SELECT id FROM category WHERE title = 'Performance Art'), (SELECT id FROM tag WHERE name = 'Body')),
((SELECT id FROM category WHERE title = 'Performance Art'), (SELECT id FROM tag WHERE name = 'Expressive')),
((SELECT id FROM category WHERE title = 'Performance Art'), (SELECT id FROM tag WHERE name = 'Temporal')),

-- Glass Art
((SELECT id FROM category WHERE title = 'Glass Art'), (SELECT id FROM tag WHERE name = 'Blown Glass')),
((SELECT id FROM category WHERE title = 'Glass Art'), (SELECT id FROM tag WHERE name = 'Stained Glass')),
((SELECT id FROM category WHERE title = 'Glass Art'), (SELECT id FROM tag WHERE name = 'Transparent')),
((SELECT id FROM category WHERE title = 'Glass Art'), (SELECT id FROM tag WHERE name = 'Decorative')),

-- Graphic Design
((SELECT id FROM category WHERE title = 'Graphic Design'), (SELECT id FROM tag WHERE name = 'Typography')),
((SELECT id FROM category WHERE title = 'Graphic Design'), (SELECT id FROM tag WHERE name = 'Layout')),
((SELECT id FROM category WHERE title = 'Graphic Design'), (SELECT id FROM tag WHERE name = 'Branding')),

-- Woodworking
((SELECT id FROM category WHERE title = 'Woodworking'), (SELECT id FROM tag WHERE name = 'Furniture')),
((SELECT id FROM category WHERE title = 'Woodworking'), (SELECT id FROM tag WHERE name = 'Tools')),
((SELECT id FROM category WHERE title = 'Woodworking'), (SELECT id FROM tag WHERE name = 'Craft')),
((SELECT id FROM category WHERE title = 'Woodworking'), (SELECT id FROM tag WHERE name = 'Traditional')),

-- Calligraphy
((SELECT id FROM category WHERE title = 'Calligraphy'), (SELECT id FROM tag WHERE name = 'Script')),
((SELECT id FROM category WHERE title = 'Calligraphy'), (SELECT id FROM tag WHERE name = 'Art')),
((SELECT id FROM category WHERE title = 'Calligraphy'), (SELECT id FROM tag WHERE name = 'Decorative')),

-- Conceptual Art (new addition)
((SELECT id FROM category WHERE title = 'Conceptual Art'), (SELECT id FROM tag WHERE name = 'Idea')),
((SELECT id FROM category WHERE title = 'Conceptual Art'), (SELECT id FROM tag WHERE name = 'Philosophy')),
((SELECT id FROM category WHERE title = 'Conceptual Art'), (SELECT id FROM tag WHERE name = 'Challenge')),
((SELECT id FROM category WHERE title = 'Conceptual Art'), (SELECT id FROM tag WHERE name = 'Critique'));


CREATE TYPE media_type AS ENUM ('image', 'video');

-- Create the media_model table
CREATE TABLE media (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR NOT NULL,
    type media_type NOT NULL,
    url VARCHAR NOT NULL,
    copyright VARCHAR NOT NULL
);

CREATE TABLE link (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR NOT NULL,
    url VARCHAR NOT NULL
);

CREATE TABLE artist (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE artist_media (
    artist_id UUID REFERENCES artist(id) ON DELETE CASCADE,
    media_id UUID REFERENCES media(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, media_id)
);

CREATE TABLE artist_links (
    artist_id UUID REFERENCES artist(id) ON DELETE CASCADE,
    link_id UUID REFERENCES link(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, link_id)
);

CREATE TABLE artist_tags (
    artist_id UUID REFERENCES artist(id) ON DELETE CASCADE,
    tag_id UUID REFERENCES tag(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, tag_id)
);


CREATE TABLE location (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255),
    area VARCHAR(255),
    city VARCHAR(255),
    country VARCHAR(255),
    postal_code VARCHAR(20),
    region VARCHAR(255),
    details VARCHAR(255),
    address VARCHAR(255),
    coordinates GEOGRAPHY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE art (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(255),
    type VARCHAR(255),
    material TEXT[],
    ownership VARCHAR(255),
    location_id UUID,
    installed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_location FOREIGN KEY (location_id) REFERENCES location (id)
);


CREATE TABLE art_media (
    art_id UUID REFERENCES art(id) ON DELETE CASCADE,
    media_id UUID REFERENCES media(id) ON DELETE CASCADE,
    PRIMARY KEY (art_id, media_id)
);

CREATE TABLE art_links (
    art_id UUID REFERENCES art(id) ON DELETE CASCADE,
    link_id UUID REFERENCES link(id) ON DELETE CASCADE,
    PRIMARY KEY (art_id, link_id)
);

CREATE TABLE art_tags (
    art_id UUID REFERENCES art(id) ON DELETE CASCADE,
    tag_id UUID REFERENCES tag(id) ON DELETE CASCADE,
    PRIMARY KEY (art_id, tag_id)
);

CREATE TABLE art_artists (
    art_id UUID REFERENCES art(id) ON DELETE CASCADE,
    artist_id UUID REFERENCES artist(id) ON DELETE CASCADE,
    PRIMARY KEY (art_id, artist_id)
);