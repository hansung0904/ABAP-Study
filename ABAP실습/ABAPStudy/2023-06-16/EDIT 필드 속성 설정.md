# EDIT 필드 속성 설정
Connection Number 'CONNID' 필드를 편집 모드로 변경해보자

필드 카탈로그 속성 EDIT에 'X'값을 설정한다.
```ABAP
CLEAR : gs_fieldcat.
gs_fieldcat-col_pos = 2.
gs_fieldcat-edit = 'X'.
gs_fieldcat-fieldnmae = 'CONNID'.
gs_fieldcat_seltext_m = 'Connection Number'.
APPEND gs_fieldcat TO gt_fieldcat.
```