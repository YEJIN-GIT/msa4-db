-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT emp.emp_id
    ,emp.`name`
    ,tite.title_code
FROM employees emp
    INNER JOIN title_emps tite
        ON emp.emp_id = tite.emp_id
        AND emp.fire_at IS NULL -- 재직
        AND tite.end_at IS NULL -- 현 직급
;
-- 80054

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT emp.emp_id
    ,emp.gender
    ,sal.salary
FROM employees emp
    LEFT OUTER JOIN salaries sal
        ON emp.emp_id = sal.emp_id
        AND sal.end_at IS NULL  -- 현재 연봉
WHERE emp.fire_at IS NULL  -- 재직
;
-- 80054
-- <teacher>
SELECT emp.emp_id
    ,emp.gender
    ,sal.salary
FROM employees emp
    JOIN salaries sal
        ON emp.emp_id = sal.emp_id
WHERE   
    emp.fire_at IS NULL  -- 재직
AND sal.end_at IS NULL  -- 현재 연봉
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT emp.emp_id
    ,emp.`name`
    ,sal.start_at
    ,sal.salary
FROM employees emp
    LEFT OUTER JOIN salaries sal
        ON emp.emp_id = sal.emp_id
WHERE 
    emp.emp_id = '10010'
ORDER BY sal.start_at
;
-- 5

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT emp.emp_id
    ,emp.`name`
    ,dep.dept_name
FROM employees emp
    LEFT OUTER JOIN department_emps dee
        ON emp.emp_id = dee.emp_id
        AND dee.end_at IS NULL  -- 현 소속
    INNER JOIN departments dep
        ON dep.dept_code = dee.dept_code
WHERE
    emp.fire_at IS NULL  -- 재직
ORDER BY emp_id
;
-- 80054
-- <teacher>
SELECT emp.emp_id
    ,emp.`name`
    ,dept.dept_name
FROM employees emp
    JOIN department_emps depe
        ON emp.emp_id = depe.emp_id
        AND depe.end_at IS NULL  -- 현 소속
        AND emp.fire_at IS NULL  -- 재직
    JOIN departments dept
        ON depe.dept_code = dept.dept_code
        AND dept.end_at IS NULL  -- 현 부서
ORDER BY emp.emp_id
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT ran.emp_id
    ,ran.`name`
    ,ran.salary
    ,ran.sal_rank
FROM (
    SELECT emp.emp_id
        ,emp.`name`
        ,sal.salary
        ,RANK() OVER(ORDER BY sal.salary DESC) AS sal_rank
        -- , ROW_NUMER OVER (ORDER BY sal.salary DESC) AS sal_rank
    FROM employees emp
        LEFT OUTER JOIN salaries sal
            ON emp.emp_id = sal.emp_id
    WHERE 
        sal.end_at IS NULL  -- 현 연봉
    AND emp.fire_at IS NULL  -- 재직
    ) ran
WHERE
    ran.sal_rank <= 10 -- 상위 10위
ORDER BY sal_rank, emp_id
;
-- 10
-- <teacher>
SELECT emp.emp_id
    ,emp.`name`
    ,sal.salary
FROM employees emp
    JOIN salaries sal
        ON emp.emp_id = sal.emp_id
        AND sal.end_at IS NULL  -- 현 연봉
        AND emp.fire_at IS NULL  -- 재직
ORDER BY sal.salary DESC
LIMIT 10
;
-- <teacher> 속도개선1
SELECT emp.emp_id
    ,emp.`name`
    ,tmp_sal.salary
FROM employees emp
    JOIN (
        SELECT emp_id
            ,salary
        FROM salaries sal
        WHERE
            sal.end_at IS NULL  -- 현 연봉
        ORDER BY sal.salary DESC
        LIMIT 10
    ) tmp_sal
        ON emp.emp_id = tmp_sal.emp_id
        AND emp.fire_at IS NULL  -- 재직
ORDER BY tmp_sal.salary DESC
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT dep.dept_name
    ,emp.`name`
    ,emp.hire_at
FROM departments dep
  LEFT OUTER JOIN department_managers dem
      ON dep.dept_code = dem.dept_code
      AND dem.end_at IS NULL  -- 현 매니저
  LEFT OUTER JOIN employees emp
      ON emp.emp_id = dem.emp_id
      AND emp.fire_at IS NULL  -- 재직
WHERE
    dep.end_at IS NULL  -- 현 부서
;
-- 9

-- <teacher>
SELECT dept.dept_name
    ,emp.`name`
    ,emp.hire_at
FROM employees emp
    JOIN department_managers depm
        ON emp.emp_id = depm.emp_id
            AND emp.fire_at IS NULL
            AND depm.end_at IS NULL
    JOIN departments dept
        ON depm.dept_code = dept.dept_code
            AND dept.end_at IS NULL
ORDER BY dept.dept_code ASC
;
-- 8

-- 7. 현재 직급이 "부장"인 사원들의 / 연봉 평균을 출력해 주세요.
-- <teacher>
SELECT tie.emp_id
    ,CEILING(AVG(sal.salary)) AS sal_avg
FROM title_emps tie
    JOIN titles tit
        ON tie.title_code = tit.title_code
            AND tit.title = '부장'
            AND tie.end_at IS NULL
    JOIN salaries sal
        ON sal.emp_id = tie.emp_id
GROUP BY tie.emp_id
;


-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
SELECT emp.`name` -- 부장명
    ,CEILING(AVG(sal.salary)) AS sal_avg -- 자기 연봉 평균
FROM employees emp
    INNER JOIN salaries sal
        ON emp.emp_id = sal.emp_id        
    INNER JOIN title_emps tie
        ON emp.emp_id = tie.emp_id
    INNER JOIN titles tit
        ON tit.title_code = tie.title_code
WHERE
    emp.fire_at IS NULL  -- 재직
AND tie.end_at IS NULL  -- 현 직급
AND tit.title LIKE '%부장%' -- 직급 "부장"
GROUP BY emp.`name`, emp.emp_id
ORDER BY emp.`name`, emp.emp_id
;
-- 5323

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT emp.`name`
    ,emp.hire_at
    ,emp.emp_id
    ,dem.dept_code
FROM employees emp
    INNER JOIN department_managers dem
        ON emp.emp_id = dem.emp_id  -- 부서장직
ORDER BY emp_id, dem.dept_code
;
-- 73
-- <teacher> 한 사람이 여러 부서장 역임시 역임한 부서 다 나와야 함!
SELECT emp.`name`
    ,emp.hire_at
    ,emp.emp_id
    ,depm.dept_code
FROM department_managers depm
    JOIN employees emp
        ON depm.emp_id = emp.emp_id
ORDER BY depm.dept_code, depm.start_at
;


-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
SELECT tit.title
    ,CEILING(AVG(sal.salary)) sal_avg
FROM titles tit
    INNER JOIN title_emps tie
      ON tit.title_code = tie.title_code
    INNER JOIN employees emp
      ON emp.emp_id = tie.emp_id
    INNER JOIN salaries sal
      ON emp.emp_id = sal.emp_id
WHERE
    tie.end_at IS NULL  -- 현재 직급
AND sal.end_at IS NULL  -- 현 연봉
AND emp.fire_at IS NULL  -- 재직
GROUP BY tit.title_code
    ,tit.title
HAVING sal_avg >= 60000000
ORDER BY sal_avg DESC
;
-- 6
-- <teacher>
SELECT tit.title
    ,FLOOR(AVG(sal.salary)) sal_avg
FROM title_emps tie
    JOIN  salaries sal
        ON tie.emp_id = sal.emp_id
            AND tie.end_at IS NULL
            AND sal.end_at IS NULL
    JOIN titles tit
        ON tie.title_code = tit.title_code        
GROUP BY tie.title_code, tit.title -- <표준문법>group by 묶은것을 select에 나오도록!!
    HAVING AVG(sal.salary) >= 60000000
ORDER BY AVG(sal.salary) DESC
;


-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT tit.title
    ,tit.title_code
    ,emp.gender 
    ,COUNT(emp.emp_id) emp_f
FROM titles tit
    INNER JOIN title_emps tie
      ON tit.title_code = tie.title_code
    INNER JOIN employees emp
      ON emp.emp_id = tie.emp_id
WHERE
    tie.end_at IS NULL  -- 현재 직급
AND emp.fire_at IS NULL  -- 재직
-- AND emp.gender = 'F' -- 여자
GROUP BY tit.title
    ,tit.title_code
    ,emp.gender
ORDER BY tit.title_code DESC
    ,emp.gender
;
-- 16
-- <teacher>
SELECT tie.title_code
    ,emp.gender
    ,COUNT(*)
FROM employees emp
    JOIN title_emps tie
      ON emp.emp_id = tie.emp_id
          AND emp.fire_at IS NULL
          AND tie.end_at IS NULL
          -- AND emp.gender = 'F'
GROUP BY tie.title_code, emp.gender
ORDER BY emp.gender, tie.title_code
;
         