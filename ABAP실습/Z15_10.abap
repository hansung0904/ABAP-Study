REPORT Z15_10.

----------> 중 략 <----------
MODULE user_command_0100 INPUT.
DATA : l_row TYPE i,
       l_value TYPE c,
       l_col TYPE i,
       ls_row TYPE lvc_s_row,
       ls_col TYPE lvc_s_col,
       ls_roidTYPE lvc_s_roid.

CALL METHOD g_rid->get_current_cell
    IMPORTING
        e_row   =   l_row
        e_value =   l_value
        e_col   =   l_col
        es_row_id = ls_row
        es_col_id = ls_col
        es_row_no = ls_roid.
ENDMODULE.