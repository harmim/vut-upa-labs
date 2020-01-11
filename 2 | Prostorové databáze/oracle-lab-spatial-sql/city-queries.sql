-- point [0,0] is in the left bottom corner

-- What is the distance between building A and building G?
SELECT SDO_GEOM.SDO_DISTANCE(a.geometry, g.geometry, 1) distance_of_buildings_a_g
FROM city a, city g
WHERE a.name = 'A' AND a.type = 'building' AND g.name = 'G' AND g.type = 'building';

-- What is the total built-up area?
SELECT SUM(SDO_GEOM.SDO_AREA(geometry, 1)) total_building_area
FROM city
WHERE type = 'building';

-- What is the total green (grass and trees) area?
SELECT SUM(SDO_GEOM.SDO_AREA(geometry, 1)) total_grass_area
FROM city
WHERE type = 'grass';

-- What is the total area of communications (roads)?
SELECT SUM(SDO_GEOM.SDO_AREA(geometry, 1)) total_road_area
FROM city
WHERE type = 'road';

-- Which building has the largest built-up area?
SELECT src.name name_of_greenest_building, SDO_GEOM.SDO_AREA(src.geometry, 1) area
FROM city src
WHERE (src.type = 'building') AND NOT EXISTS (
	SELECT 1 FROM city dst
	WHERE (dst.type = 'building') AND
		(SDO_GEOM.SDO_AREA(dst.geometry, 1) > SDO_GEOM.SDO_AREA(src.geometry, 1)) AND
		(src.name <> dst.name)
);

-- Which buildings have the same built-up area?
SELECT a.name first_building, b.name second_building, SDO_GEOM.SDO_AREA(a.geometry, 1) area
FROM city a, city b
WHERE (a.type = 'building') AND (b.type = 'building') AND (a.name < b.name) AND
	(SDO_GEOM.SDO_AREA(a.geometry, 1) = SDO_GEOM.SDO_AREA(b.geometry, 1));

-- Which building is adjacent to the largest green area (grass)?
SELECT name building_greenest
FROM city
WHERE (type = 'building') AND (SDO_RELATE(geometry, (SELECT src.geometry
		FROM city src WHERE (src.type = 'grass') AND NOT EXISTS (
		SELECT 1 FROM city dst
		WHERE (dst.type = 'grass') AND
			(SDO_GEOM.SDO_AREA(dst.geometry, 1) > SDO_GEOM.SDO_AREA(src.geometry, 1)) AND
			(src.name <> dst.name)
	)), 'mask=ANYINTERACT') = 'TRUE');

-- Which building is adjacent to the water surface?
SELECT building.name building_near_water, water.name water
FROM city building, city water
WHERE (building.type = 'building') AND (water.type = 'water') AND
	(SDO_RELATE(building.geometry, water.geometry, 'mask=ANYINTERACT') = 'TRUE');

quit
