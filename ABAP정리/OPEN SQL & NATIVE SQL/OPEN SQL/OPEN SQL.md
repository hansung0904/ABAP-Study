# OPEN SQL Overview
OPEN SQL은 R/3 시스템에서 사용되며 데이터베이스 데이터를 조회하고 변경하는 등의 기능을 수행한다. <br>
데이터베이스 시스템(Oracle, MSSQL, MAX DB 등) 관계없이 SQL 결과와 Error Message가 반환된다. <br>
ABAP Dictionary에서 생성된 테이블, 뷰에만 적용된다. <br>
**OPEN SQL 기본적으로 클라이언트에 종속적이다** <br>
![](img/../../../../img/1-14.png)

OPEN SQL 명령어
- SELECT
  - 데이터베이스 테이블에서 데이터를 읽음

- INSERT
  - 데이터베이스 테이블에 데이터를 추가

- UPDATE
  - 데이터베이스 테이블의 값을 변경

- MODIFY
  - INSERT + UPDATE의 기능 수행
  - UPDATE : 동일한 키값이 있는 경우
  - INSERT : 동일한 키값이 존재하지 않는 경우

- DELETE
  - 데이터베이스 테이블의 값을 삭제함