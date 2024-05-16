-- tinyint는 -128~127까지 표현
-- author테이블에 age칼럼 추가
alter table author add column age tinyint;
-- insert시에 age:200 -> 125
insert into author (id, name, email, age) values (5,'hong5', 'hong5@naver.com', 200);
insert into author (id, name, email, age) values (6,'hong6', 'hong6@naver.com', 200);
-- unsigned시에 255까지 표현 범위 확대

-- decimal 실습
alter table post add column price decimal(10,3);
insert into post (id, title, price) values (6, 'hello_6', 3.123123);
-- update : price를 1234.1
update post set price=1234 where id=6;