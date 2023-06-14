# ALV 이벤트
ALV GRID에서 HOTSPOT, 더블클릭 등의 사용자 액션에 반응하는 이벤트를 추가할 수 있다.<br>
클래스 간에 이벤트를 등록하려면 다음과 같은 순서를 따른다.

***이벤트를 선언하고 <br>***
***이벤트를 핸들러 메서드를 정의해서 <br>***
***이벤트를 핸들러 메서드를 등록해야 한다. <br>***

## DOUBLE_CLICK 이벤트
ALV 화면을 조회해서 셀을 더블클릭할 때 화면을 빠져나오는 이벤트 예제를 보면 <br>
아주 간단하게 작업할 수 있다.<br>
아래는 DOUBLE_CLICK 이벤트에 사용되는 파라미터 표이다.

|파라미터|의미|
|------|---|
|E_ROW <BR> TYPE REF TO LVC_S_ROW|현재 선택된 라인 인덱스 번호|
|E_COLUMN <BR> TYPE REF TO LVC_S_COL|현재 선택된 칼럼 이름|

① 이벤트 핸들러 메서드를 포함하는 클래스를 정의하고 IMPLEMENT 한다. <br>이벤트 핸들러 메서드를 선언하고 기술한다. <br>
② 클래스를 참고하는 객체 참조 변수를 정의한다.<br>
③ 오브젝트를 생성해서 이벤트 핸들러 메서드를 등록하자. 그리고 프로그램을 실행해서 ALV GRID의 임의의 셀을 더블클릭하면 LEAVE TO SCREEN 0 구문이 수행되고 프로그램을 종료하게 된다.<br>

## HOTSPOT_CLICK 이벤트
Hotsport으로 선언된 칼럼을 마우스로 클릭할 때에 반응하는 이벤트이다. 해당 칼럼은 필드 카탈로그 선언 시 HOTSPOT 속성으로 선언되어야 한다. <br>필드 카탈로그는 나중에 다룬다.

|파라미터|의미|
|------|---|
|E_ROW_ID <BR> TYPE REF TO LVC_S_ROW|현재 선택된 라인 인덱스 번호|
|E_COLUMN_ID <BR> TYPE REF TO LVC_S_COL|현재 선택된 칼럼의 이름|

## Toolbar 이벤트
ALV가 기본적으로 제공하는 아이콘 이외에 프로그래머가 기능을 추가할 수 있다. Toolbar 이벤트는 <br> ALV GRID에 단순히 아이콘만 추가하는 것이고, 아이콘을 클릭했을 때의 동작은 user_command 이벤트에서 수행하게 된다.

|파라미터|의미|
|------|---|
|E_OBJECT <BR> TYPE REF TO <BR> CL_ALV_EVENT_TOOLBAR_SET|Toolbar의 기능을 저장하는 테이블 타입의 오브젝트이다.|
|E_INTERACTIVE <BR> TYPE CHAR01|Flag가 설정되어 있으면, 이벤트가 호출될 때 set_toolbar_interactive<br> 메서드를 호출해서 툴바를 초기화한다.|

***Z15_13코드를 봐보면*** <br>

① 이벤트 핸들러 메서드를 포함하는 클래스를 정의하고 IMPLEMENT 한다. <br>이벤트 핸들러 메서드를 선언하고 기술한다. <br>
② 화면에 refresh 아이콘을 추가하는 소스를 추가한다. 아이콘에 ICON을 설정하기 위한 스크립트 ls_toolbar-icon = icon_refresh. 구문을 이용하려면 TYPE-POOLS ICON을 전역 변수 선언 부분에 기술해야 한다.<br>
③ TYPE-POOLS ICON을 선언해서 아이콘의 시스템 ID를 쉽게 알아볼 수 있도록 해준다. 실제 ICON_REFRESH의 시스템 ID는 '@42@이다.<br>
④ 오브젝트를 생성해서 이벤트 핸들러 메서드를 등록하자. 그리고 프로그램을 실행하면 화면에 Refresh 아이콘이 추가됐음을 확인할 수 있다.

## USER COMMAND 이벤트
Toolbar 이벤트에서 추가된 아이콘에 기능을 추가하는 이벤트이다. <br>
Refresh 아이콘을 클릭했을 때 데이터를 새로 읽어오는 로직을 추가해보자. <br>
관련된 이벤트로는 after_user_command, before_user_command가 있다.

|파라미터|의미|
|------|---|
|E_UCOMM <BR> TYPE SY-UCOMM |추가한 버튼의 Function code|

① Refresh 아이콘을 클릭함녀 데이터를 다시 SELECT 한다. 테이블 내용이 변겨오디었다면 새로운 내용을 ALV에 조회되도록 한다.<br>
② ALV GRID를 재조회한다. <br>

## onDrag, onDrop 이벤트
ALV GRID 내에서 Drag & Drop을 수행할 때 작동하는 Drag 관련 이벤트이다.

|파라미터|의미|
|------|---|
|E_ROW <BR> Type LVC_S_ROW|현재 Drag 한 라인의 인덱스 번호|
|E_COLUMN <BR> Type LVC_S_COL|현재 Drag 한 칼럼의 이름|
|E_DRAGDROPOBJ <BR> Type REF TO CL_DRAGDROPOBJECT|사용자 액션(copy, move)정보 등을 포함한다.|