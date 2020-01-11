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
