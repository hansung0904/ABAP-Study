REPORT Z15_22.
---------> 중 략 <---------
DATA: BEGIN OF gt_sflight OCCURS 0.
    INCLUDE STRUCTURE sflight.

DATA: cellcolor TYPE lvc_t_scol.
DATA: END OF gt_sflight.
---------> 중 략 <---------

FORM setting_layout CHANGING p_layout TYPE lvc_s_layo.
    p_layout-ctab_fname = 'CELLCOLOR'.
ENDFORM.

---------> 중 략 <---------

FORM setting_cell.
DATA : lt_color     TYPE    lvc_t_scol,
       ls_color     TYPE    lvc_s_scol,
       ls_fieldcat  TYPE    lvc_s_fcat,
       l_mode       TYPE    raw4,
       l_type(4)    TYPE    c,
       index        TYPE    i.

LOOP AT gt_sflight.
    index = index + 1.
    CLEAR : lt_color[].
    LOOP AT gt_fieldcat INTO ls_fieldcat.
        CLEAR ls_color.
        ls_color-fname = ls_fieldcat-FIELDNAME.
    IF ls_color-fname EQ 'PLANETYPE'.
        CASE gt_sflight-planetype.
        WHEN '747-400'.
            ls_color-color-col = 5.
            ls_color-color-int = 0.
        WHEN 'A319'.
            ls_color-color-col = 3.
            ls_color-color-int = 0.
        WHEN 'A310-300'        
            ls_color-color-col = 6.
            ls_color-color-int = 0.
        ENDCASE.
        INSERT ls_color INTO TABLE lt_color.
    ENDIF.
    ENDLOOP.

CLAER : gt_sflight-cellcolor[].
    INSERT LINES OF lt_color
        INTO TABLE gt_sflight-cellcolor.
    MODIFY gt_sflight INDEX index.
ENDLOOP.
ENDFORM.    