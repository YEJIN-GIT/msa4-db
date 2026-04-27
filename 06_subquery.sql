-- SubQuery
-- 쿼리속도 저하가 발생할 가능성이 높으므로 주의해서 사용
-- -----------------
-- WHERE절에서 사용
-- -----------------
-- 1. 단일 행 서브쿼리
--    서브쿼리가 단일 행 비교 연산자와 함께 사용할 때 
--    반드시 서브쿼리의 결과 수가 1건 이하여야 함 -> 2건 이상일 경우 오류 발행
-- D001 부서장의 사번과 이름을 출력
SELECT
    employees.emp_id
    ,employees.`name`
FROM employees
WHERE
    employees.emp_id = (
    SELECT
        department_managers.emp_id
    FROM department_managers
    WHERE
        department_managers.dept_code = 'D001'
        AND department_managers.end_at IS NULL
    )
;

-- 다중 행 서브쿼리
--    서브쿼리가 2건 이상을 반환할 경우
--    반드시 다중 행 비교연산자(IN, ALL, ANY, SUME, EXISTS 등)을  사용
-- 현재 부서장인 사번과 이름을 출력
SELECT
    employees.emp_id
    ,employees.`name`
FROM employees
WHERE 
    employees.emp_id IN (
        SELECT
            emp_id
        FROM department_managers
        WHERE
            department_managers.end_at IS NULL
        )
;


-- 다중 열 서브쿼리

-- 현재 D002의 부서장이 해당 부서에 소속된 날짜를 출력
SELECT
    start_at
FROM department_emps
WHERE
    (department_emps.emp_id, department_emps.dept_code) IN (
        SELECT
            department_managers.emp_id
            ,department_managers.dept_code
        FROM department_managers
        WHERE department_managers.dept_code = 'D002'
        AND department_managers.end_at IS NULL
    )
; 

-- 연관 서브쿼리
--  서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리
-- 부서장직을 지냈던 경력이 있는 사원의 정보를 출력
SELECT 
    employees.*
FROM employees
WHERE
    employees.emp_id IN (
        SELECT department_managers.emp_id
        FROM department_managers
        WHERE
            department_managers.emp_id = employees.emp_id
)
;


-- -----------------
-- SELECT절에서 사용
-- -----------------
-- 사원별 역대 전체 급여 평균
SELECT
    emp.emp_id
    ,(
        SELECT AVG(sal.salary)
        FROM salaries sal
        WHERE sal.emp_id = emp.emp_id
    ) avg_sal
FROM employees emp
;

-- -----------------
-- FROM절에서 사용
-- -----------------
-- 서브쿼리가 올라갈 메모리 공간 고려 필요
SELECT
    tmp.*
FROM (
    SELECT
        emp.emp_id
        ,emp.`name`
    FROM employees
    ) tmp
;

-- -----------------
-- INSERT문에서 사용
-- -----------------
INSERT INTO title_emps (
    emp_id
    ,title_code
    ,start_at
) VALUES (
    (SELECT MAX(emp_id) FROM employees)
    ,'T001'
    ,DATE(NOW())
)
;

-- -----------------
-- UPDATE문에서 사용
-- -----------------
UPDATE title_emps
SET
    title_emps.end_at = (
        SELECT employees.fire_at
        FROM employees
        WHERE
            employees.emp_id = 100000
    )
WHERE
    title_emps.emp_id = 100000
    AND title_emps.end_at IS NULL
;
