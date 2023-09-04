# ALV 레이아웃 선택
레이아웃을 저장했다면, 리포트 프로그램에서 레이아웃을 선택할 수 있는 기능이 추가되어야 한다. <BR>
레이아웃을 참고하는 파라미터를 생성해서, AT SELECTION-SCREEN 이벤트에 Possible Entry를 띄워 주는 소스를 추가해본다.
```abap
REPORT Z15_05.

DATA : CON1_REF TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA : G_GRID TYPE REF TO CL_GUI_ALV_GRID,
       GS_VARIANT LIKE DISVARIANT,
       GS_CS_VARIANT LIKE DISVARIANT,
       GT_SFLIGHT TYPE TABLE OF SFLIGHT.

PARAMETERS : P_VARI LIKE DISVARIANT-VARIANT.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_VARI.
    GS_VARIANT-REPORT = SY-REPID.
    CALL FUNCTION 'REUSE_ALV_VARIANT_F4'.
        EXPORTING
            IS_VARIANT = GS_VARIANT
            I_SAVE = 'A'
        IMPORTING
            ES_VARIANT = GS_VARIANT
        EXCEPTIONS
            NOT_FOUND = 1
            PROGRAM_ERROR = 2
            OTHERS = 3.

IF SY-SUBRC EQ 0.
    P_VARI = GS_VARIANT-VARIANT.
ENDIF.

START-OF-SELECTION.
```

**I_SAVE 파라미터** <BR>
set_table_for_first_display 함수의 I_SAVE 파라미터는 앞에서 설명했으므로 간단히 값에 대한 정리만 하고 넘어간다.

- X
  - Global 레이아웃 세팅만 가능함.
- U
  - 특정 사용자에 한해서 레이아웃 세팅만 가능함.
- A
  - X와 U둘 다 가능함
- SPACE
  - 레이아웃 저장을 하지 않음.

**I_DEFAULT 파라미터** <BR>
사용자가 Default 변형을 저장할 수 있는지를 결정하게 한다.
- X
  - Default 변형을 저장할 수 있다.
- SPACE
  - Default 변형을 저장할 수 없다.

```abap
REPORT Z15_06.
* 중략

CALL METHOD G_GRID->set_table_for_first_display
    EXPORTING
        I_STRUCTURE_NAME = 'SFLIGHT'
        I_SAVE           = 'A'
        IS_VARIANT       = GS_VARIANT
        I_DEFAULT        = ' '
    CHANGING
        IT_OUTTAB        = GT_SFLIGHT.        
```

I_DEFAULT 파라미터의 값을 초기화하면 레이아웃 설정 기능이 비활성화된다.

**IS_LAYOUT 파라미터** <BR>
IS_LAYOUT 파라미터를 이용해서 합계 금액을 보여주거나 줄무늬 패턴으로 조회되도록 하는 등 ALV GRID 컨트롤의 화면 속성을 정의한다. <BR>
레이아웃은 LVC_S_LAYO 타입의 구조체이다.

IS_LAYOUT 파라미터 옵션
- CTAB_FNAME
  - 필드 셀의 색상을 지정
- CWIDTH_OPT
  - 칼럼 길이 지정
- DETAILINIT
  - 상세 화면에서 기본 값 보여줄 지 말지 지정
- EXCP_CONDS
  - 예외 사항의 필드 Sub Total을 보여줌.
- EXCP_FNAME
  - 예외 사항 필드를 지정한다.
- EXCP_LED
  - 예외 사항 필드를 신호등 표시가 아니라, LED로 보여준다.
- EXCP_ROLLN
  - 예외 사항 필드에 대한 도움말을 표시한다.
- GRID_TITLE
  - 타이틀 바의 내역을 지정한다.
- INFO_FNAME
  - 라인의 색상을 지정한다.
- KEYHOT
  - HOTSPOT으로 지정할 Key 필드를 지정한다.
- NO_HEADERS
  - 칼럼 헤더가 보이지 않는다.
- NO_HGRIDLN
  - GRID의 수평선이 보이지 않는다.
- NO_MERGING
  - 칼럼을 정렬할 때, 값의 셀 합침을 막는다.
- NO_ROWMARK
  - GRID의 라인을 선택할 수 있는 버튼을 없앤다. <BR> SEL_MODE = 'D'이면 라인 버튼을 없앰 <BR> SEL_MODE = 'A'이면 칼럼/라인 버튼을 없앰
- NO_TOOLBAR
  - 툴바를 보이지 않는다.
- NO_TOTLINE
  - Total 라인을 보이지 않는다.
- NO_VGRIDLN
  - Grid의 수직선을 보이지 않는다.
- NUMC_TOTAL
  - NOMC 필드의 합계 금액을 보여준다.
- S_DRAGDROP
  - Drag & Drop 컨트롤을 세팅한다. <br> (라인의 복사, 이동 등의 기능)
- SEL_MODE
  - Selection mode를 세팅한다. <br> (A, B, C, D, SPACE)
- SGL_CLK_HD
  - 칼럼 헤더를 클릭했을 때 SORT를 수행한다.
- SMALLTITLE
  - Title Size를 결정한다.
- TOTALS_BEF
  - 합계 금액을 맨 위의 라인에 보여준다.
- ZEBRA
  - 라인 단위별로 줄무늬 패턴을 세팅한다.

```ABAP
REPORT Z15_07.

DATA : gs_layout        TYPE    lvc_s_layo.

PERFORM setting_layout CHANGING gs_layout.

FORM setting_layout    CHANGING p_layout TYPE lvc_s_layo.
    p_layout-cwidth_opt = 'X'.
    p_layout-grid_title = 'LAYOUT TEST'.
    p_layout-sel_mode   = 'D'.
    p_layout-zebra      = 'X'.
ENDFORM.

CALL METHOD g_grid->set_table_for_frist_display
    EXPORTING
        i_structure_name = 'SFLIGHT'
        i_save           = 'A'
        is_variant       = gs_variant
        i_default        = ' '
        is_layout        = gs_layout
    CHANGING
        it_outtab        = gt_sflight.
```

**IT_OUTTAB 파라미터** <BR>
조회될 데이터의 아웃풋 테이블을 정의한다. 다시 말해서 ALV에 조회될 데이터를 가지는 인터널 테이블을 지정하는 파라미터이다.

**IT_FIELDCATALOG 파라미터** <BR>
조회될 데이터의 타입 및 아웃풋 테이블의 구조를 결정한다.

**IT_TOOLBAR_EXCLUDING 파라미터** <BR>
ALV GRID 컨트롤에서 숨기고 싶은 버튼이 있는 경우 사용한다. 예를 들어 기능직 사원에게는 레이아웃을 저장할 수 있는 버튼을 숨겨야 할 필요성이 발생할 수 있다. <BR>
이럴 경우는 레이아웃 버튼을 사용자에 따라 보이게 하거나 숨기게 할 수 있다.
```ABAP
REPORT Z15_08.

DATA : GT_TOOLBAR       TYPE    UI_FUNCTIONS.
* 중략
PERFORM SETTING_TOOLBAR.

FORM SETTING_TOOLBAR.
    DATA : L_EXCLUDE TYPE UI_FUNC.

    L_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_SAVE_VARIANT.
    APPEND L_EXCLUDE TO GT_TOOLBAR.

    L_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_MAINTAIN_VARIANT.
    APPEND L_EXCLUDE TO GT_TOOLBAR.
    ENDFORM.
* 중략
CALL METHOD G_GRID->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
        I_STRUCTURE_NAME = 'SFLIGHT'
        I_SAVE           = 'A'
        IS_VARIANT       = GS_VARIANT
        I_DEFAULT        = ' '
        IS_LAYOUT        = GS_LAYOUT
        IT_TOOLBAR_EXCLUDING = GT_TOOLBAR
    CHANGING
        IT_OUTTAB        = GT_SFLIGHT.        
```
**IT_SORT 파라미터** <BR>
ALV 실행 시 데이터가 정렬이 된 상태로 조회되도록 설정한다. LVC_T_SORT 타입으로 선언된 인터널 테이블을 선언해서 이 테이블에 정렬하고자 하는 필드를 추가하면 된다. <BR>
LVC_T_SORT에서 'T'는 테이블을 의미하며 LVC_S_SORT에서 'S'는 구조체를 의미한다. <BR>
SORT 테이블의 옵션 중 Subtot은 정렬 필드 기준으로 합계 금액과 전체 합계 금액을 보여주는 것을 세팅한다.

IT_SORT 파라미터에 사용되는 주요 속성들을 설명한다.
- SPOS
  - 숫자 (정렬 순서를 지정한다.)
- FIELDNAME
  - 필드명 (정렬이 필요한 필드명을 지정한다.)
- UP
  - ",'X' ( 오름 차순 정렬을 설정한다.)
- DOWN
  - ", 'X' ( 내림 차순 정렬을 설정한다.)

```ABAP
REPORT Z15_09.

DATA : GT_SORT TYPE LVC_T_SORT.

PERFORM SETTING_SORT.
FORM SETTING_SORT.
    DATA : LS_SORT TYPE LVC_S_SORT.

LS_SORT-SPOS = '1'.
    LS_SORT-FIELDNAME = 'CARRID'.
    LS_SORT-UP = 'X'.
    LS_SORT-SUBTOT = 'X'.
    APPEND LS_SORT TO GT_SORT.
ENDFORM.

* 중략

CALL METHOD G_GRID->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
        I_STRCTURE_NAME = 'SFLIGHT'
        I_SAVE          = 'A'
        IS_VARIANT      = GS_VARIANT
        I_DEFAULT       = ' ' 
        IS_LAYOUT       = GS_LAYOUT
        IT_TOOLBAR_EXCLUDING = GT_TOOLBAR
    CHANGING
        IT_OUTTAB       = GT_SFLIGHT
        IT_SORT         = GT_SORT.
ENDFORM.                    
```