-- 데이터베이스 접속
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases;

-- board 스키마(database) 생성
-- table이나 column은 소문자가 일반적
CREATE DATABASE board;

-- 데이터베이스 선택
USE board;

-- 테이블 조회
show tables;

-- author 테이블 생성
create table author(
    id INT PRIMARY KEY,
    name VARCHAR(255), 
    email VARCHAR(255), 
    password VARCHAR(255)
    );

-- 테이블 컬럼 조회
describe author;

-- 컬럼 상세 조회
show full columns from author;

-- 테이블 생성문 조회
show create table author;

-- posts 테이블 신규 생성(id, title, content, author_id)
create table posts(
    -- column차원에서의 키 설정
    id INT PRIMARY KEY,
    title VARCHAR(255), 
    content VARCHAR(255), 
    author_id INT,
    -- 테이블 차원에서의 키 설정
    -- PRIMARY KEY(id)
    FOREIGN KEY(author_id) REFERENCES author(id)
);

-- 실습: test1 스키마 생성 후 삭제
create database test1;
drop database test1;

-- 테이블 index 조회
show index from author;
show index from posts;

-- ALTER : 테이블의 구조를 변경
-- 테이블 이름 변경
alter table posts rename post;
-- 테이블 컬럼 추가
alter table author add column test1 varchar(50);
-- 테이블 컬럼 삭제
alter table author drop column test1;
-- 테이블 컬럼명 변경
alter table post change column content contents varchar(255);
-- 테이블 컬럼 타입과 제약조건 변경
alter table author modify column email varchar(255) not null; 

-- 실습 : author 테이블에 adress 컬럼 추가, varchar(255)
alter table author add column adress varchar(255);
-- 실습 : post 테이블에 title not null 제약조건 추가, contents varchar(3000) 으로 변경
alter table post modify title varchar(255) not null;
alter table post modify contents varchar(3000);

-- 테이블 삭제
drop table 테이블명;
drop table if exists 테이블명;