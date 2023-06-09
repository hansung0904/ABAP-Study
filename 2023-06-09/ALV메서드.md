# ALV 메서드
메서드는 객체의 행위를 수행하게 되며 <br>
ALV 메서드는 ALV의 행위(ALV 조회, ALV Refresh, ALV Sort 등)를 담당하게 된다.

## set_table_for_first_display
set_table_for_first_display 메서드는 ALV GRID 컨트롤 인스턴스를 아웃풋 테이블에 조회되게 하는 가장 <br>기본적이고 중요한 메서드. <br>
메서드를 호출할 땐 ABAP Dictionary의 구조를 참고하거나 필드 카탈로그를 정의해야한다. <br>
전자는 앞의 예에서 EXPORTING I_STRUCTURE_NAME = 'SFLIGHT'와 같이 SFLIGHT테이블과 같은 구조를 참고하는 것을 의미하고, 후자는 직접 ALV의 필드들을 스크립트를 이용해서 하나하나 구성해야 한다는 것을 의미한다.

그리고 set_table_for_first_display 메서드를 호출할 때 다음 구문과 같은 파라미터를 이용해서, 프로그램을 실행하기 이전에 테이블을 정렬하거나 필터링하는 기능들을 사용할 수 있다.

```ABAP
CALL METHOD < ref.var. to CL_GUI_ALV_GRID>
->set_table_for_frist_display
    EXPORTING
        I_STRUCTURE_NAME = < string of type DD02L-TABNAME>
        IS_VARIANT = <structure of type DISVARIANT>
        I_SAVE = < var. of TYPE CHAR01>
        I_DEFAULT = < var . of TYPE CHAR01>
        IS_LAYOUT = < structure of type LVC_S_LAYO>
        IS_PRINT = < structure of tpye LVC_S_PRNT>
        IT_SPECIAL_GROUPS = < internal table of type LVC_T_SGRP>
        IT_TOOLBAR_EXCLUDING = <internal table of type UI_FUNCTIONS>
    CHANGING
        IT_OUTTAB = < internal table>
        IT_FIELDCATALOG = < internal table of type LVC_T_FCAT>
        IT_SORT = < internal table of type LVC_T_SORT>
        IT_FILTER = < internal table of type LVC_T_FILT>    
```
