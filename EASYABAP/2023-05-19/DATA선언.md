# DATA 선언
프로그램에서 사용하게 될 테이블과 데이터를 선언하게 된다. 복잡한 프로그램에서는 <br>
INCLUDE (프로그램 이름) TOP 구문에 포함된다.
```ABAP
REPORT pgm_id
INCLUDE pgm_idTOP.
```
INCLUDE 프로그램은 모듈 풀 프로그램에서 주로 사용되며, R/3 REPOSITORY에 저장되는 <br>
오브젝트로서 독립적으로 실행될 수 없는 프로그램이다.<br>