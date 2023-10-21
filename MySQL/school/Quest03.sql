/* 1. course 테이블에 해당 코스의 수강인원을 집계하는 필드 생성
co_degree : 필드이름  */
ALTER TABLE course ADD co_degree INT DEFAULT 0;

/* 2. co_degree 필드에 해당 코드를 듣고 있는 학생을 집계하여 업데이트*/
UPDATE course SET co_degree = (
SELECT COUNT(at_co_code) 
FROM attend
GROUP BY at_co_code
HAVING at_co_code = co_code);

/* 3. attend에 수강신청을 하면 course의 co_degree가 자동으로
증가하는 트리거 생성 */
DROP TRIGGER IF EXISTS insert_attend;
DELIMITER $$

CREATE TRIGGER insert_attend AFTER INSERT ON attend
FOR EACH ROW 
BEGIN

UPDATE course SET 
co_degree = co_degree + 1
WHERE co_code = NEW.at_co_code;
 
END $$
DELIMITER ;

# 수강 신청
INSERT INTO attend (at_std_num, at_co_code)
VALUES ("202016003", "2020msc001");