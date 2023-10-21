#1. test1 테이블 생성
CREATE TABLE test1 (
num INT Auto_Increment,
name VARCHAR(30) NOT NULL,
age INT DEFAULT 20,
address VARCHAR(45),
PRIMARY KEY(num));

#2. 데이터 입력
INSERT INTO test1( name, age, address )
VALUES ("홍길동", 23, "서울"),
("강길순", 24, "인천"),
("이순신", 22, "서울"),
("강감찬", 23, "인천"),
("유관순", 21, "서울");

#3. 인천에 사는 학생을 검색
SELECT * FROM test1
WHERE address = "인천";


#4. 나이가 22이상인 학생을 검색
SELECT * FROM test1
WHERE age >= 22;

#5. 나이가 22미만인 학생의 나이를 1살씩 증가
UPDATE test1 SET age = age+1
WHERE age<22;


#6. 강씨 학생을 검색
SELECT * FROM test1
WHERE name LIKE "강%";


#7. score 칼럼을 추가하고, 기본값을 0으로 설정
ALTER TABLE test1 ADD 
score INT DEFAULT 0;

#8. update 구문을 사용하여 각 학생의 score를 설정
UPDATE test1 SET score = 97
WHERE num = 1;
UPDATE test1 SET score = 88
WHERE num = 2;
UPDATE test1 SET score = 76
WHERE num = 3;
UPDATE test1 SET score = 55
WHERE num = 4;
UPDATE test1 SET score = 100
WHERE num = 5;

#9. update한 score의 값이 90이상인 학생의 이름을 검색
SELECT name FROM test1
WHERE score >= 90;