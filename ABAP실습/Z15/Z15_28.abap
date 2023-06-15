REPORT Z15_28.

METHOD handle_condext_menu.
    DATA : lt_std_fcodes TYPE ui_functions.
    DATA : lt_own_fcodes TYPE ui_functions.

    CALL METHOD e_object->load_gui_status
        EXPORTING
            program = sy-repid
            status = 'CONTEXT_MENU'
        menu = e_object.
        
    CALL METHOD e_object->add_function
        EXPORTING
            fcode = 'LEAVE'
            text = 'LEAVE PROGRAM'.

    APPEND CL_GUI_ALV_GRID=>mc_fc_col_optimize
        TO lt_std_fcodes.
        
    CALL METHOD e_object->hide_function
        EXPORTING
            fcodes = lt_std_fcodes.
            
    APPEND 'RESH' TO lt_own_fcodes.
    
    CALL METHOD e_object->disable_functions
        EXPORTING
            fcodes = lt_own_fcodes.
ENDMETHOD.