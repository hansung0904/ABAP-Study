REPORT Z15_19.
-----> 중략 <-----
FORM setting_catalog.
    FIELD-SYMBOLS: <ls_fcat> TYPE lvc_s_fcat.

    LOOP AT gt_fieldcat ASSIGNING <ls_fcat>.

        IF <ls_fcat>-fieldname EQ 'FLDATE'
           <ls_fcat>-eidt_mask = '____/__/__'
        ENDIF.

        IF <ls_fcat>-fieldname EQ 'CURRENCY'
           <ls_fcat>-just = 'R'
        ENDIF.
    ENDLOOP.
ENDFORM.    
    