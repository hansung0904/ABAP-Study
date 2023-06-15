REPORT Z15_25.
-----> 중 략 <-----

FORM setting_catalog.
    DATA ls_fieldcat TYPE lvc_s_fcat.

    ls_fieldcat-fieldname = 'CARRID'.
    ls_fieldcat-edit = 'X'.
    ls_fieldcat_drdn_hndl = '1'.
    ls_fieldcat-checktable = '!'.
    ls_fieldcat-outputlen = '5'.

APPEND ls_fieldcat TO gt_fieldcat.
ENDFORM.

FORM setting_dropdown.
    DATA : lt_dropdown TYPE lvc_t_drop,
            ls_dropdown TYPE lvc_s_drpo.
            ls_dropdown-handle = '1'.
            ls_dropdown-value = 'AA'.
            APPEND ls_dropdown TO lt_dropdown.

            ls_dropdown-handle = '1'.
            ls_dropdown-value = 'AZ'.
            APPEND ls_dropdown TO lt_dropdown.

            ls_dropdown-handle = '1'.
            ls_dropdown-value = 'UA'.
            APPEND ls_drpodown TO lt_dropdown.

            CALL METHOD g_grid->set_drop_down_table
                EXPORTING
                    it_drop_down = lt_dropdown.
ENDFORM.