DATA : lv_menid TYPE zhre_medid.

CASE lv_menid.
    WHEN lv_menid = '8470'.
    CLEAR lv_authorized.
    CALL FUNCTION 'ZHR_CHECK_AUTORITY_PERNR'
        EXPORTING 
            i_pernr = ls_data-pernr
            i_datum = lv_actda
            i_standardlogic = ''
        IMPORTING
            e_authorized = lv_authorized.
    IF lv_authorized <> 'X'.
        CLEAR lv_authorized.
        CALL FUNCTION 'ZHR_CHECK_AUTORITY_PERNR'
            EXPORTING
                i_pernr = ls_data-pernr
                i_datum = lv_actda
                i_standardlogic = 'X'
                i_infty = '2001'
            IMPORTING
                e_authorized = lv_authorized.
    IF lv_authorized <> 'X'.
        SELECT SINGLE mapernr
            FROM zhrt6210
        WHERE pernr = @ls_data-pernr
        AND begda <= @lv_actda
        AND endda >= @lv_actda
        INTO @DATA(lv_mapernr).
    
    IF sy-subrc = 0 AND lv_pernr =lv_mapernr.
    ELSE.
        CONTINUE.
    ENDIF.
ENDIF.
ENDIF.