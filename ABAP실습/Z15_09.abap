REPORT Z15_09.

DATA : gt_sort TYPE lvc_t_sort.
--------------------> 중략 <--------------------
PERFORM setting_sort.
FORM setting_sort.
    DATA : ls_sort TYPE lvc_s_sort.

ls_sort-spos = '1'.
    ls_sort-FIELDNAME = 'CARRID'.
    ls_sort-up = 'X'.
    ls_sort-subtot = 'X'.
    APPEND ls_sort TO gt_sort.
ENDFORM.
--------------------> 중략 <--------------------
CALL METHOD g_grid->set_table_for_first_display
    EXPORTING
        i_structure_name = 'SFLIGHT'
        i_save = 'A'
        is_variant = gs_variant
        i_default = ' '
        is_layout = gs_layout
        it_toolbar_excluding = gt_toolbar
CHANGING
        it_outtab = gt_sflight
        it_sort = gt_sort.
ENDFORM.