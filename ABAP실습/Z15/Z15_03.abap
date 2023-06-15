REPORT Z15_03.

DATA : g_docking TYPE REF TO cl_gui_docking_container,
       g_grid TYPE REF TO cl_gui_alv_grid.

DATA : gt_sflight TYPE TABLE OF sflight.

START-OF-SELECTION.

    SELECT * FROM sflight
        INTO TABLE gt_sflight UP TO 25 ROWS.

    CALL SCREEN 100.
    
MODULE init_con OUTPUT.
    CHECK g_docking is INITIAL.
    
        CREATE OBJECT g_docking
            EXPORTING
                repid = sy-repid
                dynnr = sy-dynnr
                extension = 2000.

        CREATE OBJECT g_grid
            EXPORTING
                i_parent = g_docking.
                
        CALL METHOD g_grid->set_table_for_first_display        
            EXPORTING
                i_structure_name = 'SFLIGHT'
            CHANGING
                it_outtab = gt_sflight.
ENDMODULE.                
