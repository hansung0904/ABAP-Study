*->> Data 처리
SORT lt_data BY ename.
LOOP AT lt_data INTO ls_data.

*->> 퇴직 여부 확인
CLEAR lv_retda.
IF ls_data-stat2 = '0'.
    lv_data = ls_data-begda_0 -1.
ENDIF.

CASE lv_accty.
    WHEN 'Z' OR 'M'. " 권한체크 제외

    WHEN OTHERS.
        CASE lv_menid.
            WHEN '2130' OR '2140'.

*->> 담당자가 해당 인원 검색시 권한체크 하지 않도록 수정.
    WHEN '8470'.
        CLEAR lv_authorized.
        CALL FUNCTION 'ZHR_CHECK_AUTHORITY_PERNR'
            EXPORTING
                i_pernr = ls_data-pernr
                i_datum = lv_actda
                i_standardlogic = ''
            IMPORTING
                e_authorized = lv_authorized.
        IF lv_authorized <> 'X'.
            CLEAR lv_authorized
            CALL FUNCTION 'ZHR_CHECK_AUTHORITY_PERNR'
                EXPORTING
                    i_pernr = ls_data-pernr
                    i_datum = lv_actda
                    i_standardlogic = 'X'
                    i_infty = '2001'
                IMPORTING
                    e_authorized = lv_authorized.
            IF lv_authorized <> 'X'.
                CONTINUE.
                ENDIF.
                ENDIF.
            ENDCASE.
            ENDCASE.                    
ENDLOOP