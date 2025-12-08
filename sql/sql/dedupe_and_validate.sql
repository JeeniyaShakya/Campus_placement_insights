----------------------------------------------------------------------
-- REMOVE DUPLICATES FROM company_summary
-- Strategy:
-- 1. Create a temporary table with DISTINCT rows using DISTINCT ON
-- 2. Keep the first row per (year, company_name) based on summary_id
-- 3. Truncate original table
-- 4. Re-insert clean records
----------------------------------------------------------------------

CREATE TABLE tmp_companies AS
SELECT DISTINCT ON (year, company_name) *
FROM placement.company_summary
ORDER BY year, company_name, summary_id;

TRUNCATE placement.company_summary;

INSERT INTO placement.company_summary
SELECT * FROM tmp_companies;

DROP TABLE tmp_companies;


----------------------------------------------------------------------
-- REMOVE DUPLICATES FROM student_placements
-- Strategy:
-- 1. Create a temp table keeping the first row per 
--    (student_id, company_name, year) based on placement_id
-- 2. Truncate the original table
-- 3. Re-insert deduplicated data
----------------------------------------------------------------------

CREATE TABLE tmp_placements AS
SELECT DISTINCT ON (student_id, company_name, year) *
FROM placement.student_placements
ORDER BY student_id, company_name, year, placement_id;

TRUNCATE placement.student_placements;

INSERT INTO placement.student_placements
SELECT * FROM tmp_placements;

DROP TABLE tmp_placements;
