-- Trim whitespace
UPDATE placement.company_summary SET company_name = trim(company_name);
UPDATE placement.students SET student_name = trim(student_name), branch = trim(branch);
UPDATE placement.student_placements SET company_name = trim(company_name);

-- Normalize company names (extend for all variants you find)
UPDATE placement.company_summary
SET company_name = CASE
    WHEN lower(company_name) IN ('tcs','tata consultancy services','tata consultancy') THEN 'TCS'
    WHEN lower(company_name) IN ('infosys','infosys limited') THEN 'Infosys'
    WHEN lower(company_name) IN ('wipro','wipro ltd') THEN 'Wipro'
    WHEN lower(company_name) IN ('accenture','accenture pvt ltd') THEN 'Accenture'
    ELSE initcap(company_name)
END;

UPDATE placement.student_placements
SET company_name = CASE
    WHEN lower(company_name) IN ('tcs','tata consultancy services','tata consultancy') THEN 'TCS'
    WHEN lower(company_name) IN ('infosys','infosys limited') THEN 'Infosys'
    WHEN lower(company_name) IN ('wipro','wipro ltd') THEN 'Wipro'
    WHEN lower(company_name) IN ('accenture','accenture pvt ltd') THEN 'Accenture'
    ELSE initcap(company_name)
END;
-- Cast numeric-like columns (safely)
ALTER TABLE placement.company_summary
  ALTER COLUMN total_offers TYPE INT USING (trim(total_offers::text)::int);

ALTER TABLE placement.company_summary
  ALTER COLUMN ctc_lpa TYPE NUMERIC USING (regexp_replace(coalesce(ctc_lpa::text,''), '[^0-9.]', '', 'g'))::NUMERIC;
