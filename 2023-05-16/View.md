# View란 무엇인가
RDBMS에서는 여러개의 테입르이 존재하고 그 테이블들에 데이터들이 분산된 경우가 많다. <br>
이러한 데이터를 한 번에 조회하고자 할 경우에 View를 사용하게 된다.
<img src = https://help.sap.com/doc/saphelp_snc70/7.0/en-US/cf/21ec5d446011d189700000e8322d00/sdic10_0_image002.gif> <br>

View는 하나 또는 여러 테이블에 존재하는 데이터를 통합해서 조회할 수 있도록 지원한다. <br>
ABAP Dictionary에서 View를 활성화하면 데이터베이스에 생성되고, DataBase View에 접근하려면 데이터베이스 인터페이스를 통해 Access 한다. <br>
필요한 테이블과 필드만 조합하기 때문에 불필요한 필드를 조회하지 않아 Interface를 최소화 시킨다. <br>
View는 ABAP Program에서 테이블과 같이 SELECT 구문에 사용할 수 있다. <br><br>
Database View는 ABAP Dictionary에서 정의되면 활성화될때 자동으로 데이터베이스에 생성된다. <br>
&emsp; ***Database Commit 느낌*** <br><br>
ABAP Dictionary에서 Database View의 구조가 변경되면 이 변경 사항은 바로 Database View에 영향을 주지 않는다. <br>
View는 데이터를 가진 것이 아니기 때문에 기존의 View를 삭제하고 ABAP Dictionary에 정의된 새로운 View를 생성시켜주어야 한다. <br>
View를 이용해서 데이터베이스의 자료를 액세스 하기 위해서는 OPEN SQL이나 NATIVE SQL을 이용해서 두 가지 방법 모두를 사용할 수 있다. <br>
OPEN SQL은 Database Interface에 의해서 데이터베이스에 의존적인 NATIVE SQL로 번역이된다. <br>

Maintenace status는 View를 통해서 읽기 속성만 부여할 것인지 아니면 쓰기도 가능하게 할 것인지를 정의한다. <br>
만약에 Database View가 두 개 이상의 테이블로 구성되어 있다면 이 View를 통해서는 Read 작업만 가능하다.

## 2 view의 종류
View에는 다음과 같은 4가지 종류가 있다. 책에서는 Database View & Maintenace View만 학습하는데 <br>
실무에서는 보통 Maintenace View만 만든다 <br>

**• Database View** <br>
**• Projection View** <br>
**• Help View** <br>
**• Maintenace View** <br>

## 2.1 Database View
여러 개의 테입르에서 필요한 데이터들을 추출한 View를 의미한다. <br>
View는 활성화되면 ABAP Dictionary에 의해서 사용될 수 있다. <br>
ABAP Dictionary에 의해서 정의되고 사용되기 때문에 일반 ABAP Dictionary 테이블과 같이 OPEN SQL, NATIVE SQL,로 프로그램에서 사용해서 <br>
데이터를 가져올 수 있다. <br>
만약 하나의 테이블만 사용해서 View를 정의한다면 'MAINTENECE STATUS'를 이용해서 읽기/쓰기를 정의할 수 있다. <br>
Database View는 Transparent 테이블만 사용이 가능하다. <br>
<img src = "https://help.sap.com/doc/12a2d87e6c531014bec0e63ea0208c21/7.0.40/en-US/loio6cc71055d1c4e879e10000000a174cb4_LowRes.png"> <br>

## 2.2 Maintenance View
여러 개의 테이블을 동시에 유지보수할 수 있는 View를 의미한다. <br>
이때 테이블들은 반드시 Foreing Key로 연결되어 있어야 한다. <br>
SAP R/3는 논리적인 단위로 여러 테입르에 데이터가 분산되어 저장된 경우가 많은데 이 경우 Maintenance View를 이용해서 한 번에 데이터를 <br>
조회하고, 변경하고, 생성할 수 있다. <br>
즉, Foreign Key로 연결된 테이블들의 원하는 필드들을 하나로 모아 Maintenance View로 생성하고 <br>
View에서 데이터를 입력, 삭제, 변경하면 실제 테이블의 데이터도 수정된다. <br>
또한, Maintenance View에 사용된 모든 테이블의 관계는 Foreign Key에 의해 연결되어야 한다. <br>
ABAP 프로그램 안의 SELECT 문 같은 곳에서는 사용할 수 없다.