
-- Basic select
SELECT 
    a.id AS art_id,
    a.title AS art_title,
    a.description AS art_description,
    a.material AS art_material,
    a.original_id AS original_id,
    a.original_url AS original_url,
    a.ownership AS art_ownership,
    a.comment AS art_comment,
    a.tags AS art_tags,
    a.source_id AS source_id,
    s.name AS source_name,
    s.copy_right AS source_copy_right,
    s.data_url AS source_data_url,
    l.venue_title AS location_venue_title,
    l.area AS location_area,
    l.city AS location_city,
    l.country AS location_country,
    l.postal_code AS location_postal_code,
    l.region AS location_region,
    l.localized_address_display AS location_display,
    ARRAY_AGG(DISTINCT c.title) AS categories,
    ARRAY_AGG(DISTINCT ar.name) AS artists,
    ARRAY_AGG(DISTINCT i.image_url) AS images
FROM 
    art a
LEFT JOIN 
    source s ON a.source_id = s.id
LEFT JOIN 
    location l ON a.location_id = l.id
LEFT JOIN 
    art_category ac ON a.id = ac.art_id
LEFT JOIN 
    category c ON ac.category_id = c.id
LEFT JOIN 
    art_artist aa ON a.id = aa.art_id
LEFT JOIN 
    artist ar ON aa.artist_id = ar.id
LEFT JOIN 
    art_image ai ON a.id = ai.art_id
LEFT JOIN 
    image i ON ai.image_id = i.id
WHERE 
    a.id = '28b476f7-b179-4b40-b8fc-c36802b3a35c'  -- Replace with the desired art ID
GROUP BY 
    a.id, s.name, s.copy_right, s.data_url, l.id;

-- Search for locations, arts, and artists within a specified distance from a coordinate
SELECT 
    l.venue_title AS location_title,
    l.area,
    l.city,
    l.country,
    l.postal_code,
    a.title AS art_title,
    a.description AS art_description,
    ar.name AS artist_name,
    ST_Distance(l.coordinates, ST_GeogFromText('SRID=4326;POINT(-123.1207 49.2837)')) AS distance -- Calculate distance
FROM 
    location l
LEFT JOIN 
    art a ON l.id = a.location_id
LEFT JOIN 
    art_artist aa ON a.id = aa.art_id
LEFT JOIN 
    artist ar ON aa.artist_id = ar.id
WHERE 
    ST_DWithin(
        l.coordinates, 
        ST_GeogFromText('SRID=4326;POINT(-123.1207 49.2827)'), -- Specify your coordinate here
        5000000000 -- 5000 meters (5 km) radius
    )
ORDER BY 
    distance; -- Order by calculated distance