REPORT Z14_10.

CLASS c1 DEFINITION.
    PUBLIC SECTION.
    DATA : gt_itab TYPE TABLE OF sflight,
           gs_str TYPE sflight.

    METHODS:get_data.

ENDCLASS.

CLASS c1 IMPLEMENTATION.
    METHOD: get_data.
        SELECT * INTO TABLE gt_itab
        FROM sflight
        UP TO 5 ROWS.
    ENDMETHOD.
ENDCLASS.

DATA go_oref TYPE REF TO c1.
DATA gv_mth  TYPE string.
DATA gv_attr TYPE string.

FIELD-SYMBOLS <fs1> TYPE STANDARD TABLE.
FIELD-SYMBOLS <fs2> TYPE STANDARD ANY.
FIELD-SYMBOLS <fs3> TYPE STANDARD ANY.

START-OF-SELECTION.
    CREATE OBJECT go_oref.
    gv_mth = 'GET_DATA'.
    CALL METHOD go_oref->(gv_mth).

    gv_attr = 'GT_ITAB'.
    ASSIGN go_oref->(gv_attr) TO <fs1>.

    LOOP AT <fs1> ASSIGNING <fs2>.
        DO.
            ASSIGN COMPONENT sy-index OF STRUCTURE <fs2> TO <fs3>.
            WRITE : <fs3>.
            IF sy-subrc NE 0.
                EXIT.
            ENDIF.
        ENDDO.
        WRITE : /.
    ENDLOOP.
