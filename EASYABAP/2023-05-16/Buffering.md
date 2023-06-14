### Generic area bufferd
선택된 킷값에 해당하는 테이블의 모든 Entry가 버퍼에 저장된다. <br>
Generic Key는 Primary Key의 일부분이다. <br>
Generic Key를 설정하는 것은 아주 중요한 문제인데, Primary key가 여러 개인 필드 중의 하나만 <br>
Generic Key로 설정한다면 SELECT 구문의 WHERE 조건에 3개의 Primary Key를 이용해서 <br>
1 Row가 조회되지만 Generic Key 설정이 2개로 되어 있어서 MANDT와 carrid 두 개의 필드에 <br>
해당하는 데이터들이 Buffer에 저장된다.

### Fully buffered
모든 테이블 Row가 Buffer에 저장된다. 데이터가 저고, 자주 읽히며, 데이터가 추가되는 횟수가 적은 테이블에 설정해서 사용한다. SELECT 구문이 수행되면 먼저 Application 서버의 Buffer에서 데이터를 읽어오고 해당 값이 존재하지 않으면 데이터베이스 테이블에 접근한다.
