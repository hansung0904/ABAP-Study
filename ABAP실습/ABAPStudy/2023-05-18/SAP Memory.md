# SAP Memory
프로그램 간에 데이터를 넘겨주려면 SPA/GPA 기술이 필요 <br>
메모리 파라미터를 넘겨줘서 다른 프로그램의 Input Field에 값을 입력하는 것을 'SPA/GPA기술'이라고 한다.<br>
SPA/GPA 파라미터는 SAP Memory를 이용하는 파라미터를 의미한다. <br>
단 같은 사용자에 한해서만 메모리가 공유된다. <br>
이러한 점에서 SPA/GPA는 user Specific Parameter라고도 정의한다. <br><br> SAP Memory는 프로그램 간에 데이터를 주고받을 수 있도록 지원한다.<br>
하나의 세션이 로그인되었다면 모든 병렬 세션에 SAP Memory가 공유된다.<br>
SAP/GPA 파라미터 정보는 테이블 TPARA에서 확인이 가능하다 <br><br>
ABAP 프로그램은 다음 구문을 통해서 파라미터에 접근할 수 있다.
```ABAP
SET PARAMETER / GET PARAMETER
```
