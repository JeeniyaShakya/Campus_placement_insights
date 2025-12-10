SET search_path = placement;

CREATE OR REPLACE VIEW vw_company_master AS
SELECT year, company_name, total_offers, ctc_lpa
FROM company_summary;

CREATE OR REPLACE VIEW vw_student_master AS
SELECT s.student_id, s.roll_no, s.student_name, s.branch,
       p.company_name, p.year, p.ctc_lpa
FROM students s
JOIN student_placements p ON s.student_id = p.student_id;

-- for adding the ctc_lpa from the company_summary
SELECT s.student_id,
       s.roll_no,
       s.student_name,
       s.branch,
       sp.company_name,
       sp.year,
       cs.ctc_lpa
FROM placement.students s
JOIN placement.student_placements sp
  ON s.student_id = sp.student_id
JOIN placement.company_summary cs
  ON cs.company_name = sp.company_name
 AND cs.year = sp.year;


SELECT sp.student_id,
       sp.company_name,
       sp.year,
       cs.ctc_lpa
FROM placement.student_placements sp
JOIN placement.company_summary cs
  ON cs.company_name = sp.company_name
 AND cs.year = sp.year;

