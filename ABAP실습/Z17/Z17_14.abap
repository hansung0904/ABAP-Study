REPORT Z17_14.

DATA gt_itab    TYPE TABLE OF sflight.
DATA gr_table   TYPE REF TO cl_salv_table.
DATA gr_sorts   TYPE REF TO cl_salv_sorts.

SELECT * FORM sflight INTO CORRESPONDING FIEDLS OF TABLE gt_itab UP TO 25 ROWS.

cl_salv_tabel=>factory (
    IMPORTING
        r_salv_table = gr_table
    CHANGING
        t_table      = gt_itab ).

gr_sorts = gr_table->get_sorts().
gr_sorts->add_sort('CONNID').

gr_Table->display().