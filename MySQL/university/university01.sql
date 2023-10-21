CREATE DATABASE university;
USE university

#학생테이블 생성
CREATE TABLE student (
st_num INT,
st_name VARCHAR(20) NOT NULL,
st_term INT DEFAULT 0,
st_point INT DEFAULT 0,
PRIMARY KEY (st_num)
);

#교수테이블 생성
CREATE TABLE professor (
pr_num INT,
pr_name VARCHAR(20) NOT NULL,
pr_age INT NOT NULL,
st_room VARCHAR(45), 
pr_state VARCHAR(45) DEFAULT "재직",
 pr_position VARCHAR(45) DEFAULT "조교수",
PRIMARY KEY (pr_num)
);

#과목테이블 생성
CREATE TABLE subject (
su_num INT,
su_code VARCHAR(20) NOT NULL,
su_title VARCHAR(45) NOT NULL,
su_point INT NOT NULL DEFAULT 0,
su_time INT NOT NULL DEFAULT 0,
PRIMARY KEY (su_num)
);

#강의 관계테이블 생성
CREATE TABLE course (
co_num INT Auto_Increment,
co_pr_num INT NOT NULL,
co_su_num INT NOT NULL,
co_term INT DEFAULT 1,
co_year INT,
co_timetable VARCHAR(100),
PRIMARY KEY (co_num),
FOREIGN KEY(co_pr_num)
REFERENCES professor(pr_num),
FOREIGN KEY(co_su_num)
REFERENCES subject(su_num)
);

#지도 관계테이블 생성
CREATE TABLE guide (
gu_num INT Auto_Increment,
gu_pr_num INT NOT NULL,
gu_st_num INT NOT NULL,
gu_year VARCHAR(45),
PRIMARY KEY (gu_num),
FOREIGN KEY(gu_pr_num)
REFERENCES professor(pr_num),
FOREIGN KEY(gu_st_num)
REFERENCES student(st_num)
);

#수강 관계테이블 생성
CREATE TABLE attend (
at_num INT AUTO_INCREMENT,
at_st_num INT NOT NULL,
at_co_num INT NOT NULL,
at_mid INT DEFAULT 0,
at_final INT DEFAULT 0,
at_attend INT DEFAULT 0,
at_hw INT DEFAULT 0,
at_score VARCHAR(45),
at_pass VARCHAR(1) DEFAULT 'n',
at_repetition VARCHAR(1) DEFAULT 'n',
PRIMARY KEY (at_num),
FOREIGN KEY(at_st_num) REFERENCES student(st_num),
FOREIGN KEY(at_co_num) REFERENCES course(co_num)
);

# 기본데이터 INSERT
INSERT INTO student(st_num, st_name,st_term) VALUES
(2020123001,'김영철',2),
(2020123002,'나영희',2),
(2020160001,'강철수',2),
(2020160002,'박철수',2),
(2020456001,'강군',2);

INSERT INTO subject VALUES
(1,'msc001','대학수학',3,3),
(2,'com001','컴퓨터개론',2,2),
(3,'com002','운영체제',3,3),
(4,'abc001','글쓰기',2,2),
(5,'abc002','영어',2,3);

INSERT INTO professor VALUES
(2005789001, '홍길동',60,'B동302호','재직','정교수'),
(2006456001, '박영실',60,'B동301호','안식년','정교수'),
(2010160001, '강길동',55,'A동202호','재직','조교수'),
(2011123001, '이순신',55,'A동203호','재직','조교수');

INSERT INTO course(co_pr_num, co_su_num, co_term, co_year, co_timetable) VALUES
(2005789001,1,1,2002,'월2a/2b/3a/3b/4a/4b'),
(2005789001,1,2,2002,'월2a/2b/3a/3b/4a/4b'),
(2010160001,2,1,2002,'화1a/1b/2a/2b'),
(2010160001,3,1,2002,'목2a/2b/3a/3b/4a/4b'),
(2011123001,4,2,2002,'화1a/1b/2a/2b'),
(2011123001,5,2,2002,'수1a/1b/2a/2b');

INSERT INTO guide(gu_pr_num, gu_st_num, gu_year) VALUES
(2010160001,2020160001,2020),
(2010160001,2020160002,2020),
(2011123001,2020123001,2020),
(2011123001,2020123002,2020),
(2006456001,2020456001,2020);

INSERT INTO attend(at_st_num, at_co_num) VALUES
(2020123001,1),
(2020123001,2),
(2020123001,3),
(2020123001,4),
(2020123001,5),
(2020123001,6),
(2020123002,1),
(2020123002,2),
(2020123002,3),
(2020123002,4),
(2020160001,1),
(2020160001,2),
(2020160001,3),
(2020160001,4),
(2020160001,5),
(2020160001,6),
(2020160002,1),
(2020160002,2),
(2020160002,3),
(2020160002,4),
(2020160002,5),
(2020160002,6),
(2020456001,1),
(2020456001,2),
(2020456001,3),
(2020456001,4),
(2020456001,5);



