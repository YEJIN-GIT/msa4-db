-- -----------------------------
-- INNER JOIN (교집합)
-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력
-- -----------------------------
-- 전 사원의 사번, 이름, 현재급여를 출력해주세요.
-- <현재 방식>  지금은 ANSI방식으로 사용할 것
SELECT emp.emp_id
    ,emp.`name`
    ,sal.salary
FROM employees emp
    INNER JOIN salaries sal
       ON emp.emp_id = sal.emp_id
          AND sal.end_at IS NULL
;

-- <예전 방법> 예전 Oralce에서 사용했었음
SELECT emp.emp_id
    ,emp.`name`
    ,sal.salary
FROM employees emp, salaries sal
WHERE 
    emp.emp_id = sal.emp_id
AND sal.end_at IS NULL
;

-- 재직중인 사원의 사번, 이름, 생일, 부서명
SELECT emp.emp_id
    ,emp.`name`
    ,emp.birth
    ,dept.dept_name
FROM employees emp
    INNER JOIN department_emps dee
        ON emp.emp_id = dee.emp_id
            AND dee.end_at IS NULL
    INNER JOIN departments dept
        ON dee.dept_code = dept.dept_code
;


-- -----------------------------
-- LEFT JOIN
-- -----------------------------
SELECT *
FROM employees emp
    LEFT JOIN salaries sal
        ON emp.emp_id = sal.emp_id
            AND sal.end_at IS NULL
;


-- -----------------------------
-- UNION
-- 두개 이상의 쿼리의 결과를 합쳐서 출력
-- UNION      (중복 레코드 제거)
-- UNION ALL  (중복 레코드 제거 안함)
-- -----------------------------
SELECT * FROM employees WHERE emp_id IN (1, 3)
UNION ALL
SELECT * FROM employees WHERE emp_id IN (1, 5);


-- -----------------------------
-- SELF JOIN
-- 같은 테이블 끼리 join
-- -----------------------------
SELECT
    emp.emp_id
    ,emp.`name`
    ,supe.*
FROM employees emp
    JOIN employees supe
        ON emp.sup_id = supe.emp_id
            AND emp.sup_id IS NOT NULL
;
