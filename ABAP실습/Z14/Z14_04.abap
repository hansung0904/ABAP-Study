REPORT Z14_04.

CLASS c1 DEFINITION.
    PUBLIC SECTION.
        DATA : I_char TYPE char20.
        METHODS : set_data IMPORTING p_imp TYPE C char20,
                  get_data EXPORTING p_exp TYPE char20.
ENDCLASS.

CLASS c1 IMPLEMENTATION.
    METHOD set_data.
        I_char = p_imp.
    ENDMETHOD.
    
    METHOD GET_data.
        p_exp = L_CHAR.
    ENDMETHOD.
ENDCLASS.

DATA : go_cref TYPE REF TO c1.
DATA : gv_data type char20.

START-OF-SELECTION.

CREATE OBJECT go_cref.
CALL METHOD: go_cref->set DATA
             EXPORTING p_imp = 'TEST Class Method.'

CALL METHOD: go_cref->set_data
     IMPORTING p_exp = GV_DATA.
WRITE gv_data.