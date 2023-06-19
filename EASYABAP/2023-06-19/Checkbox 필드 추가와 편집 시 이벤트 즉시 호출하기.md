# Checkbox 필드 추가와 편집 시 이벤트 즉시 호출하기
EDIT 모드에서는 사용자가 값을 변경하고 엔터르 입력해야만 'DATA_CHANGED' ALV 이벤트가 호출<BR>
그런데 사용자가 값을 변경하고서 엔터를 입력하지 않고 바로 저장할 때에는 ALV 이벤트가 호출되지 않기 때문에 문제가 발생할 수 있다.

이럴때 ALV GRID 설정을 하는 I_GRID_SETTINGS 파라미터 활용
```ABAP
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
i_grid_settings = gs_glay
```
CL_GUI_ALV_GRID 클래스를 이용한 ALV는 기본으로 사용자가 데이터 편집 'DATA_CHANGED' 이벤트가 수행된다. <br>

필요한 필드 카탈로그 구성
```ABAP
CLEAR : gs_fieldcat.
gs_fieldcat-col_pos = 2.
gs_fieldcat-fieldname = 'CARRID'
gs_fieldcat-seltext_m = 'Air Code'.
APPEND gs_fieldcat
TO gt_fieldcat.

CLEAR : gs_fieldcat.
gs_fieldcat-col_pos = 3.
gs_fieldcat-fieldname = 'CONNID'.
gs_fieldcat-seltext_m = 'Con Number'.
APPEND gs_fieldcat
TO gt_fieldcat.
```

사용자가 체크박스 선택하면 'DATA_CHANGED'이벤트가 즉시 발생하도록 파라미터에 사용될 변수 선언
```ABAP
DATA gs_glay TYPE lvc_s_glay.
```

edt_cll_cb = 'X'선언
```ABAP
gs_glay-edt_cll_cb = 'X'.
```

ALV 함수 호출 시 해당 파라미터 설정
```ABAP
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
        i_callback_program = sy-cprog
        i_grid_settings = gs_glay
        it_fieldcat = gt_fieldcat
        it_events = gt_events
        is_layout = gs_layout
        i_callback_user_command = 'ALV_USER_COMMAND'
    TABLES
        t_outtab = gt_itab.        
```