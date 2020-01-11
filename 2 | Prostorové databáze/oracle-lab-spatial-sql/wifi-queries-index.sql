-- create a spatial index (for operators)
DROP INDEX wifi_geometry_sidx;
CREATE INDEX wifi_geometry_sidx ON wifi(geometry) INDEXTYPE IS MDSYS.SPATIAL_INDEX;

COMMIT;

quit
