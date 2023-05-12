# Table
테이블은 실제 데이터베이스의 물리적 테이블과 ABAP Dictionary의 테이블이 존재한다. <br>
T-CODE:SE11에서 테이블을 생성해서 활성화하면, 데이터베이스에서 물리적인 테이블이 생성된다. <br>
ABAP Dictionary에서 생성한 테이블은 SAP DB UTILITY에서 번역해서 데이터 베이스 테이블로 생성하게 된다. <br>
지금 여기서 말하는 테이블은 실제 DB에 존재하는 테이블이 아니라 ABAP Dictionary 테이블이므로 두 개념에 대해서 구분해서 <br>
이해하자. <br>
예를 들면 ABAP Dictionary 테이블의 필드 순서와 데이터베이스 테이블의 필드 순서는 서로 다를 수 있다. <br>

SAP는 일반 개발자에게 DBMS에 직접 로그인해서 테이블을 변경하고, 데이터를 삭제하고, 심지어 데이터를 조회하는 권한도 부여하지 <br>않는다. <br>

WHY ? <br>
***그 이유중 하나는 ABAP Dictionary에 존재하는 Foreing Key가 실제 DB에선 생성되지 않기 때문에 Data Integrity가 훼손될 수 있기 때문***<br>

테이블은 2차원 Matrix로 이루어져 있는데 행렬의 열은 각각의 이름과 속성이 있으며 이것을 필드 or 칼럼 이라고 부른다.
