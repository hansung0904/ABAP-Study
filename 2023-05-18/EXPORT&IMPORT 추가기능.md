## EXPORT/IMPORT 추가 기능
Export/Import 구문을 사용하면 ABAP 메모리 영역, Shared Buffer 영역, Database 테이블 영역 등에서<br>
데이터를 다른 프로그램으로 전달할 수 있다.<br>
ABAP 메모리 영역은 이미 이전 커밋에서 학습을 했기 때문에 이 외 2가지에 대해서 공부해보자.<br><br>
**1. Shared Buffer 영역 활용** <br>
다음 구문을 이용해서 데이터 오브젝트를 Cross-transaction Application Buffer에 저장할 수 있다.<br>
Key ID를 지정해서 Shared Buffer 영역으로 데이터 오브젝트를 EXPORT 한다. <br>
SAP Buffer는 SAP Memory 영역을 사용하기 때문에 모든 메인 세션과 내부 세션에 데이터를 공유할 수 있다.<br>
(SPA.GPA 파라미터와 달리 다른 사용자와도 데이터를 공유할 수 있다.) <br>
```ABAP
EXPORT obj1 ... objn TO SHARED BUFFER indx(st) ID key.
```
```ABAP
IMPORT obj1 ... objn FROM SHARED BUFFER indx(st) ID key.
```
**2. Database 테이블 영역활용** <br>
이 방법은 실제 INDX 테이블에 값을 저장한 후에 값을 읽는 방식,<br>
일반적으로 우리가 테이블에 저장하는 방식과 유사하다.<br>
인터널 테이블 GT_ITAB 값을 INDX 테이블에 저장해서 값을 전달하는 구문<br>
INDX 구문 다음의 2자리 값은 IMPORT/EXPORT 데이터 테이블 영역을 의미하고 임의로 지정할 수  있으며<br>
ID 구문은 사용자가 정의할 수 있는 Key 값을 기술하면 된다.<br><br> **1) 데이터 Export**<br>
```ABAP
EXPORT GT_ITAB TO DATABASE INDX(ZK) ID 'EABAP'.
```
**2) 데이터 Import**<br>
INDX 테이블에 저장된 데이터는 다음 IMPORT 구문을 사용해서 인터널 테이블에 저장하게된다.<br>
```ABAP
IMPORT gt_itab FROM DATABASE INDX(ZK) ID 'EABAP'
```
**3) 데이터 삭제**
다른 프로그램에 데이터가 전달되어 더는 필요하지 않은 경우에는 DELETE 구문을 이용해서 테이블에서 데이터를 삭제해주어야 한다. <br>
```ABAP
DELETE FROM DATABASE INDX(ZK) ID 'EABAP'.
```