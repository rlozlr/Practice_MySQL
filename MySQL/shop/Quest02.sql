-- PROCEDURE
/* 제품명을 입력하면 그 제품을 구매한 customer를 반환 
'에어 나시' 라는 제품을 입력하면 그 제품을 구매한 손님 리스트를 반환
프로시저명 : select_buy
매개변수 : 제품명(in in_product_name) */

DROP PROCEDURE IF EXISTS select_buy;

DELIMITER $$
CREATE PROCEDURE select_buy( IN in_product_name VARCHAR(40))
BEGIN
SELECT customer FROM buy
WHERE product_name = in_product_name;
END $$
DELIMITER ;

CALL select_buy("에어 나시");

/* 구매 금액이 10만원 이상인 손님 이름과 구매 가격을 
출력하는 프로시저 작성 */

DROP PROCEDURE IF EXISTS total_buy;

DELIMITER $$
CREATE PROCEDURE total_buy (IN in_total INT)
BEGIN
SELECT customer, SUM(total) total FROM buy
GROUP BY customer
HAVING total >= in_total;
END $$
DELIMITER ;

/* 특정 제품을 구매한 인원수를 리턴하는 프로시저 작성 변수
프로시저명 : count_buy
매개변수 : IN 제품명, OUT 개수 */

DROP procedure IF EXISTS count_buy;
DELIMITER $$
CREATE PROCEDURE count_buy (
IN in_product_name VARCHAR(40),
OUT out_cnt INT)
BEGIN
SELECT count(product_name) INTO out_cnt
FROM buy
WHERE product_name = in_product_name;
END $$
DELIMITER ;

CALL count_buy("에어 나시", @cnt);
SELECT @cnt AS "에어나시 구매인원";
