/* school DB에서 VIEW 생성
컴퓨터공학 뷰 생성
학번, 이름, 학과 */
CREATE OR REPLACE VIEW computer_view AS
SELECT std_num, std_name, std_major 
FROM student
WHERE std_major LIKE "컴퓨터공학%";

/* A학점인 친구들 뷰 생성
학번, 이름, 학점 */
CREATE VIEW A_score_view AS
SELECT std_num, std_name, at_score
FROM student
JOIN attend ON at_std_num = std_num
WHERE at_score = "A";