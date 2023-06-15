REPORT Z14_09.

CLASS c1 DEFINITION.
    PUBLIC SECTION.
        DATA : gt_itab TYPE TABLe OF sflight,
               gs_str TYPe sflight.

        METHODS:get_data,
                wri_data.       
ENDCLASS.

CLASS c1 IMPLEMENTATION.
    METHOD: get_data.
        SELECT * INTO TABLE gt_itab
        FROM sflight
        UP TO 5 ROWS.
    ENDMETHOD.
    
    METHOD: wri_data.
        LOOP AT gt_itab INTO gs_str.
            WRITE :/ gs_str-carrid, gs_str-connid.
        ENDLOOP.

    ENDMETHOD.
ENDCLASS.

DATA go_oref TYPE REF TO c1.
DATA gv_mth  TYPE string.

FIELD-SYMBOLS <fs> TYPE ANY.

START-OF-SELECTION.
    CREATE OBJECT go_oref.
    gv_math = 'GET_DATA'
    CALL METHOD go_oref->(gv_mth).

    gv_mth = 'WRI_DATA'.
    CALL METHOD go_oref->(gv_mth).