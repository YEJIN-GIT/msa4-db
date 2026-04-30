CREATE DATABASE mydb;
USE mydb;

-- ------------
-- 테이블 생성
-- ------------
-- 유저 테이블
CREATE TABLE users (
  id            BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
  ,`name`       VARCHAR(50) NOT NULL
  ,gender       CHAR(1) NOT NULL COMMENT "M: 남자, F: 여자"
  ,created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
  ,updated_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
  ,deleted_at   DATETIME
);

-- 게시글 테이블
-- pk, 유저번호, 제목, 내용, 작성일, 수정일, 삭제일
CREATE TABLE posts(
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,user_id BIGINT UNSIGNED NOT NULL
	,title VARCHAR(50) NOT NULL
	,content VARCHAR(1000) NOT NULL
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME
);

-- ------------
-- 테이블 수정
-- ------------
-- 컬럼 추가
-- ALTER TABLE [테이블명] ADD COLUMN [컬럼명][타입][제약조건];
ALTER TABLE users ADD COLUMN age INT UNSIGNED NOT NULL;
-- 컬럼 데이터 타입의 수정
-- ALTER TABLE [테이블명] MODIFY COLUMN [컬럼명][타입][제약조건];
ALTER TABLE users MODIFY COLUMN age BIGINT NOT NULL;
-- 컬럼 삭제
-- ALTER TABLE [테이블명] DROP COLUMN [컬럼명];
ALTER TABLE users DROP COLUMN age;

-- 제약조건 (Constraint) 추가/삭제
ALTER TABLE posts ADD CONSTRAINT fk_posts_user_id FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE posts DROP CONSTRAINT fk_posts_user_id;

-- ------------
-- AUTO_INCREMENT 값 변경
-- 내가 사용할 수있는 최소값을 인식하고 자동으로 다음 숫자 부여
-- ------------
ALTER TABLE users AUTO_INCREMENT = 1;
INSERT INTO users(`name`, gender) VALUES ('HONG', 'F');

-- ------------
-- 테이블의 모든 데이터를 깨끗하게 제거하는 문
-- ------------
TRUNCATE TABLE users;

-- ------------
-- 테이블 삭제
-- ------------
DROP TABLE posts; -- FK 제약조건 경우 하위 테이블 먼저 삭제한다.
DROP TABLE users;

DROP TABLE posts, users;