# Context 메뉴의 메서드 실습

```ABAP
REPORT Z15_28.

METHOD handle_condext_menu.
    DATA : lt_std_fcodes TYPE ui_functions.
    DATA : lt_own_fcodes TYPE ui_functions.

    CALL METHOD e_object->load_gui_status
        EXPORTING
            program = sy-repid
            status = 'CONTEXT_MENU'
        menu = e_object.
        
    CALL METHOD e_object->add_function
        EXPORTING
            fcode = 'LEAVE'
            text = 'LEAVE PROGRAM'.

    APPEND CL_GUI_ALV_GRID=>mc_fc_col_optimize
        TO lt_std_fcodes.
        
    CALL METHOD e_object->hide_function
        EXPORTING
            fcodes = lt_std_fcodes.
            
    APPEND 'RESH' TO lt_own_fcodes.
    
    CALL METHOD e_object->disable_functions
        EXPORTING
            fcodes = lt_own_fcodes.
ENDMETHOD.
```

① add_function 메서드<br>
add_function 메서드를 통해 Context 메뉴에 Function Code를 추가한다. <br>
② hide_functions 메서드<br>
Context 메뉴에 Function Code를 숨기게 한다. (show_functions는 반대 역할)<br>
③ disable_functions 메서드<br>
Context 메뉴의 function 코드를 비활성화시킨다. (enable_functions는 반대 역할)<br>
④ function code의 인터널 테이블<br>
ui_functions 타입의 인터널 테이블이며 Context 메뉴의 Function Cocde들을 추가해서 스크립트를 통해 메서드에서 활용할 수 있도록 한다.