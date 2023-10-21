#1. at_mid, at_final, at_attend, at_hw 값 업데이트 (40, 40, 10, 10)
UPDATE attend SET 
at_mid = 39,
at_final = 39,
at_attend = 2,
at_hw = 9
WHERE at_num in (8, 18, 26);

UPDATE attend SET 
at_mid = 16,
at_final = 27,
at_attend = 9,
at_hw = 10
WHERE at_num in (7, 17, 27);

UPDATE attend SET 
at_mid = 35,
at_final = 35,
at_attend = 9,
at_hw = 9
WHERE at_num in (22, 23, 24);

UPDATE attend SET 
at_mid = 25,
at_final = 25,
at_attend = 8,
at_hw = 8
WHERE at_num in (2, 4, 12, 14);

UPDATE attend SET 
at_mid = 47,
at_final = 27,
at_attend = 6,
at_hw = 6
WHERE at_num in (1, 11, 21);

UPDATE attend SET 
at_mid = 10,
at_final = 10,
at_attend = 10,
at_hw = 10
WHERE at_num in (13, 16, 19);

UPDATE attend SET 
at_mid = 40,
at_final = 40,
at_attend = 10,
at_hw = 10
WHERE at_num in (10, 20);

UPDATE attend SET 
at_mid = 20,
at_final = 20,
at_attend = 5,
at_hw = 5
WHERE at_num in (5, 15, 25);

UPDATE attend SET 
at_mid = 30,
at_final = 30,
at_attend = 7,
at_hw = 7
WHERE at_num in (3, 6, 9);

/*
2. 합계값을 이용하여 at_score 업데이트 (>=90 A / >=80 B / >=70 C / >=60 D / F)
   (at_mid + at_final + at_attend + at_hw)
*/
UPDATE attend SET at_score = (
CASE
WHEN (at_mid + at_final + at_attend + at_hw) >=90 
THEN "A"
WHEN (at_mid + at_final + at_attend + at_hw) >=80 
THEN "B"
WHEN (at_mid + at_final + at_attend + at_hw) >=70 
THEN "C"
WHEN (at_mid + at_final + at_attend + at_hw) >=60 
THEN "D"
ELSE "F"
END);

#3. at_pass(p/f) : at_score가 A또는 B면 p(pass) / 아니면 f(fail)
UPDATE attend SET at_pass = (
IF(at_score = "A" || at_score = "B", "p", "f")
);

#4. at_pass의 default 값을 f로 변경
ALTER TABLE attend MODIFY at_pass VARCHAR(1) DEFAULT "f"; 

/*
5. at_repetition 값 업데이트 (y/n)
   at_score 가 F이거나 at_attend가 3이하인 값은 y 아니면 n
*/
UPDATE attend SET at_repetition = (
IF(at_score = "F" || at_attend <=3, "y", "n")
);

/*
1. 김영철 수강과목 출력
대학수학(1) => 출력 / 과목(학기)
*/
SELECT
CONCAT(su.su_title,"(",c.co_term,")") AS "수강과목(학기)"
FROM student s
JOIN attend a ON a.at_st_num = s.st_num
JOIN course c ON c.co_num = a.at_co_num
JOIN subject su ON su.su_num = c.co_su_num
WHERE s.st_name = '김영철'; 


# student  테이블에 st_name에 인덱스 추가
ALTER TABLE student ADD INDEX idx_name(st_name);
-- CREATE INDEX idx_name ON student(st_name);

# student  테이블에 st_name에 인덱스 삭제
ALTER TABLE student DROP INDEX idx_name;

#VIEW 생성
/* 
1학기 수업을 듣는 학생을 검색 1_term_view
학번, 이름 조건 : 1학기 수강자
중복제거 
*/

CREATE VIEW 1_term_view AS
SELECT st_num, st_name 
FROM student, course
WHERE co_term = 1;

-- 기존 뷰 수정(삭제 후 재설정)
CREATE OR REPLACE VIEW 1_term_join_view AS
SELECT DISTINCT st_num, st_name
FROM student
JOIN attend ON at_st_num = st_num
JOIN course ON at_co_num = co_num
WHERE co_term = 1;