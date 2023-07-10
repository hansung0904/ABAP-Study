# IT_TOOLBAR_EXCLUDING 파라미터
ALV GRID 컨트롤에서 숨기고 싶은 버튼이 있는 경우 사용한다. <br>

***예를 들어 기능직 사원에게는 레이아웃을 저장할 수 있는 버튼을 숨겨야 할 필요성이 발생할 수 있다.***

이럴 경우는 레이아웃 버튼을 사용자에 따라 보이게 하거나 숨기게 할 수 있다.

```ABAP
REPORT Z15_08.

DATA : gt_toolbar TYPE ui_functions.
-------------------------> 중 략 <-------------------------
PERFROM setting_toolbar.

FORM setting_toolbar.
    DATA : l_exclude TYPTE ui_func.

    l_exclude = cl_gui_alv_grid=>mc_fc_save_variant.
    APPEND l_exclude TO gt_toolbar.

    l_excldue = cl_gui_alv_grid=>mc_fc_maintain_variant.
    APPNED l_exclude TO gt_toolbar.
    ENDFORM.
    -------------------------> 중 략 <-------------------------

CALL METHOD g_grid->set_table_for_first_display
    EXPORTING
        i_structure_name = 'SFLIGHT'
        i_save = 'A'
        is_variant = gs_variant
        i_default = ' '
        is_layout = gs_latyout
        it_tollbar_excluding = gt_toolbar
    CHANGING    
        it_outtab = gt_sflight.
```