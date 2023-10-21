#1. F를 받은 학생 명단(학번, 이름, 학과)
SELECT std_num AS "학번", std_name AS "이름", std_major AS "학과"
FROM student 
JOIN attend  
ON std_num = at_std_num
WHERE at_score = 'F';

#2. A학점을 받은 학생들의 (학번, 이름, 과목) => 테이블 3개 JOIN
SELECT std_num AS "학번", std_name AS "이름", co_name AS "과목"
FROM student 
JOIN attend  
ON std_num = at_std_num
JOIN course
ON co_code = at_co_code
WHERE at_score = 'A';

/*
3. A학점을 받은 학생들의 (학번, 이름, 과목, 성적) 
   - 성적(mid+final+attend+hw) AS '성적'
*/
SELECT std_num AS "학번", std_name AS "이름", co_name AS "과목", 
(at_mid + at_final + at_attend + at_hw) AS "성적"
FROM attend
JOIN student
ON std_num = at_std_num
JOIN course
ON co_code = at_co_code
WHERE at_score = "A";


/*
4. 과목(co_name)별 중간, 기말, 출석 과제 합계
   - 과목별 오름차순\

프로그래밍일반 35 30 10 10
...
합계 60 60 20 20
*/
SELECT IF(co_name IS NULL, "합계",co_name) AS "과목명",
SUM(at_mid) AS "중간", SUM(at_final) AS "기말", SUM(at_attend) AS "출석", SUM(at_hw) AS "과제"
FROM attend
JOIN course
ON co_code = at_co_code
GROUP BY co_name WITH ROLLUP
ORDER BY GROUPING(co_name) ASC;

/*
5. 학점별 중간, 기말, 출석 과제 평균
    - null은 제외, 학점별 오름차순
*/
SELECT IF(at_score IS NULL, "평균", at_score) AS "학점",
ROUND(AVG(at_mid),0) AS "중간", ROUND(AVG(at_final),0) AS "기말", ROUND(AVG(at_attend),0) AS "출석", ROUND(AVG(at_hw),0) AS "과제"
FROM attend
WHERE at_score IS NOT NULL
GROUP BY at_score WITH ROLLUP
ORDER BY GROUPING(at_score) ASC;

#6. 강철수가 수강하고있는 과목들의 이름, 교수명 출력
SELECT std_name AS "학생명", co_name AS "과목명", co_professor AS "담당교수" 
FROM student
JOIN attend
ON std_num = at_std_num
JOIN course 
ON co_code = at_co_code
WHERE std_name = "강철수";
