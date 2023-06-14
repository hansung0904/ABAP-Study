REPORT Z15_11.

DATA:ls_scroll TYPE lvc_s_stbl.
     ls_scroll-row = 'X'
     ls_scroll-col = 'X'

CALL METHOD g_grid->refresh_table_display
    EXPORTING
        i_soft_refresh = 'X'
        is_stable = l_scrool.     