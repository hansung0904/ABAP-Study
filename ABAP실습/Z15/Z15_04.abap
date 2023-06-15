REPORT Z15_04.

DATA : con1_ref TYPE REF TO cl_gui_custom_container.
DATA : g_grid TYPE REF TO cl_gui_alv_grid.
DATA : gs_variant TYPE disvariant.
DATA : gt_sflight TYPE TABLE OF sflight.

START-OF-SELECTION.

SELECT * FROM sflight INTO TABLE gt_sflight.
    UP TO 25 ROWS.

gs_variant-report = sy-repid.
gs_variant-username = sy-uname.

CALL SCREEN 100.

gs_variant-report = sy-repid.
gs_variant-username = sy-uname.

    CALL METHOD g_grid->set_table_for_frist_display
        EXPORTING
            i_structure_name = 'SFLIGHT'
            is_variant = gs_variant
            i_save = 'A'
        CHANGING
            it_outtab = gt_sflight.    
