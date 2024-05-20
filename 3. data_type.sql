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

-- blob 바이너리 데이터 실습
-- author 테이블에 profile_image 칼럼을 blob형식으로 추가
alter table author add profile_image longblob;
insert into author (id, email,  profile_image) values (7,' hong8@naver.com', LOAD_FILE('C:\\cat.jpg'));

-- enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role 칼럼
alter table author modify column role enum('admin', 'user') not null;
insert into author (id, email, role) values (8,'hong8.@naver.com', 'user1');
-- enum컬럼 실슴
-- user1을 insert => 에러
-- user 또는 admin insert => 정상

-- date 타입
-- author 테이블애 birth_day 칼럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birth_day date;
insert into author (id, email, date) values(10, 'hong10@naver.com', '2000-05-01');

-- datetime 타입
-- author, post 둘 다에 datetime으로 created_time 컬럼 추가
alter table author add column created_time datetime default current_timestamp;
insert into author(id, email, created_time) values (11,'hong10@naver.com', '2024-05-17 00:00:00');
insert into post(id, title, created_time) values(8, 'hello8', '2024-05-17 00:00:00');

-- 비교 연산자
-- and 또는 &&
select * from post where id >= 2 and id <= 4;
select * from post where id between 2 and 4;
-- or 또는 ||
-- NOT 또는 !
select * from post where id < 2 or id > 4;
select * from post where !(id < 2 or id > 4);
-- NULL인지 아닌지
select * from post where contents is null;
select * from post where contents int not null;
-- in(리스트형태), not in(리스트형태)
select * from post where id in(1,2,3,4);
select * from post where id not in(1,2,3,4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%o'; -- o로 끝나는 title 검색
select * from post where title like 'h%'; -- o로 시작하는 title 검색
select * from post where title like '%llo%'; -- 단어 중간에 llo가 포함되는 경우 검색
select * from post where title not like '%o'; -- o로 끝나지않는 title 검색

-- ifnull(a,b) : 만약에 null이면 b반환, null 아니면 a반환
select title, contents, ifnull(author_id, '익명') as author_id from post;

-- (실습)프로그래머스/경기도에 위치한 식품창고 목록 출력하기

-- REGEXP : 정규표현식을 활용하여 조회
select * from author where name regexp '[a-z]';
select * from author where name regexp '[가-힣]';

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜 변환
-- CAST와 CONVERT
select cast(20200101 as date);
select cast('20200101' as date);
select convert(20200101 , date);
select convert('20200101' , date);

-- datetime 조회 방법
select * from post where created_time like '2024-05%';
select * from post where created_time <= '2024-12-31' and created_time >= '1999-01-01';
select * from post where created_time between '2024-12-31' and '1999-01-01';

-- date_format
select date_format(created_time,'%Y-%m') from post;
-- (실습) post를 조회할 때 date_format을 활용하여 2024년 데이터 조회, 결과는 *
select * from post where date_format(created_time,'%Y') = 2024;
select * from post where date_format(created_time,'%Y') = '2024'; -- 둘 다 가능

-- 오늘 날짜
select now();
