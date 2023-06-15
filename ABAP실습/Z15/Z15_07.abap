REPORT Z15_07.

DATA : gs_layout TYPE lvc_s_layo.

PERFORM setting_layout CHANGING gs_layout.

FORM setting_layout CHANGING p_layout TYPE lvc_s_layo.

    p_layout-cwidth_opt = 'X'.       "칼럼 길이 자동조절
    p_layout-grid_title = 'LAYOUT TEST'. "타이틀 바
    p_layout-sel_mode = 'D'.
    p_layout-zebra = 'X'.               "Stripe 속성 지정
    
ENDFORM.

CALL METHOD g_grid->set_table_for_first_display
    EXPORTING
        i_structrue_name = 'SFLIGHT'
        i_save           = 'A'
        is_variant = gs_variant
        is_default = ' '
        is_layout = gs_layout
        CHANGING
            it_outtab = gt_sflight.