REPORT Z15_16.

TYPES : BEGIN OF t_str.
    INCLUDE STRUCTURE sflight.

TYPES : company TYPE c LENGTH 6.
TYPES : END OF t_str.

DATA : gt_sflight TYPE TABLE OF T_STR.

DATA : gt_fieldcat TYPE lvc_t_fcat.
---------------> 중 략 <---------------
PERFORM setting_catalog.
FORM setting_catalog.
    ls_fieldcat-fieldname = 'COMPANY'.
    ls_fieldcat-coltext = 'COMPANY INFO'.
    ls_fieldcat-just = 'C'.
    ls_fieldcat-key = 'X'.
    ls_fieldcat-outputlen = '6'.

    APPEND ls_fieldcat TO gt_filedcat.
ENDFORM.
---------------> 중 략 <---------------
CALL METHOD g_grid->set_table_for_first_display
    EXPORTING
        i_structure_name = 'SFLIGHT'
        i_save = 'A'
        is_variant = gs_variant
        i_default = ' '
        is_layout = gs_layout
        it_toolbar_excluding = gs_toolbar
        CHANGING
            it_outtab = gt_sflgiht
            it_fieldcatalog = gt_fieldcat
            it_sort = gt_sort.