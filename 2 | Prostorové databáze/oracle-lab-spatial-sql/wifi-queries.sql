-- point [0,0] is in the left bottom corner

-- What is the total area covered by the signal?
SELECT SDO_GEOM.SDO_AREA(
		SDO_AGGR_UNION(SDO_GEOM.SDOAGGRTYPE(geometry, 1)),
	1) total_covered_area
FROM wifi;

-- What is the total area where overlaps are covered by the signal?
SELECT (SUM(SDO_GEOM.SDO_AREA(geometry, 1)) - SDO_GEOM.SDO_AREA(
		SDO_AGGR_UNION(SDO_GEOM.SDOAGGRTYPE(geometry, 1)),
	1)) total_overlaped_area
FROM wifi;

-- What is the surface not covered by the signal?
SELECT (150*150 - SDO_GEOM.SDO_AREA(
		SDO_AGGR_UNION(SDO_GEOM.SDOAGGRTYPE(geometry, 1)),
	1)) total_uncovered_area
FROM wifi;

-- Which buildings are covered by a signal.
SELECT DISTINCT c.name building
FROM city c, wifi w
WHERE (c.type = 'building') AND
	(SDO_RELATE(c.geometry, w.geometry, 'mask=ANYINTERACT') = 'TRUE')
ORDER BY c.name ASC;

-- Which buildings are covered by channel 3 and 9 respectively.
SELECT DISTINCT c.name building
FROM city c, wifi w
WHERE (c.type = 'building') AND
	((w.channel = 3) OR (w.channel = 9)) AND
	(SDO_RELATE(c.geometry, w.geometry, 'mask=INSIDE+COVEREDBY') = 'TRUE')
ORDER BY c.name ASC;

-- What is the total built-in area covered by the signal?
SELECT SDO_GEOM.SDO_AREA(
		SDO_GEOM.SDO_INTERSECTION(total_wifi, total_building, 1),
	1) covered_building_area
FROM
	(SELECT SDO_AGGR_UNION(SDO_GEOM.SDOAGGRTYPE(w.geometry, 1)) total_wifi
		FROM wifi w),
	(SELECT SDO_AGGR_UNION(SDO_GEOM.SDOAGGRTYPE(c.geometry, 1)) total_building
		FROM city c
		WHERE c.type = 'building')
;

quit
