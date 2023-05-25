REPORT Z14_05

CLASS c1 DEFINITION.
    PUBLIC SECTION.
        METHODS : set_data IMPORTING p_imp TYPE i,
                  get_data EXPORTING p_exp TYPE i.

    * PROTECTED SECTION.              
        DATA : I_num TYPE i. 