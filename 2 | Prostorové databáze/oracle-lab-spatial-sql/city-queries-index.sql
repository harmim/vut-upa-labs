-- create a spatial index (for operators)
DROP INDEX city_geometry_sidx;
CREATE INDEX city_geometry_sidx ON city(geometry) INDEXTYPE IS MDSYS.SPATIAL_INDEX;

COMMIT;

quit
