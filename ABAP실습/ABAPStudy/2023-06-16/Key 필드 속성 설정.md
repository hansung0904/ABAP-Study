# Key 필드 속성 설정

필드 카탈로그 속성 KEY를 'X'로 설정하고 프로그램을 실행한다.
```ABAP
CLEAR : gs_fieldcat, gt_fieldcat.
gs_fieldcat-col_pos = 1.
gs_fieldcat-key = 'X'.
gs_fieldcat-fieldname = 'CARRID'
gs_fieldcat-seltext_m = 'Airline Code'
APPEND gs_fieldcat TO gt_fieldcat.
```