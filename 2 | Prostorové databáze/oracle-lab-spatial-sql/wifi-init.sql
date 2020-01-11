DROP TABLE wifi;

CREATE TABLE wifi (
	name VARCHAR2(32),
	channel NUMBER(2),
	geometry SDO_GEOMETRY,
	PRIMARY KEY (name)
);

-- names of the table and the column below must be in upper-case letters
DELETE FROM USER_SDO_GEOM_METADATA WHERE
	TABLE_NAME = 'WIFI' AND COLUMN_NAME = 'GEOMETRY';

INSERT INTO USER_SDO_GEOM_METADATA VALUES (
	'wifi', 'geometry',
	-- X/Y axes in range 0-150 and accurancy 1 points (the size of the mesh is given, the accurancy of 1 point is ok)
	SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 0, 150, 1), SDO_DIM_ELEMENT('Y', 0, 150, 1)),
	-- a local spatial reference system (not geographical; analytical functions will be without units)
	NULL
);

COMMIT;

-- check the validity (there can be an error message with an error code, see http://www.ora-code.com/)
-- with the custom accurance
SELECT name, SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT(geometry, 0.1) valid -- 0.1 is accurance
FROM wifi;
-- without the custom accurance (with respect to the accurance set in the SDO_GEOM_METADATA
SELECT w.name, w.geometry.ST_IsValid()
FROM wifi w;

quit
