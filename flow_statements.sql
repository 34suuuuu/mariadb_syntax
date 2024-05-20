-- 흐름 제어 : case문
select 컬럼1, 컬럼2, 컬럼3,
case 컬럼4
    when [비교값1] then 결과값1
    when [비교값2] then 결과값2
    else 결과값3
end
from 테이블명;

-- post테이블에서 1번 user는 first_author, 2번 user는 second_author
select id, title, contents, 
case author_id
    when 1 then 'first_author'
    when 2 then 'second_author'
    else 'others'
end as author_id
from post;

-- author_id가 있으면 그대로 출력, 
-- 없으면 'anonymous'로 출력되도록 post테이블 조회
select id, title, contents,
	case
		when author_id is null then 'anonymous'
		else author_id
	end as author_id
from post;

-- 위 case문을 ifnull 구문으로 변환
select id, title, contents,
    ifnull(author_id, 'anonymous')
from post;

-- if 구문으로 변환
select id, title, contents, 
    if(author_id is null, 'anonymous', author_id)
from post;

-- (실습) 프로그래머스/ 조건에 부합하는 중고거래 상태 조회하기
-- (실습) 프로그래머스/ 12세 이하인 여자 환자 목록 출력하기
