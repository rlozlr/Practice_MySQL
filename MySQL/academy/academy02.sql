#academy에 student 테이블 만들기
CREATE TABLE student (
num INT,
name VARCHAR(30) NOT NULL,
age INT DEFAULT 20,
address VARCHAR(45),
major VARCHAR(45),
score INT,
PRIMARY KEY(num));

#테이블에 데이터 넣기
INSERT INTO student VALUES
(1111, "해리포터", 23, "Seoul", "Computer", 89),
(2222, "그레인저", 24, "Seoul", "English", 87),
(3333, "드레이코", 22, "Incheon", "Computer", 57),
(4444, "해그리드", 23, "Incheon", "English", 67),
(5555, "론위즐리", 21, "Suwon", "Computer", 97);

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

#score에 DEFAULT 0 속성추가
ALTER TABLE student MODIFY score INT DEFAULT 0;

#DEFAULT 0 확인을 위한 데이터 추가
INSERT INTO student (num, name, address, major)
VALUES (6666, "지니위즐리", "Seoul", "Computer"),
(7777, "롱바텀", "Seoul", "English"),
(8888, "러브굿", "Incheon", "Computer"),
(9999, "헤르미온느", "Incheon", "English"),
(1000, "말포이", "Suwon", "Computer");

# 데이터 오름차순/내림차순
SELECT * FROM student 
ORDER BY num ASC/DESC;

/*
UPDATE : 데이터 안의 값을 변경
UPDATE TABLE명 SET 변경COLUMN명 = 값, ...
WHERE 조건;
*/

#score 업데이트 해보기
UPDATE student SET score = 89
WHERE num = 1000; 
UPDATE student SET score = 79
WHERE num = 6666;
UPDATE student SET score = 100
WHERE num = 7777;
UPDATE student SET score = 48
WHERE num = 8888;
UPDATE student SET score = 20
WHERE num = 9999;

#student 테이블에서 컴퓨터학과의 학생만 출력
SELECT * FROM student
WHERE major = "Computer";

#student 테이블에서 나이가 20 초과인 학생을 출력
SELECT * FROM student
WHERE age >20;

#student 테이블에서 점수가 80 이상인 학생을 출력
SELECT * FROM student
WHERE score >= 80;

#student 테이블에서 address가 Seoul인 학생만 출력
SELECT * FROM student
WHERE address = "Seoul";

#student 테이블에서 socre가 70미만인 학생만 출력
SELECT * FROM student
WHERE score < 70;

/*student 테이블에서 score 가 70미만인 학생들의 
num, name, major, score만 출력*/
SELECT num, name, major, score 
FROM student
WHERE score < 70;

/*student 테이블에서 score 가 70미만인 학생들의 
name, score만 출력*/
SELECT name, score FROM student
WHERE score < 70;

/*student 테이블에서 score 가 90이상인 학생들의 
name만 출력*/
SELECT name FROM student
WHERE score >= 90;

/*student 테이블에서 score 가 90이상인 학생들의 
name을 '성적우수자' 로 출력*/
SELECT name AS '성적우수자' FROM student
WHERE score >= 90;

/*student 테이블에서 학과 목록 출력
중복제거(DISTINCT)하고 하나의 데이터만 출력
학과만 출력, 조건 X
학과를 별칭으로 출력*/
SELECT DISTINCT major AS '학과' 
FROM student;

/*
비교연산자 ( >, <, >=, <=, =, <> )
산술연산자( +, -, *, / )
산술연산에 NULL이 포함되어 있다면 NULL은 계산X -> NULL
논리연산에 (AND, OR, NOT)
우선순위 ()
*/

#student 테이블에서 모든 학생의 나이를 1살씩 업데이트 하시오.
UPDATE student SET age = age+1; 

#student 테이블에서 나이가  25살인 학생을 삭제하시오.
DELETE from student WHERE age = 25;

/*
조건
  - BETWEEN 70 AND 90 => 70~90 사이의 값 검색
  - IN (값1, 값2) => 값1 또는 값2인 값 검색
  - LIKE 값 => 값을 포함하는 값 검색
  - LIKE '김%' => 첫 글자가 김으로 시작하는 값을 검색
  - LIKE '%김' => 마지막 글자가 김으로 끝나는 값을 검색
  - LIKE '%김%' => 어디든 김으로 포함되면 값을 검색
*/

#1. major가 English인 학생 검색
SELECT * FROM student
WHERE major = "English";

/*2. major가 Computer이고, score가 70이상인 학생 검색
  - 전체 데이터가 아닌 이름만 검색
  - 필드명을 다른이름으로 변경*/
SELECT name AS "이름" FROM student
WHERE major = "Computer" AND score >=70;

#3. score가 70~90 사이인 자료 검색
SELECT * FROM student
WHERE score BETWEEN 70 AND 90;

#4. Suwon과 Seoul에 사는 학생만 검색
SELECT * FROM student
WHERE address IN ("Suwon", "Seoul");

#5. 말포이 major를 English로 변경
UPDATE student SET major = "English"
WHERE name = "말포이"; 

#6. 러브굿 데이터를 삭제
DELETE from student WHERE name = "러브굿";

#7. 이름에 위즐리가 들어간 학생검색
SELECT * FROM student
WHERE name LIKE "%위즐리%";
