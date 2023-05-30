REPORT Z14_19.

TABLES:sflight.

SELECT-OPTIONS: s_carrid FOR sflight-carrid.

CLASS c1 DEFINITION.
    PUBLIC SECTION.
        TYPES:BEGIN OF t_sflight,
            carrid TYPE sflight-carrid,
            connid TYPE sflight-connid,
            fldate TYPE sflight-fldate,
        END OF t_sflight.
        
        DATA :gt_itab TYPE STANDARD TABLE OF t_sflight,
              gs_str TYPE t_sflight.

              EVENTS: e1.

        METHODS : get_data ,display_data ,no_data      
            FOR EVENT e1 OF c1.
ENDCLASS.

CLASS c1 IMPLEMENTATION.
    METHOD: get_data.
        SELECT carrid connid fldate FROM sflight.
            INTO TABLE gt_itab
        WHERE carrid IN s_carrid.
        IF sy-subrc <> 0.
            RAISE EVENT e1.
        ELSE.
            CALL METHOD display_data.
        ENDIF.
    ENDMETHOD.

    METHOD:display_data.
        LOOP AT gt_itab INTO gs_str.
            WRITE:/10 gs_str-carrid.
            WRITE:40 gs_str-connid.
            WRITE:60 gs_str-fldate.
        ENDLOOP.
    ENDMETHOD.

    METHOD no_data.
        WRITE:/ 10 'There is no data'.
    ENDMETHOD.
ENDCLASS.

DATA : go_obj TYPE REF TO c1.

START-OF-SELECTION.
    CREATE OBJECT: go_obj.

    SET HANDLER go_obj->no_data FOR: go_obj.

    CALL METHOD go_obj->get_data.