-- point [0,0] is in the left bottom corner

DELETE FROM city WHERE
	type = 'road';

INSERT INTO city VALUES (
	'main street', 'road',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1,1005,10, -- exterior compound polygon (counterclockwise)
			-- 10 linestrings (interpretation, for the exterior compound polygon)
			1,2,1, 7,2,2, 11,2,1, 21,2,2, 25,2,1, 27,2,2, 31,2,1, 43,2,2, 47,2,1, 49,2,2
			-- extract building G, interior compound polygon (clockwise), 4 linestrings (iterpretation)
			,55,2005,4, 55,2,1, 57,2,2, 61,2,1, 63,2,2
			-- extract building A + surroundings, interior rectangle (left-bottom, right-top)
			,69,2003,3
			-- extract building D + surroundings, interior rectangle (left-bottom, right-top)
			,73,2003,3
			-- extract building C + surroundings, interior rectangle (left-bottom, right-top)
			,77,2003,3
			-- extract building B,B1 + surroundings, interior rectangle (left-bottom, right-top)
			,81,2003,3
			-- extract building E1,E2,E3 + surroundings, interior rectangle (left-bottom, right-top)
			,85,2003,3
		),
		SDO_ORDINATE_ARRAY(
			-- roads polygon from left bottom corner, start=1, counter-clockwise
			15,20, 60,20, 70,10, 135,10, -- bottom straight linestring, start=1
			138,14, 140,15, -- right bottom corner, start=7 (the arc must be defined by 3 points; a quater-circle of diameter 5 has the third point [3,4])
			140,90, 150,90, 150,100, 130,100, 130,135, -- right straight linestring, start=11
			127,139, 125,140, -- right upper corner, start=21
			25,140, -- upper straight linestring, start=25
			22,136, 20,135, -- left upper corner, start=27
			20,100, 0,100, 0,90, 20,90, 20,60, 15,60, -- left upper straight linestring, start=31
			12,56, 10,55, -- left middle corner, start=43
			10,25, -- left bottom linestring, start=47
			13,21,15,20 -- left bottom corner, start=49
			-- buildign G, start=55, counter-clockwise (also for other building)
			,100,110, 100,120, -- left line, start=55
			110,130, 120,120, -- top arc, start=57
			120,110,  -- right line, start=61
			110,100, 100,110 -- bottom arc, start=63
			-- building A + surroundings, start=69
			,20,30, 65,50
			-- building D + surroundings, start=73
			,75,20, 130,50
			-- building C + surroundings, start=77
			,80,60, 130,90
			-- buildings B + surroundings, start=81
			,30,60, 70,90
			-- buildings E + surroundings, start=85
			,30,100, 90,130
		)
	)
);

COMMIT;

-- check the validity (there can be an error message with an error code, see http://www.ora-code.com/)
-- with the custom accurance
SELECT name, SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT(geometry, 0.1) valid -- 0.1 is accurance
FROM city
WHERE type = 'road';

quit
