/*
test2 테이블에서 replace를 사용하여 '서울시' -> '서울특별시'로 저장
*/
UPDATE test2 SET addr = REPLACE (addr, "시", "특별시");
WHERE addr = '서울시';

# 김순이 데이터를 추가하시오.
INSERT INTO test2 (num, name, dep, addr)
VALUES (700, '김순이', '컴퓨터학과', '인천시');

# tel이 null인 학생을 검색 (IS NULL)
SELECT * FROM test2
WHERE tel IS NULL;

# tel이 null인 자료를 미등록으로 수정
UPDATE test2 SET tel = "미등록"
WHERE tel IS NULL;
