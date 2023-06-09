# I_STRUCTURE_NAME 파라미터
아웃풋 테이블의 형태를 만들려면 SFLIGHT와 같은 ABAP Dictionary 구조체 이름을 입력한다. <br>
이 파라미터를 설정하게 되면 필드 카탈로그는 구조체에 맞게 자동으로 생성된다
```ABAP
DATA: g_g_grid TYPE REF TO cl_gui_alv_grid.
      gt_sflight TYPE TABLE OF sflight.

CALL METHOD g_grid-> set_table _for_frist_display
    EXPORTING
        I_STRUCTURE_NAME = 'SFLIGHT'
    CHANGING
        IT_OUTTAB = GT_SFLIGHT.          
```