# SELECTION SCREEN
프로그램 조회 조건을 입력할 수 있는 SELECTION SCREEN을 생성하는 부분 <br>
리포트 프로그램이 실행되면, SELECTION SCREEN이 자동으로 생성된다. <br>
SELECTION SCREEN은 사용자와 상호 작용을 하기 위한 INPUT 필드와 같이 선택 조건을 입력할 수 있는 화면 제공<br>
리포트 프로그램에서 SELECTION SCREEN은 'INCLUDE 프로그램명 SEL(또는 TOP)'에 포함하는 것이 좋다.<br>
SELECTION SCREEN은 프로그래머가 정의하지 않아도, 자동으로 스크린을 생성하고 Flow Logic을 구현하도록 도와준다.
```ABAP
SELECT-OPTIONS: sel_carr FOR sflight-CARRID.
PRAMETERS : p_carr LIKE sflight-carrid.
SELECTION-SCREEN BEGIN OF BLOCK bll
WITH FRAME TITLE TEXT-010
SELECTION-SCREEN END OF BLOCK bll.
```