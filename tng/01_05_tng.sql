-- 1. 직급테이블의 모든 정보를 조회해주세요.
SELECT *
FROM titles
ORDER BY title_code
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
-- <teacher>
SELECT emp_id
FROM salaries
WHERE
    end_at IS NULL
AND salary <= 60000000
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
-- <teacher>
SELECT emp_id
FROM salaries
WHERE
    end_at IS NULL
AND salary BETWEEN 60000000 AND 70000000
;


-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
SELECT *
FROM employees
WHERE 
    fire_at IS NULL -- 재직 사원
AND emp_id IN(10001, 10005)
;
-- <teacher>
SELECT *
FROM employees
WHERE 
    emp_id = 10001
OR emp_id = 10005
;


-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
SELECT title_code, title
FROM titles
WHERE 
    title LIKE '%사%'
;
-- '_사_' 세글자 중  두번째 `사`
-- '_사%' 두번재 글자 `사`


-- 6. 사원 이름 오름차순으로 정렬해서 조회해 주세요.
SELECT `name` , emp_id
FROM employees
WHERE 
    fire_at IS NULL -- 재직 사원
ORDER BY `name`
;
-- <teacher>
SELECT *
FROM employees
ORDER BY `name`, birth
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
-- <teacher>
SELECT emp_id
    ,CEILING(AVG(salary)) avg_sal
FROM salaries
GROUP BY emp_id
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
-- <teacher>
SELECT emp_id
    ,AVG(salary) sal_avg
FROM salaries
GROUP BY emp_id
    HAVING AVG(salary) BETWEEN 30000000 AND 50000000
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
-- <teacher>
SELECT emp.emp_id
    ,emp.`name`
    ,emp.gender
FROM employees emp
WHERE 
    emp_id IN(
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
-- <teacher>
SELECT emp.emp_id
    ,emp.`name`
FROM employees emp
WHERE
    emp.emp_id IN (
        SELECT tie.emp_id
        FROM title_emps tie
        WHERE
            tie.end_at IS NULL
        AND tie.title_code = 'T005'
    )
;