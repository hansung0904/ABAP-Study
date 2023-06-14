REPORT Z15_14.
TYPE-POOLS: icon.
CLASS lcl_event_receiver DEFINITION.
    PUBLIC SECTION.
        METHODS : handle_command
            FOR EVENT user_command OF CL_GUI_ALV_GRID
            IMPORTING e_ucomm.
ENDCLASS.

CLASS lcl_event_receiver IMPLEMENTATION.
    METHOD handle_command.

        DATA : l_scroll TYPE lvc_s_stbl.

        CASE e_ucomm.
            WHEN 'RESH'
                SELECT * FROM sflight INTO TABLE gt_sflight.
                l_scroll-row = 'X'
                l_scroll-col = 'X'.

                CALL METHOD g_grid->refresh_table_display
                EXPORTING
                    i_soft_refresh = ''
                    is_stable = l_scroll.
        ENDCASE.
    ENDMETHOD.
--------------------> 중략 <--------------------

DATA : event_receiver TYPE REF TO lcl_event_receiver.
CREATE OBJECT event_receiver.
SET HANDLER event_receiver->handle_command FOR g_grid.
