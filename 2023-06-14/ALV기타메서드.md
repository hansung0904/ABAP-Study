# ALV 기타 메서드
ALV에서 가장 중요한 역할을 하는 set_table_for_first_display 메서드의 기능과 파라미터에 대해서 살펴보았는데. <br>
이외 ALV에서 자주 사용되는 메서드들에 대해서 학습한다.

**1) get_current_cell**
get_current_cell 메서드는 ALV GRID 컨트롤에 커서가 놓인 위치의 값과 속성들을 반환한다.<br>
선택된 셀이 존재하지 않으면 라인의 Row 값은 0을 반환한다.<br>
ALV GRID 컨트롤은 두 개의 라인과 칼럼의 인덱스 번호를 반환하는데, 하나는 현재 선택된 셀의 라인과 칼럼이고<br>
다른 하나는 아웃풋 테이블(인터널 테이블) 라인과 칼럼의 인덱스이다.<br>

***이것은 필터링을 설정하거나 숨기기를 하였을 때 실제 화면에 보이는 값과 인터널 테이블의 순서가 다를 수 있기 때문이다.***

```ABAP
CALL METHOD <ref.var. to CL_GUI_ALV_GRID>->get_current_cell
    IMPORTING
        E_ROW          =   <var. of type I>
        E_VALUE        =   <var. of TYPE c>
        E_COL          =   <var. of TYPE I>
        ES_ROW_ID      =   <structrue of TYPE LVC_S_ROW>
        ES_COL_ID      =   <structure of tpye LVC_S_COL>
```

|파라미터|의미|
|------|---|
|E_ROW|ALV GRID 컨트롤의 현재 라인 인덱스|
|E_VALUE|ALV GRID 컨트롤의 현재 셀의 값|
|E_COL|ALV GRID 컨트롤의 현재 칼럼 이름|
|ES_ROW_ID|아웃풋 테이블의 현재 라인 타입과 인덱스에 대한 정보 구조|
|ES_COL_ID|아웃풋 테이블의 현재 칼럼과 필드명에 대한 정보 구조|