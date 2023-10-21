#데이터베이스 생성
CREATE DATABASE academy;

USE academy

/*
테이블 생성
CREATE TABLE 테이블명(
필드명1 속성1 속성2,
필드명2 속성1 속성2,
...
primary key(필드명));
*/

#테이블 생성
CREATE TABLE sample_std (
num INT NOT NULL auto_increment,
name VARCHAR(45) NOT NULL,
tel VARCHAR(45),
addr VARCHAR(45),
PRIMARY KEY(num));

/*
테이블 안에 데이터 추가 - INSERT 구문
INSERT INTO TABLE명(속성1, 속성2 ...)
VALUES (값1, '값2' ...);
문자는 '', 또는 ""
*/

#테이블 안에 데이터 추가
INSERT INTO sample_std(name, tel, addr)
VALUES ("아이언맨", "1111", "서울"),
("스네이프", "2222", "인천"),
("덤블도어", "3333", "서울"),
("해그리드", "4444", "인천"),
("맥고나걸", "5555", "부산");

/*
ALTER => 테이블의 구조를 변경할 경우
  - 칼럼 추가 (ADD)
     ALTER TABLE TABLE명 ADD 추가COLUMN명 속성...;
  - 칼럼 변경 (MODIFY) : 속성만 변경 (이름변경 X)
    ALTER TABLE TABLE명 MODIFY 변경COLUMN명 속성(모든속성);
  - 칼럼 변경 (CHANGE) : 이름도 변경
    ALTER TABLE TABLE명 CHANGE 이전COLUMN명 바꿀COLUMN명 속성나열(모든속성);
  - 칼럼 삭제 (DROP) : 
    ALTER TABLE TABLE명 DROP 삭제COLUMN명;  
  - 테이블 이름 변경 (RENAME)
    ALTER TABLE 변경전TABLE명 RENAME 변경할TABLE명; 
*/

/*
UPDATE : 데이터 안의 값을 변경
UPDATE TABLE명 SET 변경COLUMN명 = 값, ...
WHERE 조건;
*/

/*
SELECT : 데이터를 조회할 때 사용
SELECT * FROM TABLE명; : 모든 데이터 조회
WHERE 조건 EX) WHERE major = Computer
*/

/*
비교연산자 ( >, <, >=, <=, =, <> )
산술연산자( +, -, *, / )
산술연산에 NULL이 포함되어 있다면 NULL은 계산X -> NULL
논리연산에 (AND, OR, NOT)
우선순위 ()
*/

