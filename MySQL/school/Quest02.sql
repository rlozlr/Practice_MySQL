#1. 학번이 2020으로 시작하는 학생들의 학번, 이름 학과를 출력
SELECT std_num AS "학번", std_name AS "이름", std_major AS "학과"
FROM student
WHERE std_num LIKE "2020%";

#2. 프로그래밍 일반 과목을 듣는 학생 명단 출력
#    학번, 이름, 학과
SELECT std_num AS "학번", std_name AS "이름", std_major AS "학과"
FROM attend
JOIN student
ON std_num = at_std_num
JOIN course
ON co_code = at_co_code
WHERE co_name = "프로그래밍일반";

/*
3. 홍길동 교수가 강의하는 과목을 듣는 학생 명단
   학번, 이름, 학과, 수강과목, 담당교수
*/
SELECT std_num AS "학번", std_name AS "이름", std_major AS "학과",
co_name AS "과목명", co_professor AS "담당교수"
FROM attend
JOIN student
ON std_num = at_std_num
JOIN course
ON co_code = at_co_code
WHERE co_professor = "홍길동";

/*
4. 전봉준이 획득한 학점(co_point) 합계 
    => 2학기는 미포함, 미이수학점은 제외
*/
SELECT std_name AS "학생명", SUM(co_point) AS "획득 학점" FROM attend
JOIN student
ON std_num = at_std_num
JOIN course
ON co_code = at_co_code
WHERE at_term = 1 AND at_repetition = "n"
AND std_name = "전봉준";

/*
5. 재수강자 점수(중간+기말+출석+과제) 합계
    => 학번, 이름, 학과, 과목, 점수합계
*/
SELECT std_num AS "학번", std_name AS "이름", std_major AS "학과",
co_name AS "과목명", (at_mid+at_final+at_attend+at_hw) AS "점수합계"
FROM attend
JOIN student
ON std_num = at_std_num
JOIN course
ON co_code = at_co_code
WHERE at_repetition = "y";

# 데이터 추가
INSERT INTO student VALUES
("202016003", "김순이", "컴퓨터공학", 1, 25),
("202016004", "홍순길", "디자인", 1, 20);

/*
student 값을 추가하고, 조인 후 수강하고 있지 않는 학생의 명단을 출력
    => student 테이블에는 있지만, attend 테이블에는 없는 자료를 추출 
    LEFT JOIN 
    (INNER) JOIN : 두 테이블에 일치하는 데이터만 대상
*/
SELECT s.* FROM student s
LEFT JOIN attend
ON std_num = at_std_num
WHERE at_num IS NULL;