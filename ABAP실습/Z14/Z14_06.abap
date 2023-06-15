REPORT Z14_06.

CLASS c1 DEFNITION.
    PROTECTED SECTION.
        DATA : I_num TYPE i.
ENDCLASS.                       "c1 DEFINITION

CLASS c2 DEFINITION INHERITING FROM c1.
    PUBLIC SECTION.
        METHODS : set_data IMPORTING p_imp TYPE i,
                  get_data EXPORTING p_exp TYPE i.
ENDCLASS.

CLASS c2 IMPLEMENTATION.
    METHOD set_data.
        I_num = p_imp.
    ENDMETHOD.
    
    METHOD get_data.
        p_exp = I_num + 1.
    ENDMETHOD.
ENDCLASS.

DATA: go_cref TYPE REF TO c2.
DATA: gv_data TYPE i.

START-OF-SELECTION.
    CREATE OBJECT go_cref.
    CALL METHOD: go_cref->set_data
                 EXPORTING p_imp = '10'.

    CALL METHOD: go_cref->get_data
                 IMPORTING p_exp = gv_data.

WRITE : / 'GET_DATA Method : ', gv_data.