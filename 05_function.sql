-- 내장 함수

-- 데이터 타입 변환 함수
SELECT CAST(1234 AS CHAR(4));
SELECT CONVERT(1234, CHAR(4));

-- 제어 흐름 함수
SELECT
    'name'
    ,gender
    ,IF(gender = 'M', '남자', '여자') AS ko_gender
FROM employees
;

-- IFNULL(수식1, 수식2)
--  수식1이 null이면 수식2을 반환, 아니면 수식1을 반환
SELECT 
    IFNULL(fire_at, '재직중')
FROM employees
;

-- NULLIF(수식1, 수식2)
--  수식1과 수식2를 비교, 같으면 NULL 반환,
--  다르면 수식1을 반환
SELECT
    NULLIF(gender, 'M')
FROM employees
;

-- CASE ~ WHEN ~ ELSE ~ END
--  다중분기 위해 사용
SELECT
    CASE gender
        WHEN 'M' THEN '남자'
        WHEN 'Z' THEN '선택안함'
        ELSE '여자'
    END AS ko_gender
FROM employees
;

-- -----------------
-- 문자열 함수
-- DB함수보다 Javascript에서 처리 편리!
-- 리턴의 데이터타입이 문자열!
-- -----------------
-- 문자열 연결
SELECT CONCAT('안녕',' ','하세요');
SELECT CONCAT(`name`, gender) FROM employees;

-- 구분자로 문자열 연결
-- [MySQL] 자동 형변환 되지만 CAST로 형변환하여사용하자
SELECT CONCAT_WS(', ', '안녕', '하세요', '.');
SELECT CONCAT_WS(', ', `name`, gender) FROM employees;

-- 숫자에 자릿수(,) 및 소수점 자리수 표시
-- [MySQL] FORMAT 함수는 문자열로 반환함
SELECT FORMAT(salary, 1) FROM salaries;
-- 28,965,232.0
SELECT FORMAT(salary, 0) FROM salaries;
-- 28,965,232

-- 문자열의 왼쪽/오른쪽부터 길이만큼 잘라서 반환
SELECT LEFT('123456', 2);
-- 12
SELECT RIGHT('123456', 2);
-- 56

--  영어를 대/소문자로 변경
SELECT UPPER('asdDFs'), LOWER('asdDFs');

-- 문자열의 좌/우에 문자열 길이만큼 채울 문자열을 삽입
SELECT LPAD(emp_id, 10, '0') FROM employees;
-- 0000000001
SELECT RPAD(emp_id, 10, '0') FROM employees;
-- 1000000000

-- 좌/우 공백 제거
SELECT '  sdad ', TRIM('  sdad ');
SELECT LTRIM('  sdad '), RTRIM('  sdad ');
-- |sdad |  sdad|

-- 'abcdad' 양끝만 자른다
SELECT TRIM(LEADING 'ab' FROM 'abcdab');
-- cdab
SELECT TRIM(TRAILING 'ab' FROM 'abcdab');
-- abcd
SELECT TRIM(BOTH 'ab' FROM 'abcdab');
-- cd

-- [MySQL] 내장함수가 DBMS별로 다르다

-- 문자열을 시작위치에서 길이만큰 잘라서 반환
SELECT SUBSTRING('abcdef', 3, 2);
-- cd

-- 왼쪽부터 구분자가 횟수번째 만큼 나오면 그 이후 버림
SELECT SUBSTRING_INDEX('meerkat_MTML_CSS.html', '.' ,1) AS txt;
-- meerkat_MTML_CSS
SELECT SUBSTRING_INDEX('meerkat_MTML_CSS.html', '.' ,-1) AS txt;
-- html

-- -----------------
-- 수학 함수
-- 리턴의 데이터타입이 숫자!
-- -----------------
-- 올림, 반올림, 버림
SELECT CEILING(1.4), ROUND(1.5), FLOOR(1.6);
-- 2  2  1

-- 소수점을 기준으로 특정 자리수 까지 구하고 나머지는 버림
SELECT TRUNCATE(1.19, 1);
-- 1.1
SELECT TRUNCATE(1.19, 0);
-- 1


-- -----------------
-- 날짜 및 시간 관련  함수
-- -----------------
-- 현재 날자/시간 반환 (YYYY-MM-DD hh:mi:ss)
-- 데이터베이스가 설치시 타임존 기준
SELECT NOW();
-- 2026-04-27 12:10:38

-- 데이터 타입의 값을 `YYYY-MM-DD` 양식으로 변환
-- [MySQL] 년월일과 년월일시분초까지 나오는 데이터를 자동으로 날짜 비교가능함.
SELECT DATE(NOW());
-- 2026-04-27

-- 날짜1에 단위기간에 따라 더한 날짜/시간을 반환
SELECT ADDDATE(NOW(), INTERVAL 1 YEAR);
-- 2027-04-27 12:20:31
SELECT ADDDATE(NOW(), INTERVAL -1 YEAR);
-- 2025-04-27 12:33:09
SELECT ADDDATE(NOW(), INTERVAL 1 MONTH);
-- 2026-05-27 12:33:38
SELECT ADDDATE(NOW(), INTERVAL 1 DAY);
-- 2026-04-28 12:34:03
SELECT ADDDATE(NOW(), INTERVAL 1 HOUR);
-- 2026-04-27 13:34:15
SELECT ADDDATE(NOW(), INTERVAL 1 MINUTE);
-- 2026-04-27 12:35:35
SELECT ADDDATE(NOW(), INTERVAL 1 SECOND);
-- 2026-04-27 12:35:07
SELECT ADDDATE(NOW(), INTERVAL 1 MICROSECOND);
-- 2026-04-27 12:35:18.000001

-- -----------------
-- 집계함수
-- -----------------

-- -----------------
-- 순위함수
-- 퍼퍼먼스 이슈있음
-- -----------------
-- RANK() OVER(ORDER BY 컬럼 DESC/ASC)
--  지정한 컬럼을 기준으로 순위를 매겨 반환
--  동일한 값이 있을 경우 동일한 순위를 부여 (예. 1 1 3 4 5 6 7 8 9 10)
SELECT 
    emp_id
    ,salary
    ,RANK() OVER(ORDER BY salary DESC) AS `rank`
FROM salaries
WHERE
  end_at IS NULL
LIMIT 10
;

-- ROW_NUMBER() OVER(ORDER BY 속성명 DESC/ASC)
--  레코드에 순위를 매겨 반환
--  동일한 값이 있는 경우에도 각 행에 고유한 순위를 부여 (예. 1 2 3 4 5 6 7 8 9 10)
SELECT 
    emp_id
    ,salary
    ,ROW_NUMBER() OVER(ORDER BY salary DESC) AS `row_rank`
FROM salaries
WHERE
  end_at IS NULL
LIMIT 10
;