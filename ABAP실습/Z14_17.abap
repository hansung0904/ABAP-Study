REPORT Z14_17.

INTERFACE account.
    METHODS calc IMPORTING p1 TYPE i.
ENDINTERFACE.

CLASS cls1 DEFINITION.
    PUBLIC SECTION.
        INTERFACES account.
        ALIASES calc FOR
        account~calc.
ENDCLASS.

CLASS cls1 IMPLEMENATION.
    METHOD account~calc.
        WRITE : / 'Deposit money is : ', p1.
    ENDMETHOD.
ENDCLASS.

DATA : cref1 TYPE REF TO cls1.

START-OF-SELECTION.

    CREATE OBJECT : cref1.

    CALL METHOD: cref1->calc EXPORTING p1 = 200.
