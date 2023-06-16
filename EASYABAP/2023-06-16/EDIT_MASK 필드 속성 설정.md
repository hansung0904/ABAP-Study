# EDIT_MASK 필드 속성 설정
Flight Date 필드 'FLDATE'를 추가하고 날짜 포맷을 변경해본다.

필드 카탈로그 속성 EDIT_MASK를 '/'기호로 표현되도록 설정한다.
```ABAP
CLEAR : gs_fieldcat.
gs_fieldcat-col_pos = 3.
gs_fieldcat-fieldname = 'FLDATE'.
gs_fieldcat-seltext_m = 'Flight Date'.
gs_fieldcat-EDIT_MASK = '____/ __/ __'.
APPEND gs_fieldcat TO gt_fieldcat.
```