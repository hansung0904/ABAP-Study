REPORT Z15_15.

DATA : gt_fieldcat TYPE lvc_t_fcat.
---------------> 중략 <---------------
PERFORM setting_catalog.
FORM setting_catalog.
    DATA ls_fieldcat TYPE lvc_s_fcat.

    ls_fieldcat-fieldname = 'CARRID'.
    ls_fieldcat-coltext = 'Carrid ID'.
    ls_fieldcat-just = 'L'.
    ls_fieldcat-key = 'X'.
    ls_fieldcat-outputlen = '2'.
    APPEND ls_fieldcat TO gt_fieldcat.

    ls_fieldcat-fieldname = 'CONNID'.
    ls_fieldcat-coltext = 'Flight Number'.
    ls_fieldcat-just = 'C'.
    ls_fieldcat-key = 'X'.
    ls_fieldcat-outputlen = '4'.
    APPEND ls_fieldcat TO gt_fieldcat.

    ls_fieldcat-fieldname = 'PRICE'.
    ls_fieldcat-colttext = 'Airfare'.
    ls_field-just = 'R'.
    ls_fieldcat-key = ' '.
    ls_fieldcat-outputlen = '15'.
    APPEND ls_fieldcat TO gt_fieldcat.
ENDFORM.
---------------> 중략 <---------------

CALL METHOD g_grid->set_table_for_first_display
    EXPORTING
        i_structrue_name = 'SFLIGHT'
        i_save = 'A'
        is_variant = gs_variant
        i_default = ' '
        is_layout = gs_layout
        it_toolbar_excluding = gs_toolbar
    CHANGING
        it_outtba = gt_sflight
        it_fieldcatalog = gt_fieldcat
        it_sort = gt_sort.
