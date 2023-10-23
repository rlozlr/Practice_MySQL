#TIRGGER 예제
-- shop DB 이동
-- 전체 product 테이블 값을 amount = 50 / sale_amount = 0
UPDATE product SET 
amount = 50, 
sale_amount = 0;

/* 홍길동이 에어나시 3개를 구매
에어나시의 재고량 -3, 판매랑 +3이 되게 트리거 작성
= buy 테이블에 값이 생성(INSERT)되면 
product 테이블에 amount(재고량), sale_amount(판매랑)이 
변동되는 트리거 생성*/

DROP TRIGGER IF EXISTS insert_buy;
DELIMITER $$
CREATE TRIGGER insert_buy AFTER INSERT ON buy
FOR EACH ROW 
BEGIN

DECLARE _amount INT  DEFAULT 0;
SET _amount = NEW.amount;

UPDATE product SET 
amount = amount - _amount,
sale_amount = sale_amount + _amount
WHERE name = NEW.product_name;
 
END $$
DELIMITER ;

INSERT INTO buy (customer, product_name, price, amount)
VALUES ("홍길동", "에어 나시", 9000, 3);

INSERT INTO buy (customer, product_name, price, amount)
VALUES ("박순이", "피트니스상의", 30000, 5);

INSERT INTO buy (customer, product_name, price, amount)
SELECT '박순이', name, price, 5
FROM product
WHERE num = 1;

/* buy 테이블에 데이터를 삭제하면 
amount, sale_amount 변경 트리거 생성 
DELETE로 삭제 후 확인*/

DROP TRIGGER IF EXISTS delete_buy;
DELIMITER $$

CREATE TRIGGER delete_buy AFTER DELETE ON buy
FOR EACH ROW 
BEGIN

UPDATE product SET 
amount = amount + OLD.amount,
sale_amount = sale_amount - OLD.amount
WHERE name = OLD.product_name;
 
END $$
DELIMITER ;

DELETE FROM buy
WHERE num = 18;
