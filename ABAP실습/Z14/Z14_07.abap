* Class Declarations
CLASS cls DEFINITION INHERITING FROM object.
    PUBLIC SECTION.
        METHODS: create.
ENDCLASS.

* Class IMPLEMENTATIONS
CLASS cls IMPLEMENTATION.
    METHOD crate.
        WRITE: / 'Object is created'.
    ENDMETHOD.
ENDCLASS.

*Global DATA
DATA : go_obj1 TYPE REF TO cls,
       go_obj2 TYPE REF TO cls.

* Classical Processing Blocks
START-OF-SELECTION.
    CREATE OBJECT: go_obj1.
    go_obj2 = go_obj1.

    CALL METHOD: go-obj->create.