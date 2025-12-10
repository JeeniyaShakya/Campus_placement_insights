-- Normalize branch labels and clean related data

-- 1) Fix the I.T. spelling to IT
UPDATE placement.students
SET branch = 'IT'
WHERE branch = 'I.T.';

-- 2) Remove MBA and MCA placements first (to satisfy foreign key)
DELETE FROM placement.student_placements
WHERE student_id IN (
    SELECT student_id
    FROM placement.students
    WHERE branch IN ('MBA', 'MCA')
);

-- 3) Remove MBA and MCA students
DELETE FROM placement.students
WHERE branch IN ('MBA', 'MCA');

-- 4) Run the IT normalization again in case new rows appeared
UPDATE placement.students
SET branch = 'IT'
WHERE branch = 'I.T.';

-- 5) Extra safety: delete any remaining placements whose student was removed
DELETE FROM placement.student_placements sp
WHERE NOT EXISTS (
    SELECT 1
    FROM placement.students s
    WHERE s.student_id = sp.student_id
);
