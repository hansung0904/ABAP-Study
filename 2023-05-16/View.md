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
