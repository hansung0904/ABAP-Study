# LDB (Logical Database)

Database Table에서 데이터를 읽어오는 방법은 크게 두 가지

• SELECT 구문을 이용해서 데이터에 접근
SELECT 구문과 다양한 옵션으로 Database Table의 데이터를 분석하고 읽어올 수 있음.

• Logical Database(LDB)를 이용해서 데이터에 접근
LDB는 SELECT 구문과 다른 방법으로 Database Table에서 데이터를 읽어오는 방법을 제공. <br>
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/SELECT%20%EA%B5%AC%EB%AC%B8%EA%B3%BC%20LDB%EB%A5%BC%20%EC%9D%B4%EC%9A%A9%ED%95%9C%20%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%A8%20%EB%B9%84%EA%B5%90.png)
 ![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/Logical%20Database.png)

 개발자 한명이 한 모듈을 담당해서 프로그래밍하다 보면 유사한 테이블들을 조회하는 <br>
 리포트 프로그램을 개발해야 할 때가 발생한다. <br>
 프로그램마다 유사한 SQL문과 Selection Screen을 생성하고,<br>
 Foreign Key 관계, Index, Condition, Performance 등을 고려해서 프로그램을 재생성한다.<br>
 이것은 생산성 측면에서 상당한 손실이 발생한다고 볼 수 있다.

 위와 같이 사용 빈도가 높은 테이블의 데이터를 조회하기 위해 JOIN이 자주 사용되고, ***조회 조건이 유사한 경우를 하나의 패키지로 생성해서 재사용 할 수 있도록 해주는 것이 LDB이다.***

**Logical Database의 장점**
• Dynamic Selection이 지원된다.<br>
• Data의 Process와 Read를 쉽게 해준다.<br>
• Performance 향상<br>
• 중앙 집중식 Authorization Check를 수행할 수 있다.<br>
• Input Check를 할 수 있다.<br>
• 테이블의 데이터 접근 코드를 재사용할 수 있다.<br>
• Search help를 포함 시킬 수 있다.<br>
• Quickview에서 테이블의 Join 없이 원하는 데이터를 쉽게 조회 가능하다.<br>
• 유지보수와 확장을 중앙 집중식으로 처리할 수 있다.<br>

LDB는 프로그램을 의미하기도, LDB에 포함된 데이터 구조라고 정의하기도 한다. <br>
LDB는 Structure, Sleections, Database Program 3가지 구조로 이루어져 있다. <br>
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/Logical%20Database%20%EA%B5%AC%EC%A1%B0.png)

**1) Structure** <br>
LDB의 구조를 결정한다. Access 가능한 여러 개의 테이블의 Foreign Key 관계로 구성된다. <br>
테이블들은 계층 구조로 이루어져 있다.<br>
최상위 Node를 Root Node라고 하고 하위에 여러 개의 Node를 포함할 수 있다.

**2) Selections** <br>
선택 데이터의 Input Field를 정의한다. LDB와 TYPE-1 프로그램을 연결해서 프로그램을 생성해서 실행하면 Slection Screen이 자동으로 생성된다. 이때 화면은 Standard Selection Screen과 같은 1000번이 지정된다. <br>
Default Value 변경 등이 필요하면 Selection Screen에 코딩을 추가할 수 있다.

**3) Database Program** <BR>
DB Table에서 데이터를 읽어오기 위한 SELECT 구문을 LDB 서브루틴에 추가한다.<BR>
SELECT 후에는 PUT 구문을 사용해서 TYPE-1 프로그램에서 GET 구문으로 값을 조회할 수 있도록 지원한다.<BR>
즉 LDB를 추가한 프로그램에서는 OPEN SQL을 사용할 필요가 없다.<BR>
사용자가 원하는 특별한 기능들을 Subroutine에 추가할 수 있다.<br>
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/LDB%EA%B5%AC%EC%A1%B0.png) <br>

위 그림에서 'F1S'라는 LDB는 SPFLI, SFLIGHT, SBOOK 세 개의 Table이 계층 구조로 이루어져 있다. <br>
LDB에 포함된 Table을 Node라고 하며, 최대 300개의 Node를 허용한다.
LDB는 NODES 키워드로 선언하고 GET NODES 구문으로 데이터를 추출하는 특별한 이벤트를 가진다.

이벤트가 실행되면 선언한 테이블에 대해서 Selection-Screen이 생성되고, 데이터는 메모리의 Work Area에 할당된다. <br>
LDB는 자체적으로 OPEN SQL을 포함하고 있기 때문에 개발 프로그램에서 SQL을 사용할 필요가 없게 된다.<br>
그래서 SELECT 구문을 대신해서 GET 구문을 사용해서 LDB의 데이터들을 추출하게 된다.<br>
GET 이벤트가 실행되면 데이터에 대한 프로세스는 LDB 내에서 OPEN SQL을 실행시켜 PUT 구문에 의해 받아들여진다.
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/LDB%20%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4.png) <br>

위 그림에서 TYPE-1(실행 가능한) 프로그램의 GET TABLE1 구문은 LDB의 NODE의 PUT TABLE1 이라는 <BR>
Subroutine을 호출하게 된다. 이 Subroutine 내에서 SELECT 구문이 수행된다. <BR>
즉, R/3 system DB로 실제 접근은 LDB의 PUT table subroutine에서 OPEN SQL로 이루어진다.

조회된 데이터는 Interface Work Area(Tables, NODES 선언 구문)를 이용해서 TYPE-1 Program으로 전달되고, GET 이벤트를 통해 데이터 Processing을 하게 된다.(데이터 reading + 데이터 Processing). <BR>