-- VIEW 생성
CREATE VIEW view_avg_salary_by_dept
AS
-- 부서별 현재 연봉 평균을 구해주세요.
-- 부서명(한글), 평균연보 출력
SELECT dep.dept_name
    ,CEILING(AVG(sal.salary)) AS avg_sal
FROM departments dep
    INNER JOIN department_emps dee
        ON dep.dept_code = dee.dept_code
            AND dep.end_at IS NULL -- 현 부서
            AND dee.end_at IS NULL -- 현 소속부서
    INNER JOIN salaries sal
        ON dee.emp_id = sal.emp_id
            AND sal.end_at IS NULL -- 현 급여
GROUP BY dep.dept_name
ORDER BY dep.dept_name
;

-- VIEW 조회하기
SELECT *
FROM view_avg_salary_by_dept
WHERE
    avg_sal >= 44000000
;

-- (사용)  통계치, 관리자페이지, 암호화데이터 복호화 보기
-- 속도가 느릴 수 있음

-- VIEW 삭제
DROP VIEW view_avg_salary_by_dept;