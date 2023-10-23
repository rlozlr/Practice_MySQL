-- UPDATE TRIGGER 생성

/* attend 테이블에 값이 변경되면 
co_degree의 값도 같이 변경되도록 
트리거 작성 */

DELIMITER $$
CREATE TRIGGER update_attend 
AFTER UPDATE ON attend
FOR EACH ROW
BEGIN
UPDATE course SET co_degree = (
CASE 
WHEN co_code = NEW.at_co_code
THEN co_degree+1
WHEN co_code = OLD.at_co_code
THEN co_degree-1
ELSE co_degree
END);
END $$
DELIMITER ;

UPDATE attend SET at_co_code = '2020ipc002'
WHERE at_num= 18;