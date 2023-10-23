/* student 테이블의 st_point(이수학점)을 업데이트 하시오.
- 학점을 주는 조건은 at_repetition = 'n'이면 학점을 획득 (y면 학점 X)
- 학점은 attend 테이블의 at_co_num가 어느 과목인지 확인
- 해당 과목의 학점(su_point)를 확인하여
- 해당 학생의 st_point에 update */
# 프로시저 작성
-- CALL update_stpoint(학번);	한 번에 한 명씩 변경
-- CALL update_stpointall();	모두 한 번에 변경

# CALL update_stpoint(학번);
DROP procedure IF EXISTS update_stpoint;
DELIMITER $$
CREATE PROCEDURE update_stpoint (
IN in_st_num INT)
BEGIN

UPDATE student
SET st_point = (
SELECT SUM(su_point) FROM attend
JOIN course
ON  co_num = at_co_num
JOIN subject
ON  su_num = co_su_num
WHERE at_repetition = "n"
&& at_st_num = st_num)
WHERE st_num = in_st_num;

END $$
DELIMITER ;

-- 확인
CALL update_stpoint(2020123001);
SELECT * FROM student;

#CALL update_stpointall();
DROP procedure IF EXISTS update_stpointall;
DELIMITER $$
CREATE PROCEDURE update_stpointall()
BEGIN

UPDATE student
SET st_point = (
SELECT SUM(su_point) FROM attend
JOIN course
ON  co_num = at_co_num
JOIN subject
ON  su_num = co_su_num
WHERE at_repetition = "n"
&& at_st_num = st_num);

END $$
DELIMITER ;

-- 확인
CALL update_stpointall();
SELECT* FROM student;