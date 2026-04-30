-- -------------
-- Transaction
-- -------------
-- Transaction 시작
START TRANSACTION;

INSERT INTO employees (
`name`
,birth
,gender
,hire_at
,created_at
,updated_at
)
VALUES (
'미어캣'
,'2020-01-23'
,'F'
,'2026-03-16'
,NOW()
,NOW()
);

-- COMMIT;
ROLLBACK;