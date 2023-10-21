# DB school
CREATE DATABASE school;

USE school

# student 테이블 만들기
CREATE TABLE student (
std_num VARCHAR(10),
std_name VARCHAR(20) NOT NULL,
std_major VARCHAR(20),
std_term INT,
std_point INT,
PRIMARY KEY(std_num));

# course 테이블 만들기
CREATE TABLE course (
co_code VARCHAR(11),
co_name VARCHAR(20) NOT NULL,
co_professor VARCHAR(20),
co_point INT DEFAULT 3,
co_time INT,
co_timetable VARCHAR(40),
PRIMARY KEY(co_code));

# attend 테이블 만들기
CREATE TABLE attend (
at_num INT Auto_Increment,
at_std_num VARCHAR(10),
at_co_code VARCHAR(11),
at_year INT,
at_term INT,
at_mid INT DEFAULT 0,
at_final INT DEFAULT 0,
at_attend INT DEFAULT 0,
at_hw INT DEFAULT 0,
at_repetition VARCHAR(1) DEFAULT "n",
at_score VARCHAR(4),
PRIMARY KEY(at_num),
FOREIGN KEY(at_std_num)
REFERENCES student(std_num),
FOREIGN KEY(at_co_code)
REFERENCES course(co_code));

# 학생 데이터 넣기
insert into student values
('2019160123','전봉준','컴퓨터공학과',2,64),
('2019456001','강길동','디자인',3,60),
('2020123001','강나래','화학공학',1,21),
('2020123020','박철수','화학공학',1,20),
('2020160001','강철수','컴퓨터공학',1,20),
('2020160002','나영희','컴퓨터공학',1,19);

# 코스 데이터 넣기
insert into course values
('2020ipc001','컴퓨터개론','유관순',2,2,'화1A,1B,2A,2B'),
('2020ipc002','기초전기','이순신',3,4,'월1A,1B,2A목1A,1B,2A'),
('2020msc001','대학수학기초','홍길동',3,3,'월1A,1B,2A수1A,1B,2A'),
('2020msc002','프로그래밍일반','임꺽정',3,3,'월1A,1B,2A목1A,1B,2A');
​
# 수강 데이터 넣기
insert into attend(at_std_num, at_co_code) values
('2020160001','2020msc001'),
('2020160002','2020msc001'),
('2019160123','2020msc002'),
('2019456001','2020msc002'),
('2020123001','2020ipc001'),
('2020123020','2020ipc001'),
('2019456001','2020ipc002'),
('2019160123','2020ipc002'),
('2020160001','2020msc002'),
('2020160002','2020msc002'),
('2019160123','2020msc001'),
('2019456001','2020msc001'),
('2020123001','2020msc001'),
('2020123020','2020msc001'),
('2019456001','2020msc002'),
('2019160123','2020msc002');

# at_year을 2023으로 업데이트
UPDATE attend SET at_year = 2023;

# at_term은 at_num 1~8 =>1 / 9~16 =>2 로 업데이트 (IF문 이용)
UPDATE attend SET at_term = (
IF(at_num <= 8, 1, 2)
);

/*
at_term 1~8 => at_mid, at_fianl, at_hw, at_attend 업데이트
(at_mid : 40 / at_final : 40 / at_hw : 10 / at_attend : 10)
*/
UPDATE attend SET 
at_mid = 30,
at_final = 20,
at_hw = 3,
at_attend = 5
WHERE  at_num = 1;

UPDATE attend SET 
at_mid = 20,
at_final = 25,
at_hw = 10,
at_attend = 10
WHERE  at_num = 2;

UPDATE attend SET 
at_mid = 40,
at_final = 15,
at_hw = 8,
at_attend = 4
WHERE  at_num = 3;

UPDATE attend SET 
at_mid = 29,
at_final = 10,
at_hw = 7,
at_attend = 8
WHERE  at_num = 4;

UPDATE attend SET 
at_mid = 23,
at_final = 33,
at_hw = 6,
at_attend = 9
WHERE  at_num = 5;

UPDATE attend SET 
at_mid = 40,
at_final = 40,
at_hw = 10,
at_attend = 10
WHERE  at_num = 6;

UPDATE attend SET 
at_mid = 39,
at_final = 22,
at_hw = 1,
at_attend = 3
WHERE  at_num = 7;

UPDATE attend SET 
at_mid = 17,
at_final = 40,
at_hw = 10,
at_attend = 7
WHERE  at_num = 8;

/*
at_score 1학기만 채우기
at_mid+at_final+at_attend+at_hw >= 90 'A'
at_mid+at_final+at_attend+at_hw >= 80 'B'
at_mid+at_final+at_attend+at_hw >= 70 'C'
at_mid+at_final+at_attend+at_hw >= 60 'D'
나머지는 F
*/

UPDATE attend SET at_score = (
CASE
WHEN (at_mid+at_final+at_attend+at_hw) >= 90
THEN "A"
WHEN (at_mid+at_final+at_attend+at_hw) >= 80
THEN "B"
WHEN (at_mid+at_final+at_attend+at_hw) >= 70
THEN "C"
WHEN (at_mid+at_final+at_attend+at_hw) >= 60 
THEN "D"
ELSE "F"
END
) WHERE at_term = 1;

/*
at_repetition 재수강여부 채우기 1학기만 채우기
at_score가 F이거나, at_attend가 3이하면 y
*/
UPDATE attend SET at_repetition =
IF(at_score ='F' OR at_attend <= 3, 'y', 'n')
WHERE at_term = 1;

# 2학기 score null로 변경
UPDATE attend SET at_score = null 
WHERE at_term = 2;

# score별 인원 수 집계
SELECT at_score AS "학점", COUNT(at_score) AS "인원수"
FROM attend
GROUP BY at_score
HAVING at_score IS NOT NULL
ORDER BY at_score;


# 재수강 인원 집계
SELECT COUNT(at_repetition)  AS "재수강 인원수"
FROM attend
WHERE at_repetition = "y";

# INNER JOIN을 활용하여 재수강자 이름을 출력
SELECT s.std_name FROM student s
JOIN attend a 
ON s.std_num = a.at_std_num
WHERE a.at_repetition = 'y';

SELECT * FROM student s
JOIN attend a 
ON s.std_num = a.at_std_num;

SELECT * FROM student s
JOIN attend a 
ON s.std_num = a.at_std_num
JOIN course c
ON c.co_code = a.at_co_code
ORDER BY a.at_num;

/*
at_score가 A인 학생의 명단을 출력
(학번, 이름, 학점)
*/ 
SELECT std_num AS "학번", std_name AS "이름", at_score AS "학점"
FROM student 
JOIN attend 
ON std_num = at_std_num
WHERE at_score = 'A';

/*
at_repetition이 y인 학생의 명단 출력
(학번, 이름, 재수강 여부)
*/
SELECT std_num AS "학번", std_name AS "이름", at_repetition AS "재수강 여부"
FROM student 
JOIN attend  
ON std_num = at_std_num
WHERE at_repetition = 'y';

