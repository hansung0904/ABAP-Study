# ALV 레이아웃 - ZEBRA 속성 살펴보기
ALV 레이아웃 속성 중 ZEBRA는 리스트를 줄무늬 패턴으로 조회되도록 설정한다.

① 프로그램 선언부에 레이아웃 변수 선언. <BR>
프로그램의 구조화 및 가독성을 높이도록 데이터 선언부는 INCLUDE 프로그램 안에 두는 것이 바람직
```ABAP
REPORT Z16_07.

TYPE-POOLS : slis.

DATA gt_fieldcat        TYPE        slis_t_fieldcat_alv.
DATA gs_fieldcat        TYPE        slis_fieldcat_alv.

DATA gt_events          TYPE        slis_t_event.
DATA gs_event           TYPE        slis_alv_event.

DATA gs_layout          TYPE        slis_layout_alv.
```

② 레이아웃 변수의 ZEBRA 속성을 'X'로 설정
```ABAP
gs_layout-zebra = 'X'.
```

③ ALV 함수 호출 시 파라미터 is_layout 추가
```ABAP
CALL FUNCTION
'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
        i_callback_program = sy-repid
        it_events   =   gt_events
        it_fieldcat =   gt_fieldcat
        is_layout   =   gs_layout
    TABLES
        t_outtab    =   gt_itab.    
```