-- INSERT문
-- DML중 하나로 신규 데이터를 저장하기 위해 사용하는 쿼리
-- INSERT INTO 테이블명 [(컬럼1, 컬럼2,...)]
-- VALUES (값1, 값2...);
INSERT INTO employees(
  `name`
  ,birth
  ,gender
  ,hire_at
  ,fire_at
  ,sup_id
  ,created_at
  ,updated_at
)
VALUES(
  '이예진'
  ,'2022-01-23'
  ,'F'
  ,NOW()
  ,NULL
  ,NULL
  ,NOW()
  ,NOW()
)
;

SELECT *
FROM employees
ORDER BY emp_id DESC
LIMIT 10;

-- emp_id 컬럼 AUTO_INCREMENT 자동 증가. 지정도 가능하지만 중복 가능


INSERT INTO employees(
  `name`
  ,birth
  ,gender
  ,hire_at
  ,fire_at
  ,sup_id
  ,created_at
  ,updated_at
)
VALUES ('이예진', '2022-01-23', 'F', NOW(), NULL, NULL, NOW(), NOW())
,('미어캣', '2022-01-23', 'F', NOW(), NULL, NULL, NOW(), NOW())
,('미어캣', '2022-01-23', 'F', NOW(), NULL, NULL, NOW(), NOW())
;


INSERT INTO employees(
  `name`
  ,birth
  ,gender
  ,hire_at
  ,fire_at
  ,sup_id
  ,created_at
  ,updated_at
  ,delete_at
)
SELECT 
  MAX(emp_id)
  ,'T001'
  ,NOW()
  ,NULL
  ,NULL
  ,NOW()
  ,NOW()
  ,NULL
FROM employees
;
