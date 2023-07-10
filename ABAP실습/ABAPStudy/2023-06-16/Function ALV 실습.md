# Function ALV 실습

## Edit 모드와 변경된 데이터 저장하기
ALV 레이아웃을 변경 모드로 설정하고 사용자가 값을 변경하면 변경된 값을 읽어서 ABAP Dictionary 테이블의 값을 변경하는 프로그램을 작성해보자.

ALV에서 값을 변경하면 'DATA_CHANGED'라는 이벤트가 자동으로 실행된다.

① 먼저 인터널 테이블을 다음과 같이 변경 또는 정의한다. TYPES 구문을 정의하고 나서 인터널 테이블을 다음과 같이 변경 또는 정의한다. TYPES 구문을 정의하고 나서 인터널 테이블을 선언하는 것이 바람직하나 간략하게 정의해보면
```ABAP
REPORT Z16_10.

DATA : gt_itab TYPE TABLE of sflight WITH HEADER LINE.
```

② ALV 데이터가 변경되면 이벤트가 수행되도록, 이벤트 테이블에 추가한다.
```ABAP
MOVE    'DATA_CHANGED'      TO      gs_event-name.
MOVE    'ALV_DATA_CHANGED'  TO      gs_event-form.
APPEND  gs_event            TO      gt_events.
````

③ ① 단계에서 'DATA_CHANGED'라는 이벤트 이름은 유형 그룹에 slis_ev_data_changed라는 상수로 등록되어 있으므로 사용하도록 한다.

④ 이벤트가 실행되면 수행되는 FORM 구문을 작성한다. pcl_data->mt_mod_cells라는 인터널 테이블에 <br>
ALV에서 수정한 데이터 정보가 자동으로 저장되어 있다. <br>

MODIFY 구문에서 변경된 셀 정보를 인터널 테이블 gt_itab에 반영한다. <br>
디버깅도 걸어보도록 한다.
```ABAP
FORM alv_data_changed   USING   pcl_data    TYPE REF TO
                                            cl_alv_changed_data_protocol.

    DATA : l_name(20),
           ls_cells TYPE lvc_s_modi.

    FIELD-SYMBOLS <fs_value>.

    LOOP AT pcl_data->mt_mod_cells INTO ls_cells.
    
        CLEAR gt_itab.
        READ TABLE gt_itab INDEX ls_cells-row_id.

        CONCATENATE 'GT_ITAB-' ls_cells-fieldname INTO l_name.
        ASSIGN (l_name) TO <fs_value>.
        <fs_value> = ls_cells-value.

        MODIFY gt_itab  INDEX   ls_cells-row_id.

    ENDLOOP.
ENDFORM.
```

⑤ 프로그램을 실행하고 1번째 라인의 가격 값을 '100'으로 변경하고 엔터를 입력한다.<br>
ALV GRID에서 값을 변경하는 즉시 이벤트가 수행되는 방법은 뒤에서 알아본다.<br>

⑥ pcl_data->mt_mod_cells 인터널 테이블에 저장된 정보가 저장되는 것을 확인할 수 있다.<br>
• ROW_ID : ALV 인덱스 번호<br>
• FIELDNAME : ALV 필드 이름<br>
• VALUE : 변경된 값<br>

⑦ 저장 버튼을 클릭한 후에 변경된 값을 변경한다.<br>

⑧ 사용자가 저장 버튼을 클릭하면, 테이블에 저장하는 스크립트를 추가한다.
```ABAP
FORM alv_user_command   USING   p_ucomm LIKE sy-ucomm
                                p_selfield TYPE slis_selfield.
    CASE p_ucomm.
        WHEN 'SAVE'.
            MODIFY sflight FROM TABLE gt_itab.
            IF sy-subrc EQ 0.
                COMMIT WORK.
            ELSE.                                                
```