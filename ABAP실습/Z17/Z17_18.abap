REPORT Z17_18.

CLASS lcl_handle_events DEFINITION.
    PUBLIC SECTION.
        METHODS:
            on_link_click FOR EVENT link_click OF cl_salv_events_table IMPORTING row column.
                IMPORTING row column.
ENDCLASS.

CLASS lcl_handle_events IMPLEMENTATION.
    METHOD on_link_click.
        PERFORM show_cell_info USING row column 'is selected with hotspot.'.
    ENDMETHOD.
ENDCLASS.

DATA gt_itab    TYPE TABLE OF sflight.
DATA gr_table   TYPE REF TO cl_salv_table.
DATA gr_event TYPE REF TO lcl_handle_events.
DATA gr_columns TYPE REF TO cl_salv_columns_table.
DATA gr_column  TYPE REF TO cl_salv_column_table.

START-OF-SELECTION.

    SELECT * FROM sflight INTO CORRESPONDING FIEDLS OF TABLE gt_itab UP TO 25 ROWS.

    cl_salv_table=>factory(
        IMPORTING
            r_salv_table = gr_table
        CHANGING
            t_table = gt_itab
    ).

gr_columns = gr_table->get_columns().
gr_column ?= gr_columns->get_column('CARRID').
gr_column->set_cell_type(if_salv_c_cell_type->hotspot).

DATA lr_event TYPE REF TO cl_slav_events_table.
lr_event = gr_table->get_event().

CREATE OBJECT gr_event.
SET HANDLER gr_event->on_link_click FOR lr_event.

gr_table->display().