REPORT Z17_09.

DATA gt_itab TYPE TABLE OF sflight.
DATA gr_table TYPE REF TO cl_salv_table.
DATA gr_colums TYPE REF TO cl_salv_columns_table.
DATA gr_column TYPE REF TO cl_salv_column_table.

SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_itab
UP TO 25 ROWS.

cl_salv_table=>factory(
    IMPORTING
        r_salv_Table = gr_table
    CHANGING
        t_table      = gt_itab).

gr_columns = gr_table->get_columns().
gr_column ?= gr_columns->get_column ('CARRID').
gr_column->set_long_text ('Long Text').
gr_column->set_medium_text ('Medium Text').
gr_column->set_shour_text('Short Text').

gr_table->display().