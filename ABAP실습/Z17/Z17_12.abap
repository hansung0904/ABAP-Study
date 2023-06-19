REPORT Z17_12.

DATA gt_itab    TYPE TABLE OF SFLIGHT.
DATA gr_table   TYPE REF TO cl_salv_table.
DATA gr_selection TYPE REF TO cl_salv_selections.

SELECT * FROM sflight INTO CORRESPONDING FIEDLS OF TABLE gt_itab
UP TO 25 ROWS>

cl_salv_table=>factory(
    IMPORTING
        r_salv_table = gr_table
    CHANGING
        t_table = gt_itab    
).

gr_selection = gr_table->get_selections().
gr_selection->set_slectino_mode (if_salv_c_selection_mode=>row_column).

gr_table->display().