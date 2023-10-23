CREATE DATABASE shop;
USE shop

-- 제품 테이블 (product)
-- 구매 테이블 (buy)

# product 테이블 생성
CREATE TABLE product (
num INT Auto_Increment,
type_a VARCHAR(50) NOT NULL,
type_b VARCHAR(50) NOT NULL,
name VARCHAR(100) NOT NULL,
price INT DEFAULT 0,
amount INT DEFAULT 100,
sale_amount INT DEFAULT 0,
resgister_date DATETIME,
PRIMARY KEY(num));

# product 테이블에 데이터 넣기
INSERT INTO product (type_a, type_b, name, price, amount, sale_amount, resgister_date)
VALUES ("티셔츠", "긴소매", "폴라 티셔츠", 15000, 100, 100, "2022-10-15"),
("티셔츠", "반소매", "순면라운드 반팔티", 15000, 153, 100, "2022-09-15"),
("티셔츠", "민소매", "에어 나시", 9000, 33, 100, "2022-11-10"),
("패션운동복", "트레이닝상의", "피트니스상의", 30000, 55, 100, "2022-11-05"),
("패션운동복", "트레이닝하의", "피트니스하의", 50000, 34, 100, "2022-11-06"),
("아우터", "재킷", "양면 롱 후리스 자켓", 23300, 42, 100, "2022-11-05"),
("아우터", "코트", "양털 겨울 코트", 50000, 30, 100, "2022-10-31"),
("아우터", "패딩", "롱 패딩 점퍼", 47400, 45, 100, "2022-11-01");

# buy 테이블 생성
CREATE TABLE buy (
num INT Auto_Increment,
customer VARCHAR(20),
product_name VARCHAR(100),
price INT DEFAULT 0,
amount INT DEFAULT 0,
buy_date DATETIME default NOW(),
PRIMARY KEY(num));

# 홍길동이 폴라 티셔츠 5개 구매
INSERT INTO buy (customer, product_name, price, amount)
VALUES ("홍길동", "폴라 티셔츠", 15000, 5);

/*
product 테이블에서 값을 조회하여 추가
홍길순이 폴라티셔츠 3장 구매 (num = 1)
*/
INSERT INTO buy (customer, product_name, price, amount)
SELECT '홍길순', name, price, 3 FROM product
WHERE num = 1;

# 5명이 여러가지 상품으로 구매
INSERT INTO buy (customer, product_name, price, amount)
SELECT '해리', name, price, 2 FROM product
WHERE num = 2;
INSERT INTO buy (customer, product_name, price, amount)
SELECT '론', name, price, 1 FROM product
WHERE num = 7; 
INSERT INTO buy (customer, product_name, price, amount)
SELECT '헤르미온느', name, price, 4 FROM product
WHERE num = 8;
INSERT INTO buy (customer, product_name, price, amount)
SELECT '말포이', name, price, 3 FROM product
WHERE num = 6;
INSERT INTO buy (customer, product_name, price, amount)
SELECT '네빌', name, price, 8 FROM product
WHERE num = 3;

# 제품별 판매수량 조회
SELECT product_name AS "제품명" , SUM(amount) AS "판매수량"
FROM buy
GROUP BY product_name;

# 제품별 판매 금액 조회
SELECT product_name AS "제품명" , SUM(price) AS "판매금액"
FROM buy
GROUP BY product_name;

# 제품별 판매수량 및 판매금액 조회
SELECT product_name AS "제품명" , 
SUM(amount) AS "판매수량",  SUM(price) AS "판매금액"
FROM buy
GROUP BY product_name;

# buy 테이블에서 amout 뒤에 total 필드를 추가 INT
ALTER TABLE buy ADD total INT DEFAULT 0 AFTER amount;

# price * amount 곱한 값으로 나타내기
UPDATE buy SET total = price * amount;

# total 칼럼 지우기
ALTER TABLE buy DROP total;

/*
칼럼을 생성시 계산된 값을 자동 계산하여 생성할 때 사용 (generated columns)
- stored : 값이 저장되는 방식
(데이터가 입력되거나 수정될 때 해당 칼럼도 같이 갱신)
- virtual : 데이터를 저장하지 않고 정의만
(해당 칼럼을 읽으려고 시도할 때 계산을 통해 보여주는 것만)
*/

ALTER TABLE buy ADD total INT 
GENERATED ALWAYS AS (price * amount)
STORED AFTER amount;

# 전체 총 판매수량과 총 매출
SELECT SUM(amount) AS "총 판매수량", SUM(total) AS "총 매출"
FROM buy;

-- product 테이블에서
# 1. 최신 상품순으로 정렬 ( 날짜가 가장 늦게 들어온 제품)
SELECT * FROM product
ORDER BY resgister_date DESC; 

# 2. type_a 별로 상품 개수와 price 합계
SELECT type_a AS "TYPE",
COUNT(type_a) AS "상품개수",
SUM(price) AS "가격" 
FROM product
GROUP BY type_a;


# 3. price 16000이상인 제품은 할인상품에 해당 할인 상품을 출력하시오.
SELECT name AS "할인 상품"
FROM product
WHERE price >= 16000;

/* 4. 할인 상품의 이름과 가격을 출력
 -- 할인가격( 16000원 이상인 제품만 대상으로 10%할인된 가격)
 -- 할인상품명, 정상가, 할인가  */
SELECT name AS "할인 상품", price AS "정상가",
ROUND(price*0.9 ,0) AS "할인가"
FROM product;

# 전품목을 낼 때 (IF를 사용)
SELECT name AS "할인 상품", price AS '정상가', 
IF(price>= 16000, ROUND(price*0.9 ,0), price) AS '할인가'
FROM product;

# 5. 11월에 입고된 상품만 출력
SELECT * FROM product
WHERE resgister_date LIKE "%-11-%";

# MONTH 활용
SELECT * FROM product 
WHERE MONTH(register_date) = 11;

SELECT MONTH(resgister_date) AS mon, 
SUM(price) AS sum 
FROM product
GROUP BY MON
ORDER BY MON;

# 6. 년-월로 날짜 표시
SELECT DATE_FORMAT(resgister_date, "%y-%m") AS mon,
SUM(price) AS sum
FROM product
GROUP BY mon
ORDER BY mon;

# 7. 합계의 가장 큰 값을 출력
SELECT type_a, SUM(sale_amount) AS sum FROM product
GROUP BY type_a
ORDER BY SUM DESC
limit 0, 1;

# 8. type_a 별로 가장 큰 판매량의 판매량 합계를 출력
SELECT MAX(sum) FROM (
SELECT SUM(sale_amount) AS sum 
FROM product
GROUP BY type_a) AS p;

/*
트랜잭션 (TRANSACTION)
  - 하나의 작업을 하기 위한 명령어 묶음 단위
  - 하나의 트랜잭션에서 실행하는 모든 명령어가 
    모두 완료되어야 전체가 완료되는 형태의 작어에서 사용
    만약 하나라도 작업이 취소되면 모두 취소
    완료와 취소를 나중에 결정하는 개념
    임시 실행 개념.
  - 데이터의 안전성 확보를 위한 방법


START TRANSACTION;
명령어1;
명령어2;
...
COMMIT; => 작업완료
ROLLBACK; => 작업취소
*/

START TRANSACTION;
INSERT INTO test2 (num, name, dep, addr)
VALUES (800, '이영이', '컴퓨터학과', '인천시');
SELECT * FROM test2
WHERE tel IS NULL;
UPDATE test2 SET tel = "미등록"
WHERE tel IS NULL;
ROLLBACK; 
