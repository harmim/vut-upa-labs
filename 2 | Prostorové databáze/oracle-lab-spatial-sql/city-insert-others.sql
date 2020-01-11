-- point [0,0] is in the left bottom corner

DELETE FROM city WHERE
	NOT (type = 'building' OR type = 'road');

INSERT INTO city VALUES (
	'A', 'grass',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 3), -- exterior rectangle (left-bottom, right-top)
		SDO_ORDINATE_ARRAY(20,30, 65,35)
	)
);

INSERT INTO city VALUES (
	'D', 'grass',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 3), -- exterior rectangle (left-bottom, right-top)
		SDO_ORDINATE_ARRAY(120,20, 130,50)
	)
);

INSERT INTO city VALUES (
	'B', 'grass',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 1), -- exterior polygon (counterclockwise)
		SDO_ORDINATE_ARRAY(60,60, 70,60, 70,80, 50,80, 50,90, 45,90, 45,75, 60,75, 60,60)
	)
);

INSERT INTO city VALUES (
	'E', 'grass',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1,1003,3, 5,2003,4, 11,2003,4, 17,2003,4), -- exterior rectangle (left-bottom, right-top) with holes
		SDO_ORDINATE_ARRAY(
			80,100, 90,130 -- exterior rectangle, start=1
			,85,102.5, 87.5,105, 85,107.5 -- interior circle, start=5
			,85,112.5, 87.5,115, 85,117.5 -- interior circle, start=11
			,85,122.5, 87.5,125, 85,127.5 -- interior circle, start=17
		)
	)
);

INSERT INTO city VALUES (
	'E-circles', 'grass',
	SDO_GEOMETRY(2004, NULL, NULL, -- 2D collection
		SDO_ELEM_INFO_ARRAY(1,1003,4, 7,1003,4, 13,1003,4), -- 3 exterior circles (center-bottom, right-middle, center-top)
		SDO_ORDINATE_ARRAY(
			85,102.5, 87.5,105, 85,107.5, -- exterior circle, start=1
			85,112.5, 87.5,115, 85,117.5, -- exterior circle, start=7
			85,122.5, 87.5,125, 85,127.5 -- exterior circle, start=13
		)
	)
);

INSERT INTO city VALUES (
	'C', 'water',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 3), -- exterior rectangle (left-bottom, right-top)
		SDO_ORDINATE_ARRAY(120,60, 130,90)
	)
);

COMMIT;

-- check the validity (there can be an error message with an error code, see http://www.ora-code.com/)
-- with the custom accurance
SELECT name, SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT(geometry, 0.1) valid -- 0.1 is accurance
FROM city
WHERE NOT (type = 'building' OR type = 'road');

quit
