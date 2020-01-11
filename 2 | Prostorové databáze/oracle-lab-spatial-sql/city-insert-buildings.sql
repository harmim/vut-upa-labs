-- point [0,0] is in the left bottom corner

DELETE FROM city WHERE
	type = 'building';

INSERT INTO city VALUES (
	'A', 'building',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 3), -- exterior rectangle (left-bottom, right-top)
		SDO_ORDINATE_ARRAY(20,35, 65,50)
	)
);

INSERT INTO city VALUES (
	'B', 'building',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 1), -- exterior polygon (counterclockwise)
		SDO_ORDINATE_ARRAY(30,60, 60,60, 60,75, 45,75, 45,90, 30,90, 30,60)
	)
);

INSERT INTO city VALUES (
	'B1', 'building',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 3), -- exterior rectangle (left-bottom, right-top)
		SDO_ORDINATE_ARRAY(50,80, 70,90)
	)
);

INSERT INTO city VALUES (
	'C', 'building',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 3), -- exterior rectangle (left-bottom, right-top)
		SDO_ORDINATE_ARRAY(80,60, 120,90)
	)
);

INSERT INTO city VALUES (
	'D', 'building',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 3), -- exterior rectangle (left-bottom, right-top)
		SDO_ORDINATE_ARRAY(75,20, 120,50)
	)
);

INSERT INTO city VALUES (
	'G', 'building',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1,1005,4, 1,2,2, 5,2,1, 7,2,2, 11,2,1), -- exterior compound polygon (counterclockwise), 4 linestrings (iterpretation)
		SDO_ORDINATE_ARRAY(
			100,110, 110,100, 120,110, -- bottom arc, start=1 (the arc must be defined by 3 points)
			120,120, -- right line, start=5
			110,130, 100,120, -- top arc, start=7
			100,110 -- left line, start=11
		)
	)
);

INSERT INTO city VALUES (
	'E1', 'building',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 3), -- exterior rectangle (left-bottom, right-top)
		SDO_ORDINATE_ARRAY(30,100, 55,115)
	)
);

INSERT INTO city VALUES (
	'E2', 'building',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 3), -- exterior rectangle (left-bottom, right-top)
		SDO_ORDINATE_ARRAY(30,115, 55,130)
	)
);

INSERT INTO city VALUES (
	'E3', 'building',
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 3), -- exterior rectangle (left-bottom, right-top)
		SDO_ORDINATE_ARRAY(55,100, 80,130)
	)
);

COMMIT;

-- check the validity (there can be an error message with an error code, see http://www.ora-code.com/)
-- with the custom accurance
SELECT name, SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT(geometry, 5) valid -- 5 is accurance
FROM city
WHERE type = 'building';

quit
