# ALV 메서드
이번 절에서는 ALV에 자주 사용되는 메서드를 하나하나 살펴보자. <BR>
앞에서 언급했듯이 메서드는 객체의 행위를 수행하게 되며, ALV 메서드는 ALV의 행위(ALV 조회, ALV Refresh, ALV Sort 등)를 담당하게 된다.

## 1 set_table_for_first_display
set_table_for_first_display 메서드는 ALV_GRID 컨트롤 인스턴스를 아웃풋 테이블에 조회되게 하는 가장 기본적이고 중요한 메서드이다. <BR>
메서드를 호출할 때는 ABAP Dictioanry의 구조를 참고하거나 필드 카탈로그를 정의해야 한다. <br>
전자는 앞의 예에서 EXPORTING I_STRUCTURE_NAME = 'SFLIGHT'와 같이 SFLIGHT 테이블과 같은 구조를 참고하는 것을 의미하며, 후자는 직접 ALV의 필드들을 스크립트를 이용해 하나하나 구서앻야 한다는 것을 의미한다.

그리고 set_table_for_first_display 메서드를 호출할 때 다음 구문과 같은 파라미터를 이용해서, 프로그램을 실행하기 이전에 테이블을 정렬하거나 필터링하는 기능들을 사용할 수 있다.
```ABAP
CALL METHOD < ref.var. to CL_CUI_ALV_GRID >
-> set_table_for_first_display
    EXPORTING
        I_STRUCTURE_NAME        =       < string of type DD02L-TABNAME >
        IS_VARIANT              =       < structure of type DISVARINAT >
        I_SAVE                  =       < var. of TYPE CHAR01 >
        I_DEFAULT               =       < var. of TYPE CHAR01 >
        IS_LAYOUT               =       < strcuture of type LVC_S_LAYO >
        IS_PRINT                =       < structure of type LVC_S_PRNT >
        IT_SPECIAL_GROUPS       =       < internal table of type LVC_T_SGRP >
        IT_TOOLBAR_EXCLUDING    =       < internal table of type UI_FUNCTIONS >

    CHANGING
        IT_OUTTAB               =       < internal table >        
        IT_FIELDCATALOG         =       < internal table of type LVC_T_FCAT >
        IT_SORT                 =       < internal table of type LVC_T_SORT >
        IT_FILTER               =       < internal table of type LVC_T_FILT >
```
set_table_for_first_display 메서드에 사용되는 파라미터의 의미와 속성에 대해서 세부적으로 살펴본다.

**1&#41; I_STRUCTURE_NAME 파라미터** <br>
아웃풋 테이블의 형태를 만들려면 SFLIGHT와 같은 ABAP Dictionary 구조체 이름을 입력한다. <br>
이 파라미터를 설정하게 되면 필드 카탈로그는 구조체에 맞게 자동으로 생성된다. <br>
즉, 프로그램 내에서 필드 카탈로그를 따로 구성할 필요가 없다.
```abap
DATA : g_g_grid TYPE REF TO cl_gui_alv_grid.
       gt_sflight TYPE TABLE OF sflight.

CALL METHOD g_grid-> set_table_for_first_display
    EXPORTING
        I_STRUCTURE_NAME = 'SFLIGHT'.
    CHANGING
        IT_OUTTAB = GT_SFLIGHT.               
```

**2&#41; IS_VARIANT 파라미터** <BR>
ALV 리스트 변형(Variant)을 설정할 수 있다. 리스트 변형은 조회된 화면에서 필드의 순서를 변경하고, 정렬하는 것과 같은 일련의 작업을 하나의 변형으로 저장해서 다음 조회시에도 같은 포맷으로 조회될 수 있도록 한다. <br>
먼저, Report Program에서 레이아웃을 선택할 수 있도록 파라미터 추가 및 기능을 기술해야 한다.

```abap
REPORT Z15_04.

DATA : CON1_REF TYPE REF TO CL_GUI_CUSTOM_CONTAINER.
DATA : G_GRID TYPE REF TO CL_GUI_ALV_GRID.
DATA : GS_VARIANT TYPE DISVARIANT.
DATA : GT_SFLIGHT TYPE TABLE OF SFLIGHT.

START-OF-SELECTION.

SELECT * FROM SFLIGHT INTO TABLE GT_SFLIGHT UP TO 25 ROWS.

GS_VARIANT-REPORT = SY-REPID.
GS_VARIANT-USERNAME = SY-UNAME.

CALL SCAREEN 100.

GS_VARIANT-REPORT = SY-REPID.
GS_VARIANT-USERNAME = SY-UNAME.

    CALL METHOD G_GRID->set_table_for_first_display
        EXPORTING
            I_STRUCTURE_NAME = 'SFLIGHT'
            IS_VARIANT = GS_VARIANT
            I_SAVE     = 'A'
        CHANGING
            IT_OUTTAB = GT_SFLIGHT.            
```