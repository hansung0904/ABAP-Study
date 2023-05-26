REPORT Z14_11.

CLASS c1 DEFINITION.
    PUBLIC SECTION.
        DATA : gt_itab TYPE TABLE OF sflight,
               gs_str TYPE sflight.

        DATA : gv_carrid TYPE s_carr_id,
               gv_connid TYPE s_conn_id.
               
        METHODS:constructor IMPORTING i_carrid TYPE s_carr_id
                                      i_connid TYPE s_conn_id.
        METHODS:get_data.

ENDCLASS.

CLASS c1 IMPLEMENTATION.
    METHOD: constructor.
        gv_carrid = i_carrid.
        gv_connid = i_connid.
    ENDMETHOD.

    METHOD: get_data.
        SELECT * INTO TABLE gt_itab
        FROM sflight
        WHERE carrid = gv_carrid
        AND connid = gv_connid.
    ENDMETHOD.
ENDCLASS.

DATA go_oref TYPE REF TO c1.

START-OF-SELECTION.
    CREATE OBJECT go_oref
        EXPORTING
            i_carrid = 'AA'
            i_connid = '0017'.

    CALL METHOD go_oref->get_data.
    
    LOOP AT go_oref->gt_itab INTO go_oref->gs_str.

        WRITE :/ go_oref->gs_str-carrid, go_oref->gs_str-connid, go_oref->gs_sttr-fldate.
    ENDLOOP.    