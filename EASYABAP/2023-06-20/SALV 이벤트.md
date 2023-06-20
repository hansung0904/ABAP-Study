# SALV 이벤트

사용자가 SALV 그리드를 더블클릭하거나, HOTSPOT을 선택하는 것과 같은 이벤트 동작에 대해서 알아본다. <BR>

## 이벤트란 무엇인가?
이벤트는 상속 관계에 있지 않은, 클래스 간에 메서드를 상호 호출해서 영향을 미칠 수 있는 특별한 메서드이다. 객체(또는 클래스)는 다른 객체(또는 클래스)의 이벤트 핸들러 메서드를 호출(Trigger) 하기 위해 이벤트를 사용한다. <br>
CALL METHOD 구문을 통해서 일반 메서드를 호출하는 경우, 하나의 메서드는 수많은 객체에 의해 호출 될 수 있다.<br>
이와 유사하게, 모든 객체가 이벤트 메서드를 호출할 수 있으며 이벤트의 소유주인 객체만이 이벤트를 실행할 수 있다.

일반 메서드를 호출하는 경우, 호출한 프로그램이 호출하고자 하는 메서드를 결정지을 수 있다.<br>
이와 마찬가지로 이벤트에서는 핸드럴가 반응 하고자 하는 이벤트를 결정할 수 있다.

SALV GRID에서 HOTSPOT, 더블클릭 등의 사용자 액션에 반응하는 이벤트를 등록하려면<br>
다음과 같은 절차가 필요하다.

**• 이벤트를 선언해서<br>**
**• 이벤트 핸들러 메서드를 정의하고<br>**
**• 이벤트 핸들러 메서드를 등록해야 한다.<br>**

① 이벤트 선언<br>
SALV에서 이벤트를 사용하려면 CL_SALV_EVENTS 클래스를 이용한다.<br>
```ABAP
DATA lr_event TYPE REF TO cl_salv_events_table.
lr_event = gr_table->get_event().
```
T-CODE : SE24에서 CL_SALV_EVENTS_TABLE을 조회하면 DOUBLE_CLICK 이라는 이벤트가 선언되어 있다.<br>
이것은 인터페이스 IF_SALV_EVENTS_ACTIONS_TABLE에 등록된 이벤트를 사용한다.<br>
② 이벤트 핸들러 메서드 정의<br>
프로그램 내에서 이벤트가 발생했을 때 반응하기 위해 클래스를 정의하고 이벤트 핸들러 메서드를 선언한다.<br>
```ABAP
CLASS lcl_handle_events DEFINITION.
PUBLIC SECTION.
METHODS:
    on_double_click FOR EVENT double_click OF cl_salv_events_table
        IMPORTING row column.
```
③ 이벤트 핸들러 메서드 등록<br>
이벤트를 실행하기 위해 ALV GRID에 이벤트 핸들러 메서드를 등록한다.<br>
```ABAP
DATA gr_event TYPE REF TO lcl_handle_events.

CREATE OBJECT gr_event.
SET HANDLER gr_event->on_double_click FOR lr_event.
```
④ 이벤트 호출<br>
SALV 화면을 더블클릭하면 RAISE_DOUBLE_CLICK이라는 메서드가 실행되고 이 메서드는 USER COMMAND에 해당하는 이벤트를 발생<br>
⑤ 이벤트 핸들러 메서드 실행<br>
이벤트가 호출되서 이벤트 핸들러 메서드가 실행된다. CLASS lcl_handle_events IMPLEMENTATION 에서<br> 메서드의 행위를 정의하게 되면 ALV에서 더블클릭에 반응하는 스크립트를 완성하게 된다.<br>
```ABAP
CLASS lcl_handle_events IMPLEMENTATION.
    METHOD on_link_click
        MESSAGE i000(ok) WITH '더블클릭 이벤트 호출'.
    ENDMETHOD.
ENDCLASS.        
```

## DOUBLE_CLICK 이벤트
DOUBLE_CLICK 이벤트 파라미터
|파라미터|의미|
|------|---|
|ROW <BR> TYPE I.|현재 선택된 라인 인덱스 번호|
|COLUMN <BR> TYPE lvc_fname.|현재 선택된 칼럼 이름|

## HOTSPOT_CLICK 이벤트
Hotspot으로 선언된 칼럼을 마우스로 클릭할 때에 반응하는 이벤트. <br>
해당 칼럼은 SET_CELL_TYPE 메서드를 이용해서 HOTSPOT 속성으로 설정해야 한다.
```ABAP
gr_column ?= gr_columns->get_column('CARRID').
gr_column->set_cell_type(if_salv_c_cell_type=>hotspot).
```

HOTSPOT_CLICK 이벤트 파라미터
|파라미터|의미|
|------|---|
|ROW<BR>TYPE I.|현재 선택된 라인 인덱스 번호|
|COLUMN<BR> TYPE lvc_fname.|현재 선택된 칼럼 이름|

## Toolbar 이벤트
SALV가 기본적으로 제공하는 아이콘 이외에 소스 레벨에서 기능을 추가할 수 있다. <br>
Toolbar 이벤트는 SALV 그리드에 단순히 아이콘만 추가하는 것이고 아이콘을 클릭했을 때의 동작은 <br> user_command 이벤트에서 수행하게 된다.<br>
전체 화면 모드에서 아이콘을 추가하려면 GUI STATUS를 생성하고, 메서드를 호출해서 스크린에 추가하게 된다.