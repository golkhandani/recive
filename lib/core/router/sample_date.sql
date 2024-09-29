-- Sample Data for Location
INSERT INTO location (id, typename, venue_title, area, city, country, postal_code, region, localized_address_display, osm_id, osm_licence, osm_venue_id, coordinates, type, createdAt, updatedAt)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440000', 'Park', 'Central Park', 'Manhattan', 'New York', 'USA', '10001', 'NY', 'Central Park, New York, NY', 123456789, 'ODbL', 987654321, ST_MakePoint(-73.9654, 40.7851), 'Public', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440001', 'Gallery', 'The Met', 'Upper East Side', 'New York', 'USA', '10028', 'NY', '1000 5th Ave, New York, NY', 123456788, 'ODbL', 987654320, ST_MakePoint(-73.9632, 40.7794), 'Cultural', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440002', 'Museum', 'MoMA', 'Midtown', 'New York', 'USA', '10019', 'NY', '11 W 53rd St, New York, NY', 123456787, 'ODbL', 987654319, ST_MakePoint(-73.9770, 40.7614), 'Cultural', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440003', 'Library', 'New York Public Library', 'Midtown', 'New York', 'USA', '10018', 'NY', '476 5th Ave, New York, NY', 123456786, 'ODbL', 987654318, ST_MakePoint(-73.9815, 40.7532), 'Public', NOW(), NOW());

-- Sample Data for Category
INSERT INTO category (id, title, subtitle, description, image_url, createdAt, updatedAt)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440004', 'Painting', 'Art in Colors', 'A collection of beautiful paintings.', 'http://example.com/image1.jpg', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440005', 'Sculpture', '3D Art', 'Three-dimensional artworks made from various materials.', 'http://example.com/image2.jpg', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440006', 'Photography', 'Capturing Moments', 'Art of capturing moments through a camera.', 'http://example.com/image3.jpg', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440007', 'Digital Art', 'Art in the Digital Era', 'Modern art created using digital technology.', 'http://example.com/image4.jpg', NOW(), NOW());

-- Sample Data for Tags
INSERT INTO tag (id, name, createdAt, updatedAt)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440008', 'Modern', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440009', 'Abstract', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440010', 'Classical', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440011', 'Nature', NOW(), NOW());

-- Sample Data for Source
INSERT INTO source (id, copy_right, data_url, name, createdAt, updatedAt)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440012', 'Public Domain', 'http://example.com/source1', 'Art Source 1', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440013', 'Creative Commons', 'http://example.com/source2', 'Art Source 2', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440014', 'Royalty Free', 'http://example.com/source3', 'Art Source 3', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440015', 'Public Domain', 'http://example.com/source4', 'Art Source 4', NOW(), NOW());

-- Sample Data for Art
INSERT INTO art (id, description, material, original_id, original_url, ownership, comment, title, source_id, location_id, createdAt, updatedAt)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440016', 'A beautiful landscape painting.', ARRAY['Canvas'], NULL, 'http://example.com/art1', 'Public', 'Incredible colors.', 'Sunset Over Mountains', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440000', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440017', 'A modern abstract sculpture.', ARRAY['Metal', 'Stone'], NULL, 'http://example.com/art2', 'Private', 'A unique design.', 'Abstract Thoughts', '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440001', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440018', 'A classic portrait painting.', ARRAY['Oil'], NULL, 'http://example.com/art3', 'Public', 'Timeless beauty.', 'Portrait of a Lady', '550e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440003', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440019', 'A stunning nature photograph.', ARRAY['Digital'], NULL, 'http://example.com/art4', 'Public', 'Captures the essence of nature.', 'Nature Beauty', '550e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440002', NOW(), NOW());

-- Sample Data for Artist
INSERT INTO artist (id, typename, biography, country, name, website, original_id, createdAt, updatedAt)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440020', 'Painter', 'An artist known for landscape paintings.', 'USA', 'John Doe', 'http://example.com/johndoe', NULL, NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440021', 'Sculptor', 'An artist specializing in modern sculptures.', 'USA', 'Jane Smith', 'http://example.com/janesmith', NULL, NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440022', 'Photographer', 'A photographer who captures nature.', 'USA', 'Emily Johnson', 'http://example.com/emilyjohnson', NULL, NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440023', 'Digital Artist', 'An artist working with digital mediums.', 'USA', 'Michael Brown', 'http://example.com/michaelbrown', NULL, NOW(), NOW());

-- Sample Data for Image
INSERT INTO image (id, typename, image_credit, image_data, image_url, createdAt, updatedAt)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440024', 'Art Image', 'Photo by John Doe', 'Base64EncodedData1', 'http://example.com/artimage1.jpg', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440025', 'Art Image', 'Photo by Jane Smith', 'Base64EncodedData2', 'http://example.com/artimage2.jpg', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440026', 'Art Image', 'Photo by Emily Johnson', 'Base64EncodedData3', 'http://example.com/artimage3.jpg', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440027', 'Art Image', 'Photo by Michael Brown', 'Base64EncodedData4', 'http://example.com/artimage4.jpg', NOW(), NOW());

-- Sample Data for Art-Category relationship
INSERT INTO art_category (art_id, category_id)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440004'), -- Sunset Over Mountains -> Painting
    ('550e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440005'), -- Abstract Thoughts -> Sculpture
    ('550e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440004'), -- Portrait of a Lady -> Painting
    ('550e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440006'); -- Nature's Beauty -> Photography

-- Sample Data for Art-Tag relationship
INSERT INTO art_tag (art_id, tag_id)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440008'), -- Sunset Over Mountains -> Modern
    ('550e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440009'), -- Abstract Thoughts -> Abstract
    ('550e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440010'), -- Portrait of a Lady -> Classical
    ('550e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440011'); -- Nature's Beauty -> Nature

-- Sample Data for Art-Artist relationship
INSERT INTO art_artist (art_id, artist_id)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440020'), -- Sunset Over Mountains -> John Doe
    ('550e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440021'), -- Abstract Thoughts -> Jane Smith
    ('550e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440020'), -- Portrait of a Lady -> John Doe
    ('550e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440022'); -- Nature's Beauty -> Emily Johnson

-- Sample Data for Art-Image relationship
INSERT INTO art_image (art_id, image_id)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440024'), -- Sunset Over Mountains -> Art Image 1
    ('550e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440025'), -- Abstract Thoughts -> Art Image 2
    ('550e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440024'), -- Portrait of a Lady -> Art Image 1
    ('550e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440026'); -- Nature's Beauty -> Art Image 3

-- Sample Data for Category-Image relationship
INSERT INTO category_image (category_id, image_id)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440024'), -- Painting -> Art Image 1
    ('550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440025'), -- Sculpture -> Art Image 2
    ('550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440026'); -- Photography -> Art Image 3

-- Sample Data for Artist-Image relationship
INSERT INTO artist_image (artist_id, image_id)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440024'), -- John Doe -> Art Image 1
    ('550e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440025'), -- Jane Smith -> Art Image 2
    ('550e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440026'); -- Emily Johnson -> Art Image 3
