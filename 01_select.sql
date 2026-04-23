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

-- 출생년도가 1990년인 사원을 조회해주세요.
SELECT  *
FROM employees
WHERE birth >= '1990-01-01' 
  AND birth <= '1990-12-31';

-- 이름이 '김철수' 또는 '정유리'인 사원을 조회해주세요.
SELECT *
FROM employees
WHERE `name` = '조은혜' 
   OR `name` = '정유리';

-- 1990년 출생이거나, 이름이 '정유리'인 사원을 출력해주세요.
SELECT *
FROM employees
WHERE (birth >= '1990-01-01' AND birth <= '1990-12-31')
   OR `name` = '정유리';

-- BETWEEN 연산자 : 저정한 범위 내의 데이터를 조회
SELECT  *
FROM employees
WHERE birth BETWEEN '1990-01-01'  AND birth <= '1990-12-31';
-- [MySQL] 6버전 이전에는 AND연산자 보다 BETWEEN이 느렸다.

-- 사원번호가 10005, 10010인 사원을 조회해주세요.
SELECT *
FROM employees
WHERE emp_id = 10005
   OR emp_id = 10010;
-- [MySQL] 테이터타입이 숫자인데 '10005' 문자로 해도 자동 형변환 되지만, 스프링부트 사용시 에러 발생함.

-- IN 연산자 : 다수의 지정하 값과 일치하는 데이터 조회
SELECT *
FROM employees
WHERE emp_id IN(10005, 10010);
-- [MySQL] 과거버전에서 IN연산자가  느리지만 최신버전은 차이 없다.

-- LIKE 절 : 무자열의 내용을 조회
-- %: 글자수와 상관없이 조회해할 경우 사용
SELECT *
FROM employees
WHERE `name` LIKE '%우';
-- 이름에 우가 포함되어 있는 사원 조회
SELECT *
FROM employees
WHERE `name` LIKE '%우%';
-- _: 언더바의 개수만큰 글자수를 허용해서 조회

SELECT *
FROM employees
WHERE `name` LIKE '_우_';

-- ORDER BY 절 : 데이터를 정렬
SELECT *
FROM employees
ORDER BY `name`, birth DESC;

-- LIMIT 키워드, OFFSET 키워드
-- 출력 개수를 제한
-- 사번 오름차순으로 정렬된 상위 10명 조회해주세요.
-- 조회 결과에서 21번째부터 10개를 조회
SELECT *
FROM employees
ORDER BY emp_id
-- LIMIT 10 OFFSET 20
LIMIT 20, 10
;

-- 집계함수
-- SUM(컬럼) : 해당 컬럼의 합계를 출력
-- MAX(컬럼) : 해당 컬럼의 값 중 최대값을 출력
-- MIN(컬럼) : 해당 컬럼의 값 중 최소값을 출력
-- AVG(컬럼) : 해당 컬럼의 평균을 출력
SELECT SUM(salary) AS sum_sal
  , MAX(salary)	max_sal
  , MIN(salary)
  , AVG(salary)
FROM salaries
WHERE end_at IS NULL
;
-- COUNT(컬럼 || *) : 검색 결과의 총레코드 수를 출력
-- *: 총 레코드 수
SELECT COUNT(*)
FROM employees
;
-- 컬럼: 검색 결과 중, 해당 컬럼의 값이 NULL이 아닌 레코드의 총수 출력
SELECT COUNT(fire_at)
FROM employees
;

-- 현재 받고있는 급여 중 가장 많이 받는 급여와, 가정 적게 받는 급여를 출력해주세요.
SELECT MAX(salary)
	, MIN(salary)
FROM salaries
WHERE end_at IS NULL
;

-- DISTINCT 키워드 : 검색결과에서 중복되는 레코드 없이 조회
SELECT DISTINCT emp_id
FROM salaries
;

-- GROUP BY 절 : 그룹으로 묶어서 조회
-- 직책별 사원수
SELECT 
  -- SELECT절에 작성하는 컬럼은 GROUP BY절에서 사용한 컬럼과 집계함수만 작성(표준 문법)
  title_code
  , COUNT(*) AS cnt
FROM title_emps
WHERE end_at IS NULL
GROUP BY title_code
;
-- [MySQL] 예전버전에는 group by절에 없는 컬럼사용해도 오류 발생하지 않는 문제 있었다.

-- 직책 코드에 `02`가 포함된 직책별 사원수
SELECT title_code
  ,COUNT(*) AS cnt
FROM title_emps
WHERE end_at IS NULL
GROUP BY title_code
HAVING title_code LIKE '%02%'
;

-- 직책별 사원수중, 10000명 이상인 직책의 사원수를 출력
SELECT title_code
  , COUNT(*) AS cnt
FROM title_emps
WHERE end_at IS NULL
GROUP BY title_code
HAVING cnt >= 10000
;
