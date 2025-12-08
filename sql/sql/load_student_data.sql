/* ---------------------------------------------------------
   STEP 1: INSERT UNIQUE STUDENT RECORDS (YEAR: 2019)
   ---------------------------------------------------------
   Purpose:
   - Load distinct student data from the raw table students_2019.
   - Insert into the master dimension table: placement.students.
   - Prevent multiple entries for the same student across years.
   - raw_source_table is used for traceability (data lineage).
--------------------------------------------------------- */

INSERT INTO placement.students (
    roll_no,
    student_name,
    branch,
    raw_source_table
)
SELECT DISTINCT
    roll_no,                  -- student ID in raw file
    name_of_student,          -- student's name
    branch,                   -- academic branch
    'students_2019'           -- data origin for traceability
FROM public.students_2019
WHERE roll_no IS NOT NULL;    -- ensure valid primary identifier
-- Note: Run similar INSERTs for students_2020, students_2021, etc.



/* ---------------------------------------------------------
   STEP 2: INSERT STUDENT–COMPANY RELATIONSHIPS (YEAR: 2019)
   ---------------------------------------------------------
   Purpose:
   - Some raw files contain multiple company columns per student
     (company1, company2, company3...).
   - We convert those multiple columns into multiple rows
     (student → company mapping).
   - Use UNNEST + string_to_array to split comma-separated values.
   - Join to placement.students to get the generated student_id.
--------------------------------------------------------- */

INSERT INTO placement.student_placements (
    student_id,
    company_name,
    year,
    raw_source_table
)
SELECT
    s.student_id,    -- master table student reference (foreign key)

    /* 
       Clean and normalize company names:
       - concat_ws combines all company columns into one comma string
       - string_to_array splits them into an array
       - unnest converts array into multiple rows
       - trim cleans spaces for quality
    */
    trim(unnest(string_to_array(
        concat_ws(',', r.company1, r.company2, r.company3),
        ','
    ))) AS company_name,

    2019 AS year,        -- placement year
    'students_2019'      -- traceability source
FROM public.students_2019 r

/* 
   Match raw students to master students table.
   Casting roll_no::text ensures consistent datatype.
*/
JOIN placement.students s
      ON s.roll_no::text = r.roll_no::text;
