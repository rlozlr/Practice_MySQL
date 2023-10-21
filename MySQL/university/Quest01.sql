#1. 김영철이 수강하는 과목명을 출력
SELECT st_name AS "학생명", su_title AS "과목명" 
FROM attend
JOIN course
ON  co_num = at_co_num 
JOIN subject
ON co_num = su_num
JOIN student
ON st_num = at_st_num
WHERE st_name = "김영철";

#2. 강길동 교수가 지도하는 학생명 출럭
SELECT pr_name AS "교수명", st_name AS "학생명" 
FROM guide
JOIN student
ON st_num = gu_st_num
JOIN professor
ON pr_num = gu_pr_num
WHERE pr_name = "강길동";

/*
3. 대학수학 과목을 수강하는 수강자 명단 출력
   (중복제거 DISTINCT)
*/
SELECT DISTINCT su_title AS "과목명", st_name AS "학생명" 
FROM attend
JOIN student
ON st_num = at_st_num
JOIN course
ON  co_num = at_co_num
JOIN subject
ON co_num = su_num
WHERE su_title = "대학수학";