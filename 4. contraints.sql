-- not null 조건  추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- auto_increment
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

-- author.id에 제약조건 추가시 fk로 인해 문제 발생 시
-- fk먼저 제거 이후에 author.id에 제약조건 추가
-- 삭제
alter table post drop foreign key post_ibfk_1;
alter table post modify column author_id bigint;
-- 삭제 된 제약조건 다시 추가
alter table post add constraints post_author_fk foreign key(author_id) references author(id);
insert into post(email) values ('13@naver.com'); 

-- uuid
alter table post add column user_id char(36) default (UUID());
insert into post(title) values('abc');

-- unique 제약 조건
alter table author modify column email varchar(255) unique;

-- on delete cascade 테스트 -> 부모테이블의 id를 수정하면? 수정 안됨
-- 삭제
alter table post drop foreign key post_author_fk;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade on update cascade;

-- (실습) delete는 set null, update cascade
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update cascade;
