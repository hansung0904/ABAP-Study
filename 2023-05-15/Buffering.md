## 9.2 Buffering
Buffering 설정을 하게 되면 데이터베이스에서 직접 값을 읽어 오는 것이 아니라 Application Server 영역의 Buffer에서 데이터를 조회한다. <br>
버퍼링 설정은 특히 Client/Server 모델에서 큰 효과를 발휘하며 Access 시간을 효과적으로 줄일 수 있다.

**1. 버퍼링 옵션** <br>
버퍼링의 3가지 옵션에 대해서 알아보자 <br> <br>
**Buffering not permitted** <br>
버퍼를 사용하지 않는 경우이며 트랜잭션이 자주 일어나는 테이블은 버퍼를 사용하면 비효율적이다. <br>
Application Server와 Databas Server 간에 동기화가 진행될 때 까지 기다릴 수 없는 최신의 데이터가 필요한 테이블에 세팅. <br> <br>
**Buffering allowd but switched off** <br>
고객사에서 버퍼링을 사용할지 결정할 수 있는 버펄이 타입 <br>
이것은 Buffering type을 설정하지 않아도 된다는 것을 의미. <br>
테이블 크기와 Access Profile을 고려해서 버퍼링을 사용하는 것이 효율적이라면 활성화 할 수 있다. <br> <br>
이러한 타입을 만든 이유는 SAP사에서 개별 고객사의 특성을 다 고려할 수 없기 때문에, 고객사마다 상황에 맞게 설정할 수 <br> 있도록 하기 위해서이다. <br><br>
**Buffering activated** <br>
데이터 변경이 자주 발생하지 않고 Read 접근이 많은 테이블에 세팅. <br>
예를 들어, 클라이언트 테이블은 T000은 시스템을 처음 설치한 후 변경할 일이 거의 없으며, <br>
클라이언트가 추가되더라도 데이터 사이즈가 적기 때문에 Fully buffered로 설정되어 있다. <br><br>
**2. 버퍼링 타입** <br>
버퍼링 설정(Buffering activated)을 하게 되면 버퍼링 타입을 지정해야 한다. 3가지 버퍼링 타입에 대해서 설명한다. <br><br>
**Single record**
테이블 레코드에 접근한 정보만 버퍼에 저장한다. Single-record 버퍼링은 Generic과 Full 버퍼링보다

