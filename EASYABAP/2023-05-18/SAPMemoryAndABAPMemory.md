# SAP Memory와 ABAP Memory
메모리는 프로그램 간에 데이터를 주고받기 위해 메모리 영역을 공유하는 용도로 사용된다. <br><br> SAP Memory와 ABAP Memory 영역으로 구분되며, SAP Memory는 메인 세션 간에 데이터가 공유되는 반면<br>
ABAP Memory는 내부 세션 사이에서만 메모리가 공유된다.

## 1 ABAP 프로그램의 Memory 구조
사용자가 SAPgui에 로그인하면 하나의 사용자 터미널 세션이 생성된다.<br>
하나의 터미널 세션으로 6개의 R/3 윈도우를 실행할 수 있다.<br>
각각의 R/3 윈도우는 Shared Memory 영역을 공유하고 있다.<br>
외부 세션은 6개의 윈도우 작업 창을 의미하고 /O [T-CODE]를 사용해서 최대 개의 추가 윈도우를 열 수 있다.<br>
그리고 하나의 외부 세션은 최대 20개의 내부 세션을 가질 수 있다. <br>
내부 세션은 하나의 외부 세션 내에서 실행 중인 프로그램이 다른 프로그램을 호출 할 때 생성되는 내부적인 세션이다.
<img src="https://freesapabap.files.wordpress.com/2015/11/mem21.jpg" width = "400px"> <br>
SAP Memory는 외부 세션 내에 존재하는 모든 내부 세션에서 메모리가 공유된다. <br>
SAP Buffere는 SAP Memory의 공간을 이용해서 Work Process 간에 메모리를 공유할 수 있도록 해준다.<br>
SAP 애플리케이션 서버는 각각의 버퍼(일명 Client cache)를 가지고 있다.<br>
클라이언트 레벨에서 버퍼가 공유되므로 SAP Buffer는 모든 메인 세션에서 데이터가 공유된다.

## 2 SAP Memory와 ABAP Memory의 차이점
SAP Memory와 ABAP Memory 개념에 대해서는 이해해보았고, 프로그램 내에서 각각의 메모리가 사용되는 경우를 비교해보자<br><br> **SAP Memory** <br>
SAP Memory는 사용자 터미널 세션 내의 모든 외부 세션에서 접근할 수 있는 Global Memory이다.<br>
즉 사용자가 SAPgui 로그인 화면을 이용해서 로그인한 상태에서 실행된 모든 프로그램에서 공유되는 메모리 영역이다.<br>
SAP Memory의 데이터를 주고받으려면 SET/GET 구문을 이용해서 메모리 파라미터를 전달한다.
```ABAP
SET PARAMETER / GET PARAMETER
```
**ABAP Memory**<br>
ABAP Memory는 같은 외부 세션 내에서 수행되고 있는 모든 프로그램에서 공유되는 Memory이다.<br>
즉 ABAP Memory는 개별 외부 세션에 하나만 존재한다.<br>
개별 프로그램의 자신의 내부 세션을 가지고, 내부 세션은 스택에 쌓이게 된다.<br>
EXPORT/IMPRT 구문을 이용해서 프로그램 간에 데이터를 주고받게된다.
```ABAP
EXPORT obj1 ... objn TO MEMORY ID key.
```
```ABAP
IMPORT obj...objn FROM MEMORY ID key.
```
**프로그램 간 데이터 전달 방법**<br>
프로그램 간에 데이터를 넘겨주는 방법은 크게 5가지인데<br>
ABAP MEMORY, SAP MEMORY를 이용하는 방법만 숙지해두자.<br><br> **1) Interface**<br>
TYPE-1 프로그램을 호출할 때, SUBMIT 구문을 이용해서 Selection Screen의 Input 필드에 값을 입력하거나, <br>
Selection Screen의 Variant를 호출하는 방법이다.<br><br> **2) ABAP Memory**<br>
ABAP Memory를 이용해서 데이터를 넘겨주려면 EXPORT/IMPORT 구문을 사용하고 같은 파라미터 ID명을 사용해야한다. <br><br> 3) **SAP Memory** <br>
SAP Memory 영역의 파라미터 ID를 이용해서 데이터를 넘겨준다. <br><br> **4) Database Table**<br>
가장 일반적인 방법으로 프로그램 A가 데이터를 테이블에 저장하고, 프로그램 B가 테이블에서 데이터를 SELECT 한다. <br><br> **5) Presentation Server** <br>
SAP gui가 실행 중인 Local PC에 데이터를 파일로 다운로드했다가 업로드 하는 방법을 의미한다.







