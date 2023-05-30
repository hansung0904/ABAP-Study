REPORT Z14_14.
CLASS cls1 DEFINITION.
    PUBLIC SECTION.
        METHODS constructor.
ENDCLASS.

CLASS cls2 DEFINITION INHERITING FROM cls1.
    PUBLIC SECTION.
        METHODS constructor.
ENDCLASS.

CLASS cls1 IMPLEMENTATION.
    METHOD constructor.
        WRITE / 'Constructor Test'.
    ENDMETHOD.
ENDCLASS.

CLASS cls2 IMPLEMENTATION.
    METHOD constructor.
        super->constructor().
    ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
    DATA : go_cref1 TYPE REF TO cls1,
           go_cref2 TYPE REF TO cls2.

CREATE OBJECT go_cref2.