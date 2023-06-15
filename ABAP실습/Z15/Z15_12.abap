REPORT Z15_12.

CLASS lcl_event_receiver DEFINITION.
    PUBLIC SECTION.
        METHOD:
        handle_double_click
            FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
                IMPORTING e_row e_column.
ENDCLASS.

CLASS lcl_event_receiver IMPLEMENTATION.
    METHOD handle_double_click.
        LEAVE TO SCREEN 0.
    ENDMETHOD.
ENDCLASS.

    DATA : event_receiver TYPE REF TO lcl_event_receiver.

    CREATE OBJECT event_receiver.
    SET HANDLER event_receiver->handle_double_click FOR g_grid.