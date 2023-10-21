# test2 테이블 생성
CREATE TABLE test2(
num INT NOT NULL,
name VARCHAR(10) NOT NULL,
dep VARCHAR(20),
addr VARCHAR(20),
tel VARCHAR(5),
score INT,
PRIMARY KEY(num));

# 데이터 추가
INSERT INTO test2 VALUES
(100, '홍길동', '경영학과','원주시','111',78),
(200, '김길동', '경영학과','서울시','123',89),
(300, '이길동', '컴퓨터','원주시','456',68),
(400, '박길동', '컴퓨터','수원시','222',97),
(500, '고길동', '경영학과','서울시','333',62),
(600, '구길동', '컴퓨터','인천','789',93);

# 1.학과가 경영학과인 학생들을 출력
SELECT * FROM test2 WHERE dep='경영학과';

# 2.성적이 80이상인 학생들을 출력
SELECT * FROM test2 WHER score >=80;

# 3.학과가 컴퓨터인 튜플을 컴퓨터학과로 변경
UPDATE test2 SET dep = '컴퓨터학과' 
WHERE dep='컴퓨터';

/* 
4.이름칼럼 뒤에 나이(age) 칼럼을 추가하고 값을 20으로 설정
- 새로운 칼럼 추가시 가장 마지막에 추가
- 원하는 칼럼 뒤에 추가하고 싶을 경우 after 칼럼명
*/
ALTER TABLE test2 ADD age INT DEFAULT 20 AFTER name;

/*
5.학과별 인원수 출력
- 인원수 count()
*/
SELECT dep, COUNT(dep) FROM test2
GROUP BY dep
ORDER BY dep;

# 6.학과별 성적 평균 출력
SELECT dep, ROUND(AVG(score),2) AS '평균' 
FROM test2
GROUP BY dep
ORDER BY dep;

# 7.주소별 인원수 출력
SELECT addr, COUNT(addr) FROM test2
GROUP BY addr
ORDER BY addr;

# 8.경영학과의 성적 합계 출력
SELECT dep, SUM(score) FROM test2
GROUP BY dep
HAVING dep='경영학과';

# 9.주소가 서울 또는 원주인 학생들 출력
SELECT * FROM test2 WHERE addr IN('서울시','원주시');
SELECT * FROM test2 WHERE 
addr = '서울시' OR addr='원주시';

# 10.성적이 70이상인 학생들의 학번, 이름, 학과, 성적만 출력
SELECT num, name, dep, score FROM test2
WHERE score >= 70;