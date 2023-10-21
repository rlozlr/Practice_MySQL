#1. buy 테이블에서 customer의 이름을 홍0동으로 변경해서 출력만
SELECT REPLACE(customer, substr(customer, 2, 1), '0')  AS "고객명" 
FROM buy;

#2. product 테이블에서 price가 40000이상인 데이터만 상품명(할인상품)으로 표시하여 출력(조회만)
SELECT num, type_a, type_b, 
IF(price>=40000, CONCAT(name, "(할인상품)"), name) AS 'name',
price, amount, sale_amount, resgister_date 
FROM product;

#3. 월별 매출합계 출력
SELECT MONTH(resgister_date) AS MONTH, SUM(sale_amount) AS "매출합계" 
FROM product
GROUP BY MONTH
ORDER BY MONTH ASC;

#4. price가 가장 높은(가장비싼) 제품명, price 출력
SELECT MAX(price) FROM (
SELECT price  FROM product
ORDER BY price DESC) AS p;

#5. buy 테이블의 구매 내역을 추가하시오 (3개)
#    -> product에서 조회하여 추가.
INSERT INTO buy (customer, product_name, price, amount)
SELECT '도우너', name, price, 3 FROM product
WHERE num = 3;

INSERT INTO buy (customer, product_name, price, amount)
SELECT '둘리', name, price, 5 FROM product
WHERE num = 2;

INSERT INTO buy (customer, product_name, price, amount)
SELECT '또치', name, price, 9 FROM product
WHERE num = 5;

/*
6. product_non 테이블을 product 테이블과 같은 형식으로 추가하여
resgister_date의 9월 데이터를 이동하시키고 기존 product 테이블에서 제거
단, transaction을 이용하여 첫과정부터 완료되었을 때 commit 하기.
resgister_date의 9월 데이터를 이동하시오.
*/

CREATE TABLE IF NOT EXISTS product_non LIKE product;

START TRANSACTION;
INSERT INTO product_non (
SELECT * FROM product
WHERE MONTH(resgister_date) = 9);
DELETE FROM product
WHERE MONTH(resgister_date) = 9;
COMMIT;

# 7. 가장 많이 판매한 제품의 이름(name)을 출력 (buy 테이블 기준)
SELECT name FROM (
SELECT product_name AS name FROM buy
ORDER BY amount DESC
LIMIT 1) AS p;