-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from author inner join post on author.id = post.author_id;
select * from author a inner join post p a.id = p.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id = a.id;

-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
select p.id, p.title, p.contents, a.email from post p left outer join author a on p.author_id = a.id;

-- join된 상황에서의 where 조건 : on 뒤에 where 조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 eamil을 출력, 저자의 나이는 25세 이상만
-- join이 된 테이블에서 where 조건에 따라서 필터링
select p.title, a.email
from post p inner join author a on p.author_id = a.id
where a.age >= 25
-- 2) 모든 글 목록 중 글의 title과 저자가 있다면 email을 출력
-- 2024-05-01 이후에 만들어진 글만 출력
select p.title, a.email 
from post p left join author a on p.author_id = a.id
where p.created_time > 2024-05-01 and p.title is not null;

-- (실습) 프로그래머스/ 조건에 맞는 도서와 저자 리스트 출력
SELECT BOOK_ID, AUTHOR_NAME, DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK INNER JOIN AUTHOR ON BOOK.AUTHOR_ID = AUTHOR.AUTHOR_ID
WHERE CATEGORY='경제'
ORDER BY PUBLISHED_DATE

-- BOOK의 AUTHOR_ID가 NOT NULL조건을 가지고 있기 때문에 아래 쿼리도 가능
-- SELECT BOOK_ID, AUTHOR_NAME, DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHTED_DATE
-- FROM BOOK B LEFT JOIN AUTHOR A ON B.AUTHOR_ID = A.AUTHOR_ID
-- WHERE CATEGORY='경제'
-- ORDER BY PUBLISHED_DATE


-- union : 중복 제외한 두 테이블의 select를 결합
-- 단순히 세로로 붙이는 형태이기 때문에 컬럼의 갯수와 타입이 같아야함
-- union all : 중복 포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;

-- author테이블의 name, email 그리고 post 테이블의 title, contents union
select name, email from author union select title, contents from post;

-- 서브 쿼리 : select문 안에 또 다른 select문을 서브쿼리라 한다
-- select절 안에 서브쿼리
-- author email과 해당 author가 쓴 글의 개수를 출력
select email, (select count(*) from post p where p.author_id = a.id) as count
from author a;

-- from절 안에 서브쿼리
select a.name from (select * from author) as a;

-- where절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.authord_id;
select * from author where id in (select author_id  from post);

-- (실습) 프로그래머스/ 없어진 기록 찾기 
-- JOIN 사용
SELECT AO.ANIMAL_ID, AO.NAME
FROM ANIMAL_OUTS AO LEFT JOIN ANIMAL_INS AI ON AO.ANIMAL_ID = AI.ANIMAL_ID
WHERE AI.ANIMAL_ID IS NULL
ORDER BY AO.ANIMALD_ID
-- 서브쿼리 사용
SELECT ANIMAL_ID, NAME
FROM ANIMAL_OUTS
WHERE ANIMAL_ID NOT IN (SELECT ANIMAL_ID FROM ANIMAL_INS)

-- 집계함수
select count(*) from author;
select sum(price) from post; 
select round(avg(price),0) from post;

-- group by와 집계함수
select author_id, count(*), sum(price), round(avg(price),0),
min(price), max(price) from post group by author_id;

-- 저자 email, 해당 저자가 작성한 글 수를 출력
-- left join? inner join?
-- if null 확인 안하면 행이 존재하기 때문에 count수 증가
select a.id, if(p.id is null, 0, count(*)) 
from author a left join post p on a.id = p.author_id
group by a.id;

-- where와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외
select date_format(created_time, '%Y') as year, count(*)
from post
where created_time is not null
group by year;

-- (실습) 프로그래머스/ 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
-- (실습) 프로그래머스/ 입양 시각 구하기(1)

-- HAVING : group by를 통해 나온 통계에 대한 조건
select author_id, count(*) from post group by author_id;
-- 글을 2개 이상 쓴 사람에 대한 통계 정보
select author_id, count(*) as count
from post
group by author_id
having count >= 2;

-- (실습) 
-- 포스팅 price가 2000원 이상인 글을 대상으로,
-- 작성자별로 몇건인지와 평균 price를 구하되,
-- 평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력
select author_id, avg(price) as average
from post
where price >= 2000
group by author_id
having average >= 3000;

-- (실습) 프로그래머스/ 동명 동물 수 찾기

-- (실습) 2건 이상의 글을 쓴 사람의 id와 email구할건데,
-- 나이는 25세 이상인 사람만 통계에 사용하고, 가장 나이 많은 사람 1명의 통계만 출력
select a.id, count(*) as count
from author a inner join post p on a.id = p.author_id
where a.age >= 25
group by a.id
having count >= 2
order by max(a.age) desc limit 1;

-- 다중열 group by
select author_id, title, count(title)
from post
group by author_id, title;

-- (실습) 프로그래머스/ 재구매가 일어난 상품과 회원 리스트 구하기
SELECT USER_ID, PRODUCT_ID
FROM ONLINE_SALE
GROUP BY USER_ID, PRODUCT_ID
HAVING COUNT(USER_ID) >= 2
ORDER BY USER_ID, PRODUCT_ID DESC

