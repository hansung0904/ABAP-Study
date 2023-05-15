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

테이블은 2차원 Matrix로 이루어져 있는데 행렬의 열은 각각의 이름과 속성이 있으며 이것을 필드 or 칼럼 이라고 부른다. <br>

ABAP 테이블은 크게 3가지 종류가 존재 하는데 이것은 일반적인 타입인 Transparent Table, Pooled Table 그리고 Cluster Table이다. <br>
Pool / Cluster Table은 여러 개의 Table을 하나로 그룹 지어놓은 ABAP Dictionary Object이다. <br>
테이블 기본 속성은 DD02L 테이블에 저장되며, 테이블 필드에 대한 정보는 DD03L 테이블에 저장된다. 테이블은 다음 4가지 속성을 가지고 있다.

||||
|------|---|---|
|• Table Field|필드 이름과 필드 속성을 가진다. Key필드 존재함.|
|• Foreign Key|하나의 테이블과 다른 테이블의 관계 정의|
|• Technical Setting|테이블 데이터 총 건수, 버퍼링 설정과 같은 테이블 속성 설정|
|• Index|데이터 SELECT 속도를 증가시켜준다. 인덱스는 테이블에 추가되어 생성됨. <br> 인덱스가 생성되어 있으면 테이블에 데이터가 추가 될 때마다 인덱스에도 <br> 데이터를 생성해야 하므로 쓰기 속도는 감소하고 읽기 속도는 증가하게 됨|