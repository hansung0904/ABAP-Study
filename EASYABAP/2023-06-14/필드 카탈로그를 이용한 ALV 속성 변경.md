# 필드 카탈로그를 이용한 ALV 속성 변경
## 필드 속성 설정(KEY, FIX_COLUMN)
ALV GRID의 앞부분 4개 필드는 Key 속성으로 지정되어 있다. <br>
색상은 파란색으로 설정되며 하단의 Key 필드에 해당하는 스크롤 바는 고정되어 있다. <br>
여기서 PRICE 필드는 Key 속성으로 정의하고 CURRENCY 필드는 고정 칼럼으로 지정해보자.<br>

필드 카탈로그 속성을 변경하는 Subroutine 내의 LOOP AT GT_FIELDCAT INTO LS_FIELDCAT. 구문을 필드 심볼을 이용하는 방법으로 변경해보도록 한다.

```ABAP
REPORT Z15_18.
-----------------------> 중 략 <-----------------------
FORM setting_catalog.
    FIELD-SYMBOLS: <ls_fcat> TYPE lvc_s_fcat.

    LOOP AT gt_fieldcat ASSIGNING <ls_fcat>.

        IF <ls_fcat>-fieldname EQ 'PRICE'.
         <ls_fcat>-key = 'X'.
        ENDIF.

        IF<ls_fcat>-fieldname EQ 'CURRENCY'
         <ls_fcat>-fix-column = 'X'.
        ENDIF.
    ENDLOOP.

ENDFORM.        
```

PRICE 필드는 SFLIGHT 테이블의 Key 필드가 아니지만, <br>
필드 카탈로그 속성 변경으로 새로운 Key 필드로 추가되었고 CURRENCY 필드는 fix_column = 'X' 구문으로 <br> 스크롤 바가 고정되도록 설정되었다.

## 데이터 포맷 설정(JUST, EDIT_MASK속성)
이제 FLDATE(Flight Date)의 날짜를 '____/__ /__ /'포맷으로 변경하고 CURRENCY 필드는 왼쪽 정렬로 속성을 변경해보자.

JUST 속성은 데이터를 정렬하는 역할을 하게 되며 아래 표와 같은 값을 가질 수 있다.
|값|내역|
|------|---|
|"|데이터 타입의 기본 정렬|
|'L'|왼쪽 정렬|
|'C'|중앙 정렬|
|'R'|오른쪽 정렬|