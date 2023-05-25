REPORT Z14_05

CLASS c1 DEFINITION.
    PUBLIC SECTION.
        METHODS : set_data IMPORTING p_imp TYPE i,
                  get_data EXPORTING p_exp TYPE i.

    * PROTECTED SECTION.              
        DATA : I_num TYPE i. 
ENDCLASS.           "C1 DEFINITION

CLASS c1 IMPLEMENTATION.
        METHOD set_data.
            I_num = p_imp.
        ENDMETHOD.
        
        METHOD get_data.
            p_exp = 1_num + 1.
        ENDMETHOD.
ENDCLASS.

DATA : go_cref TYPE REF TO c1.
DATA : gv_data TYPE i.

START-0F-SELECTION.

    CREATE OBJECT go_cref.
    CALL METHOD: go_cref->set_data
                 EXPORTING p_imp = '10'.
    WRITE : 'SET_DATA Method : ', go_cref->I-num.
    
    CALL METHOD: go_cref->get_data
                 IMPORTING p_exp = gv_data.

    WRITE : / 'GET_DATA Method : ', gv_data.             