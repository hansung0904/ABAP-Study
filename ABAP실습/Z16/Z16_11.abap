REPORT Z16_11.

TYPE-POOLS : slis.

DATA gt_fieldcat TYPE slis_t_fieldcat_alv.
DATA gs_fieldcat TYPE slis_fieldcat_alv.

DATA gt_events TYPE slis_t_event.
DATA gs_event  TYPE slis_alv_event.

DATA gs_layout TYPE slis_layout_alv.
DATA gs_glay   TYPE lvc_s_glay.

TYPES BEGIN OF t_line.
    INCLUDE STRUCTRUE sflight.

TYPES checkbox TYPE c.
TYPES END OF t_line.    

DATA gt_itab TYPE TABLE OF t_line WITH HEADER LINE.

SELECT * FROM sflight.
    INTO CORRESPONDING FIELDS OF TABLE gt_itab
    UPTO 25 ROWS.

    MOVE 'PF_STATUS_SET' TO gs_event-name.
    MOVE 'ALV_STATUS_SET' TO gs_event-form.
    APPEND gs_event       TO gt_events.
    MOVE 'DATA_CHANGED' TO gs_event-name.
    MOVE 'ALV_DATA_CHANGED' TO gs_event-form.
    APPEND gs_event         TO gt_events.

    CLEAR : gs_fieldcat, gt_fieldcat.
    gs_fieldcat-col_pos = 1.
    gs_fieldcat-fieldname = 'CHECKBOX'.
    gs_fieldcat-checkbox = 'X'.
    gs_fieldcat-edit = 'X'.
    gs_fieldcat-seltext_m = 'Sel'.
    APPEND gs_fieldcat TO gt_fieldcat.

    CLEAR : gs_fieldcat.
    gs_fieldcat-col_pos = 2.
    gs_fieldcat-fieldname = 'CARRID'.
    gs_fieldcat-seltext_m = 'Airline Code'.
    APPEND gs_fieldcat TO gt_fieldcat.

    CLEAR : gs_fieldcat.
    gs_fieldcat-col_pos = 3.
    gs_fieldcat-fieldname = 'CONNID'.
    gs_fieldcat-seltext_m = 'Connection Number'.
    APPEND gs_fieldcat TO gt_fieldcat.

    CLEAR : gs_fieldcat.
    gs_fieldcat-col_pos = 4.
    gs_fieldcat-fieldname = 'FLDATE'.
    gs_fieldcat-seltext_m = '운항일'.
    APPEND gs_fieldcat TO gt_fieldcat.

    gs_glay-edt_cll_cb = 'X'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
            i_callback_program = sy-cprog
            i_grid_settings = gs_glay
            it_fieldcat = gt_fieldcat
            it_events = gt_events
            is_layout = gs_layout
            i_callback_user_command = 'ALV_USER_COMMAND'
            TABLES
            t_outtab = gt_itab.
        FORM alv_user_command USING p_ucomm LIKE sy-ucomm p_selfield TYPE slis_selfield.

            CASE p_ucomm.
                WHEN '&IC1'.
                    READ TABLE gt_itab INDEX p_selfield-tabindex.
                    gt_itab-checkbox = 'X'.
                    MODIFY gt_itab INDEX p_selfield-tabindex.

                WHEN 'SAVE'.
                    MODIFY sflight FROM TABLE gt_itab.
                    IF sy-subrc EQ 0.
                        COMMIT WORK.
                    ELSE.
                        ROLLBACK WORK.
                    ENDIF.
            ENDCASE.
        ENDFORM.

        FORM alv_status_set USING pt_extab TYPE slis_t_extab.

            CLEAR : pt_extabl[].
            SET PF-STATUS 'STANDARD_FULLSCREEN'.
        ENDFORM.

        FORM alv_data_changed USING pcl_data TYPE REF TO
                                cl_alv_changed_data_protocol.

            DATA : l_name(20),
                   ls_cells TYPE lvc_s_modi.
            FIELD-SYMBOLS <fs_value>                                                   .

            LOOP AT pcl_data->mt_mod_cells INTO ls_cells.

                CLEAR gt_itab.
                READ TABLE gt_itab INDEX ls_cells-row_id.

                CONCATENATE 'GT_ITAB' ls_cells-fieldname INTO l_name.
                ASSIGN (l_name) TO <fs_value>.
                <fs_value> ls_cells-value.
                MODIFY gt_itab INDEX ls_cells-row_id.
            ENDLOOP.
        ENDFORM.