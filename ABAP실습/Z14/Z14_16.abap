REPORT Z14_16.

INTERFACE account.
    METHODS calc.
    DATA balance TYPE i.
ENDINTERFACE.

CLASS CLS1 DEFINITION.
    PUBLIC SECTION.
        INTERFACE account.
ENDCLASS.        

CLASS CLS1 IMPLEMENTATION.
    METHOD account~calc.
        WRITE : / 'Deposit money is : ' , account~balance.
    ENDMETHOD.
ENDCLASS.

CLASS CLS2 DEFINITION.
    PUBLIC SECTION.
        INTERFACES account.
ENDCLASS.

CLASS CLS2 IMPLEMENTATION.
    METHOD account~calc.
        WRITE : / 'Withdrawl money is : ', account~balance.
    ENDMETHOD.
ENDCLASS.

DATA : cref1 TYPE REF TO CLS1,
       cref2 TYPE REF TO CLS2,
       iref  TYPE REF TO account.

START-OF-SELECTION.

    CREATE OBJECT : cref1, cref2.

    cref1->account~balance = 300.
    CALL METHOD: cref1->account~calc.

    iref = cref1.
    CALL METHOD iref->calc.

    cref2->account~balance = '-200'.
    CALL METHOD: cref->account~calc.

    iref = cref2.
CALL METHOD iref->calc.