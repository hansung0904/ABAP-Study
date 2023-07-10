# R3 Architecture
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/R3%20Architecture.png)

SAP R/3는 기본적으로 세 개의 Layer로 구성되어 있다. <br>
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/process%20flow.png) <br>

① 사용자가 SAP에 로그인 한 후 메뉴 또는 트랜잭션 코드를 이용해서 리포트 프로그램을 실행한다. <br> 시스템은 제일 먼저 프로그램의 정보를 애플리케이션 서버에 전달하게 된다.<br> 이때 애플리케이션 서버는 변수와 Data Object의 메모리를 확보하고, User Dialog를 위한 스크린을 생성한다. <br>그리고 ABAP Runtime 시스템은 프로그램 타입, INCLUDE 프로그램 등과 같은 정보를 Database의 일부 영역인 Repository에서 가져온다.<br>
② 이러한 정보를 바탕으로 사용자가 화면에 조회할 조건 값을 입력할 수 있는 Selection Screen이 생성된다.<br> 즉 , ABAP Runtime 시스템은 Presentation Layer에 Selection Screen 정보를 전송하고, Presentation Layer의 SAP GUI에 프로그램 화면이 조회된다.<br>
③ 사용자가 Input 필드에 데이터를 입력한다. 사용자가 데이터를 입력함과 동시에 ABAP Runtime 시스템에 ABAP Processing이 수행된다.<br> 화면의 Input 필드에 입력된 데이터는 ABAP Runtime의 변수에 자동으로 복사되고, ABAP Processing block이 수행된다.<br>
④ ABAP Processing Block 내에 Database 테이블에서 데이터를 읽어오는 구문이 존재하면 어떠한 테이블의 몇째 줄이 필요한지 Database Layer에 정보를 넘겨준다.<br> Database Layer는 해당 레코드를 Application Layer에 돌려준다.<br>
⑤ 모든 작업이 완료되면 사용자가 입력한 조건 값에 대한 결과 또는 리스트가 Presentation Server의 화면에 조회된다.<br>

# R/3 BASIS 시스템
R/3 BASIS 시스템은 컴퓨터의 운영체제, 하위의 Database, 통신 프로토콜 그리고 Presentation Component와 인터페이스 하기 위한 프로그램과 Tool로 이루어져 있는 플랫폼이다. <br>
R/3 애플리케이션 모듈은 시스템이 설치된 운영체제와 데이터 베이스에 관계없이 같은 기능을 수행하지만, R/3 BASIS 시스템은 모든 애플리케이션 모듈의 통합을 보증하는 독립적인 Layer이다.<br>
이러한 점에서 BASIS 시스템을 R/3 common 커널 또는 R/3 미들웨어라고 한다.

SAP에서는 Web 환경을 지원하는 등 확장된 플랫폼을 제공하고자 넷위버 버전을 배포했다.<br>
넷위버는 SAP R/3 버전의 SAP Basis와 SAP R/3 Enterprise 버전의 SAP Web Application Server의 진화된 플랫폼으로서<br>
기존에 각각 독립적으로 존재하던 <br>

**SAP MI (Mobile Infrastructure), SAP EP (Enterprise Portal), <br> SAP BW (Business Information Warehouse), SAP MDM (Master Data Management), <br>SAP XI (Exchange Infrastructure), SAP WAS (Web Application Server)**

등을 통합 구성해서 Application 간 연관성과 확장성을 강화한 통합 플랫폼이라 할 수 있다.