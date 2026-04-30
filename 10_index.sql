-- ---------------
-- INDEX
-- ---------------
-- INDEX 확인
SHOW INDEX FROM salaries;

-- 0.031초 -- INDEX --> 0초
SELECT * FROM employees WHERE `name` = '조은혜';

-- INDEX 생성
ALTER TABLE employees ADD INDEX idx_employees_name (`name`);
SHOW INDEX FROM employees;

-- 0.000초
SELECT * FROM employees WHERE `name` = '조은혜';

-- INDEX 삭제
ALTER TABLE employees DROP INDEX idx_employees_name;
