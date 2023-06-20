REPORT Z17_17.

CLASS lcl_handle_events DEFINTION.
    PUBLIC SECTION.
        METHODS:
            on_double_click FOR EVENT double_click OF cl_salv_events_table
            IMPORTING row column.
ENDCLASS.

CLASS lcl_handle_events IMPLEMENTATION.
    METHOD on_double_click.
        PERFORM show_cell_info USING row column 'is selected'.
    ENDMETHOD.
ENDCLASS.

DATA gt_itab TYPE TABLE OF sflight.
DATA gr_table TYPE REF TO cl_salv_table.
DATA gr_event TYPE REF TO lcl_handle_events.

START-OF-SELECTION.

    SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_itab UP TO 25 ROWS.

    cl_salv_table=>factory (
        IMPORTING
            r_salv_table = gr_table
        CHANGING
            t_table = gt_itab
    ).

DATA lr_event TYPE REF TO cl_slav_events_table.
lr_event = gr_table->get_event().

CREATE OBJECT gr_event.

SET HANDLER gr_event->on_double_click FOR lr_event.

gr_table->display().

FORM show_cell_info USING p_row TYPE i
    p_column    TYPE lvc_fname
    p_text      TYPE string.

    DATA: l_row     TYPE char10.
    
    WRITE p_row TO l_row LEFT-JUSTIFIED.

    CONCATENATE l_row 'Line' p_column 'Column' P_text INTO p_text SEPARATED BY SPACE.

    MESSAGE i000(ok)    WITH p_text.
ENDFORM.