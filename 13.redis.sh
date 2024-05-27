# 레디스 접속
# cli : commandline interface
redis-cli

# redis는 0~15번까지의 database구성
# 데이터베이스 선택
select 번호(0번 디폴트)

# 데이터베이스 내 모든 키 조회
keys *

# 일반 String  자료구조
# key:value값 세팅
# key값은 중복되면 안됨
SET key(키) value(값)
set test_key1 test_value
set user:email:1 hongildong@naver.com
# set할 때 key값이 이미 존재하면 덮어쓰기 되는 것이 기본
# 맵저장소에서 key값은 유일하게 괸리가 되므로
# nx : not exist
set user:email:1 hongildong@naver.com nx
# ex(만료시간-초단위) - ttl(time to live)
set userLemail:2 hongildong@naver.com ex 20

# get을 통해 value값 얻기
get key

# 특정 key삭제
del user:email:1
# 현재 데이터베이스 모든 key값 삭제
flushdb

# 좋아요 기능 구현
set likes:posting:1 0
incr likes:posting:1 # 특정 key값의 value를 1만큼 증가
decr likes:posting:1
get likes:posting:1

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1:stock
# bash셀을 활용하여 재고 감소 프로그램 생성 (redis-stock.sh)

# 캐싱 기능 구현
# 1번 author회원 정보 조회
# select name, email, age from author where id=1;
# 위 데이터의 결과값을 redis로 캐싱
set user:1:detail "{\"name\":\"hong\", \"email\":\"hong@naver.com\",\"age\":30}" ex 10

# list
# redis의 list는 javadml deque와 같은 구조 즉, double-ended queue 구조

# 데이터 왼쪽 삽입
LPUSH key value
# 데이터 오른쪽 삽입
RPUSH key value
# 데이터 왼쪽부터 꺼내기
LPOP key
# 데이터 오른쪽부터 꺼내기
RPOP key

lpush hongindongs hong1
lpush hongindongs hong2
lpush hongindongs hong3

# 꺼내서 없애는게 아니라, 꺼내서 보기만
lrange hongildongs -1 -1

# 데이터 갯수 조회
llen key
# list의 요소 조회시에는 범위 지정
lrange hongildongs 0 -1 #처음부터 끝까지
# start부터 end까지 조회
lrange hongildongs start end
# ttl 적용
expire hongildongs 30
# ttl 조회
ttl hongildongs

# pop과 push 동시에
# A리스트에서 pop하여 B리스트에 push
RPOPLPUSH A리스트 B리스트

# 어떤 목적으로 사용될 수 있을까?
rpush 사과
rpush 배
rpush 사과
# 중복 제거가 안되기때문에 문제가 생김

# 최근 방문한 페이지
# 5개 정도 데이터 push
# 최근 방문한 페이지 3개 정도만 보여주는
rpush pages www.google.com
rpush pages www.naver.com
rpush pages www.youtube.com
rpush pages www.daum.net

# 위 방문페이지를 5개에서 뒤로가기 앞으로가기 구현
# 뒤로가기 페이지를 누르면 뒤로가기 페이지가 뭔지 출력
# 다시 앞으로가기 누르면 앞으로간 페이지 출력

# set 자료구조
# set 자료구조에 멤버추가
sadd members member1
sadd members member2
sadd members member1

# set 조회
smembers members

# set에서 멤버 삭제
srem members member2
# set멤버 갯수 반환
scard members
# 특정 멤버가 set안에 있는지 존재 여부 확인 : 있으면 1, 없으면 0반환
sismember members member2

# 매일 방문자수 계산
sadd visit:2024-05-27 hong1@naver.com
sadd visit:2024-05-27 hong2@naver.com
sadd visit:2024-05-27 hong3@naver.com
sadd visit:2024-05-27 hong1@naver.com
sadd visit:2024-05-27 hong3@naver.com

# zset(sorted set)
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score기준 오름차순 정렬
zrange zmembers 0 -1
# score기준 내림찿순 정렬
zrevrange zmembers 0 -1

# zset 삭제
zrem zmembers member2
# zrank는 해당 멤버가 index몇번째인지 출력
zrank zmembers mbmer2

# 최근 본 상품 목록 => sorted set (zset)을 활용하는 것이 적절
# 주식, 코인 등의 실시간 시세 또는 게임등의 사용자 점수, 순위 관리
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 orange
zadd recent:products 192420 banana
zadd recent:products 192415 apple
zadd recent:products 192430 apple
zrevrange recent:products 0 2

# hashes
# 해당 자료 구조에서는 문자, 숫자가 구분
hset product:1 name "apple" price 1000 stock 50
hget product:1 name
# 모든 객체값 get
hgetall product:1
# 특정 요소값 수정
hset product:1 stock 40

# 특정 요소의 값을 증가
hincrby produt:1 stock 20
hincrby produt:1 stock -20
