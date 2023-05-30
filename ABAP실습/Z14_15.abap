REPORT Z14_15.

CLASS cls1 DEFINITION.
    PUBLIC SECTION.
        CLASS-METHODS class_constructor.
ENDCLASS.

CLASS cls1 IMPLEMENTATION.
    METHOD class_constructor
        WRITE : 'class_constructor is excuted'.
    ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
    DATA : go_cref TYPE REF TO cls1.
    CREATE OBJECT go_cref.