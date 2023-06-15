# Screen에서의 Context 메뉴 추가
앞선 내용에서는 ALV에서 메뉴 페인터를 이용해서 생성한 Context 메뉴를 load하고, 메서드를 이용해서 Context 메뉴를 동적으로 생성하는 방법에 대해서 공부했다. <br>
이제 Context 메뉴를 Module Pool Program 스크린에 적용해보도록 한다.

먼저 Code로 구성된 'CT_MENU'라는 이름의 Context 메뉴를 생성.<br>
Context 메뉴를 스크린 100번의 Input/Output 필드에 연결하는 작업을 해보면<br>
Load_gui_status 메서드를 호출해서 Context 메뉴를 사용하려면 특별한 형태의 FORM문을 생성해야 한다.

```ABAP
FORM on_ctmenu_xx USING l_menu TYPE REF TO cl_ctmenu.
~
ENDFORM.
```

스크린 구성요소에  Context 메뉴 이름을 설정했으면, 프로그램이 실행되어서 스크린이 내부 세션에 load 될 때 PERFORM문은 시스템에 의해 자동으로 생성된다. <br>
그리고 사용자가 스크린에서 마우스 오른쪽 버튼을 클릭하게 되면 FORM 구문이 구동된다.<br>

FORM구문을 구성해보면..
```ABAP
FORM on_ctmenu_ctcrea USING l_menu TYPE REF TO cl_ctmenu.

    CALL METHOD cl_ctmenu=>load_gui_status
        EXPORTING
            program = sy-repid
            status = 'CT_MENU'
            menu   = l_menu.
ENDFORM.            
```

만약 프로그램을 실행했는데 Context Menu가 나오지 않는다면 SAP GUI의 Quick Cut and paste 기능을 해제해야 한다. <br>
이 기능은 문자열을 마우스로 Drag 하면 클립보드로 복사되고, <br>마우스 오른쪽 버튼을 누르면 붙여넣기가 실행되도록 하기 때문이다.