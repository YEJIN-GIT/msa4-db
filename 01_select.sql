-- SELECT 문
-- DML 중의 하나로,  저장되어 있는 데이터를 조회하기 위해 사용하는 쿼리

-- `(백틱)으로 감싸면, 예약어와 컬럼이 같은 경우 컬럼으로 인식시킨다
SELECT
	`name`
	,gender
	,emp_id
FROM employees;

SELECT *
FROM employees;

-- WHERE 절 : 특정 컬럼의 값이 일치한 데이터만 조회
SELECT *
FROM employees
WHERE emp_id = 10009;

SELECT *
FROM employees
WHERE `name` = '조은혜';

SELECT *
FROM employees
WHERE birth >= '1990-01-01';  -- [MySQL] DATE타입을 문자열로 검색가능

SELECT *
FROM employees
WHERE fire_at IS NOT NULL;
