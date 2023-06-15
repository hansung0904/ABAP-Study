REPORT Z14_12.

CLASS cls1 DEFINITION INHERITING FROM object.
    PUBLIC SECTION.
        METHODS: create.
ENDCLASS.

CLASS cls1 IMPLEMENTATION.
    METHOD CREATE.
        WRITE: / 'Original method is called'.
    ENDMETHOD.
ENDCLASS.

CLASS cls2 DEFINITION INHERITING FROM cls1.
    PUBLIC SECTION.
        METHODS: create REDEFINITION.
ENDCLASS.

CLASS cls2 IMPLEMENTATION.
    METHOD create.
        CALL METHOD super->create.
        WRITE: / 'Method is redefined'.
    ENDMETHOD.
ENDCLASS.

DATA : go_obj TYPE REF TO cls2.
    CREATE OBJECT: go_obj.

    CALL METHOD: go_obj->create. 