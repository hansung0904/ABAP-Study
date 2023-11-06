# HR_ECM_GET_EE_MOLGA
## 국가그룹핑 구하는 함수.
```abap
 CALL FUNCTION 'HR_ECM_GET_EE_MOLGA'
          EXPORTING
            PERNR           = LS_DATA-PERNR
            MESSAGE_HANDLER = LCL_MSG_HAND
          IMPORTING
            MOLGA           = LS_DATA-MOLGA.
```