REPORT Z14_08.

CLASS vehicle DEFINITION INHERITING FROM object.
    PUBLIC SECTION.
        METHODS: create,
                    drive.
    PROTECTED SECTION.
        DATA speed TYPe i VALUE '100'.
ENDCLASS.

CLASS plane DEFINITION INHERITING FROM vehicle.
    PUBLIC SECTION.
        METHODS: fly.
ENDCLASS.

CLASS vehicle IMPLEMENTATION.
    METHOD create.
    ENDMETHOD.
    METHOD drive.
        speed = speed + 100.
        WRITE : 'Driving is possible', 'Current Speed:', speed.
    ENDMETHOD.
ENDCLASS.

CLASS plane IMPLEMENTATION.
    METHOD fly.
        speed = speed + 1000.
    ENDMETHOD.
ENDCLASS.

DATA : car TYPE REF TO vehicle,
       air TYPE REF to plane.

START-OF-SELECTION.
    CREATE OBJECT: car.
    air ?= car.       

    CALL METHOD: air->drive.
    