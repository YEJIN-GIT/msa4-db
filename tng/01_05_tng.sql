-- 1. 직급테이블의 모든 정보를 조회해주세요.
SELECT *
FROM titles
;

-- 2. 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요.
SELECT emp_id
FROM employees
WHERE 
    fire_at IS NULL -- 재직 사원
AND emp_id IN(
        SELECT salaries.emp_id
        FROM salaries
        WHERE salaries.end_at IS NULL -- 현재 급여
        AND salaries.salary <= 60000000
        AND salaries.emp_id = employees.emp_id
    )
;

-- 3. 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요.
SELECT emp_id
FROM employees
WHERE  
    fire_at IS NULL -- 재직 사원
AND emp_id IN(
        SELECT salaries.emp_id
        FROM salaries
        WHERE salaries.end_at IS NULL -- 현재 급여
        AND salaries.salary BETWEEN 60000000 AND 70000000
        AND salaries.emp_id = employees.emp_id
    )
;

-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
SELECT *
FROM employees
WHERE 
    fire_at IS NULL -- 재직 사원
AND emp_id IN(10001, 10005)
;

-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
SELECT title_code, title
FROM titles
WHERE 
    title LIKE '%사%'
;

-- 6. 사원 이름 오름차순으로 정렬해서 조회해 주세요.
SELECT `name` , emp_id
FROM employees
WHERE 
    fire_at IS NULL -- 재직 사원
ORDER BY `name`
;

-- 7. 사원별 전체 급여의 평균을 조회해 주세요.
SELECT
    emp_id
    , (SELECT FLOOR(AVG(salary)) -- 소수 버림
        FROM salaries 
        WHERE salaries.emp_id = employees.emp_id
    ) emp_sal_avg
FROM employees
WHERE
    fire_at IS NULL -- 재직 사원
;

-- 8. 사원별 전체 급여의 평균이 30,000,000 ~ 50,000,000인,
--   사원번호와 평균급여를 조회해 주세요.
SELECT
    emp_sal.emp_id
    ,emp_sal.sal_avg
FROM ( -- 사원별 평균급여 30,000,000원 ~ 50,000,000원
    SELECT emp_id
        ,AVG(salary) sal_avg
    FROM salaries
    GROUP BY emp_id
        HAVING sal_avg >= 30000000 AND sal_avg <= 50000000
    ) emp_sal    
WHERE 
    emp_sal.emp_id IN ( -- 재직 사원
        SELECT emp_id
        FROM employees
        WHERE fire_at IS NULL
    )
;

-- 9. 사원별 전체 급여 평균이 70,000,000이상인,
--   사원의 사번, 이름, 성별을 조회해 주세요.
SELECT emp_id
    ,`name`
    ,gender
FROM employees
WHERE 
    fire_at IS NULL -- 재직 사원
AND emp_id IN(
        SELECT emp_id
        FROM salaries 
        GROUP BY emp_id
            HAVING AVG(salary) >= 70000000
    )
;

-- 10. 현재 직급이 'T005'인,
--   사원의 사원번호와 이름을 조회해 주세요.
SELECT emp_id
    ,`name`
FROM employees
WHERE
    fire_at IS NULL -- 재직 사원
AND emp_id IN (
        SELECT emp_id
        FROM title_emps
        WHERE end_at IS NULL -- 현재 직급
        AND title_code = 'T005'
    )
;