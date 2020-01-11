-- point [0,0] is in the left bottom corner

DELETE FROM wifi WHERE
	name LIKE 'AP%';

INSERT INTO wifi VALUES (
	'AP1', 9,
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 4), -- exterior circle
		SDO_ORDINATE_ARRAY(100,20, 135,55, 100,90)
	)
);

INSERT INTO wifi VALUES (
	'AP2', 9,
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 4), -- exterior circle
		SDO_ORDINATE_ARRAY(37.5,20, 60,42.5, 37.5,65)
	)
);

INSERT INTO wifi VALUES (
	'AP3', 3,
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 4), -- exterior circle
		SDO_ORDINATE_ARRAY(50,50, 80,80, 50,110)
	)
);

INSERT INTO wifi VALUES (
	'AP4', 9,
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 4), -- exterior circle
		SDO_ORDINATE_ARRAY(40,90, 65,115, 40,140)
	)
);

INSERT INTO wifi VALUES (
	'AP5', 3,
	SDO_GEOMETRY(2003, NULL, NULL, -- 2D polygon
		SDO_ELEM_INFO_ARRAY(1, 1003, 4), -- exterior circle
		SDO_ORDINATE_ARRAY(110,80, 140,110, 110,140)
	)
);

COMMIT;

-- check the validity (there can be an error message with an error code, see http://www.ora-code.com/)
SELECT name, SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT(geometry, 5) valid -- 5 is accurance
FROM wifi;

quit
