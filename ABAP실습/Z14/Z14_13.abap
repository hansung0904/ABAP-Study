REPORT Z14_13.
*-----------------------------------------*
*   CLASS CLS1 DEFINITION
*-----------------------------------------*

CLASS c1s1 DEFINITION.
    PUBLIC SECTION.
        CLASS-DATA gv_var TYPE String.
        CLASS-METHODS stat_meth.
ENDCLASS.

*-----------------------------------------*
*   CLASS CLS1 IMPLEMENTATION
*-----------------------------------------*

CLASS cls1 IMPLEMENTATION.
    METHOD stat_meth.
        WRITE / 'Static method is called.'.
    ENDMETHOD.
ENDCLASS.

*-----------------------------------------*
*   CLASS CLS2 DEFINITION
*-----------------------------------------*

CLASS cls2 DEFINITION INHERITING FROM cls1.

ENDCLASS.

START-OF-SELECTION.
    cls1=>gv_var = 'Static Attribute'.
    WRITE / cls1=>gv_var.
    CALL METHOD cls1=>stat_meth.

    cls2=>gv_var = 'Static Attribute'
    WRITE / cls2=>gv_var.
    CALL METHOD cls2=>stat_meth.