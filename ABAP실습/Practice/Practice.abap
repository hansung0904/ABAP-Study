DATA : lv_menid TYPE zhre_medid. "Data 선언 lv_menid 타입을 zhre_meid로 하겠다.

CASE lv_menid. " lv_menid 가
    WHEN lv_menid = '8470'. " 8470 menuID로 요청할 때 (Web)에서
    CLEAR lv_authorized. "lv_authorized 비워주고
    CALL FUNCTION 'ZHR_CHECK_AUTHORITY_PERNR' "ZHR_CHECK_AUTORITY_PERNR 함수 호출
        EXPORTING " 함수에 전달되는 매개변수를 지정하는 섹션
            i_pernr = ls_data-pernr
            i_datum = lv_actda
            i_standardlogic = ''
        IMPORTING " 함수로부터 반환되는 값을 받을 매개변수를 지정하는 섹션 함수가 결과를 반환하는 매개변수를 지정할 때 사용
            e_authorized = lv_authorized.
    IF lv_authorized <> 'X'.
        CLEAR lv_authorized.
        CALL FUNCTION 'ZHR_CHECK_AUTHORITY_PERNR'
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
