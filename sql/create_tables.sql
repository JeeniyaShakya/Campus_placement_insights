CREATE SCHEMA IF NOT EXISTS placement;
SET search_path = placement;

CREATE TABLE IF NOT EXISTS company_summary (
    summary_id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    company_name TEXT NOT NULL,
    total_offers INT,
    ctc_lpa NUMERIC,
    raw_source_table TEXT
);

CREATE TABLE IF NOT EXISTS students (
    student_id SERIAL PRIMARY KEY,
    roll_no TEXT,
    student_name TEXT,
    branch TEXT,
    raw_source_table TEXT
);

CREATE TABLE IF NOT EXISTS student_placements (
    placement_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    company_name TEXT,
    year INT,
    ctc_lpa NUMERIC,
    raw_source_table TEXT
);





