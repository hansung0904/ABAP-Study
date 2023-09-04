# ALV GRID 요소
ALV GRID 요소에 대해서 알아보자.
- Output of Exception
  - Grid를 신호등 표시로 보여준다.
- Coloring Row
  - Grid의 라인 색상을 지정한다.
- Coloring Cell
  - Grid의 셀 색상을 지정한다.
- Displaying Cell as Pushbutton
  -  셀을 Pushbutton으로 보이게 한다.

## 1 신호등(Exceptions) 처리
Exceptions는 경계값을 가지는 필드를 구간에 따라서 그래픽을 이용해서 데이터를 조회하게 한다. <br>
ALV 필드가 신호등 아이콘으로 조회되며 특정 필드의 값에 따라 색상이 변경된다. <br>
이것은 최종 사용자에게 데이터의 긴급함, 중요함에 대해서 쉽게 인식하게 해준다. <br>
예를 들어 재고 관리에서 안전 재고의 수준은 녹색, 안전 재고의 위험 수준은 노란색, 안전 재고를 초과하게 되면 빨간색 신호 등으로 설정할 수 있다.

```abap
REPORT CHS.

* 중략

DATA : BEGIN OF GT_SFLIGHT OCCURS 0.
    INCLUDE STRUCTURE SFLIGHT.

DATA : LIGHT TYPE C.
DATA : END OF GT_SFLIGHT. 

DATA : LIGHT TYPE C.
DATA : END OF GT_SFLIGHT.

* 중략

LOOP AT GT_SFLIGHT.
    IF GT_SFLIGHT-SEATSOCC <= 0.
        GT_SFLIGHT-LIGHT = '1'.
    ELSEIF GT_SFLIGHT-SEATSOCC <= 50.
        GT_SFLIGHT-LIGHT = '2'.
    ELSE.
        GT_SFLIGHT-LIGHT = '3'.
    ENDIF.

    MODIFY GT_SFLIGHT.

ENDLOOP.                            

* 중략

FORM SETTING_LAYOUT     CHANGING    P_LAYOUT TYPE LVC_S_LAYO.
    P_LAYOUT-EXCP_FNAME = 'LIGHT'.
ENDFORM.  
```

① Exceptions 필드 추가<BR>
인터널 테이블(OUTPUT)에 신호등을 표시할 필드를 TYPE C로 선언해서 추가한다. <BR>
② Exceptions 필드 설정<BR>
ALV 레이아웃 설정에서 excp_fname 속성을 이용해서 신호등 필드를 설정한다. <br>

③ 예약석에 따라 신호등 색의 변화 <br>
0석보다 작으면 빨간색, 50석보다 작으면 노란색, 그 외에는 녹색으로 보이도록 인터널 테이블 데이터를 변경한다.

## 2 Coloring Rows
ALV GRID에서 강조하고 싶은 라인의 색상을 변경할 수 있다. 먼저, 인터널 테이블에 linecolor 필드를 추가하자.
```abap
REPORT CHS.

* 중략

DATA : BEGIN OF GT_SFLIGHT OCCURS 0.
    INCLUDE STRUCTURE SFLIGHT.

DATA : LINECOLOR(4) TYPE C.
DATA : END OF GT_SFLIGHT.

    LOOP AT GT_SFLIGHT.
        CASE GT_SFLIGHT-CARRID.
            WHEN 'AA'.
                GT_SFLIGHT-LINECOLOR = 'C100'.
            WHEN 'AZ'.
                GT_SFLIGHT-LINECOLOR = 'C300'.
            WHEN 'DL'.
                GT_SFLIGHT-LINECOLOR = 'C500'.
        ENDCASE.

MODIFY GT_SFLIGHT.
ENDLOOP.
```

## 3 Coloring Cells
ALV GRID에서 강조하고 싶은 셀의 색상을 변경할 수 있다. 그러나 앞에서 살펴본 라인 단위의 색상 강조보다 시스템 리소스를 많이 사용한다. <BR>
인터널 테이블에 LVC_T_SCOL 타입의 컬러 테이블을 추가하자.
```ABAP
DATA : BEGIN OF GT_OUTTAB OCCURS 0.
    INCLUDE STRUCTURE <DDIC-STRUCTURE>.

DATA : cellcolor TYPE LVC_T_SCOL.

DATA : END OF GT_OUTTBA.
```

## 4 셀을 Pushbutton으로 보이기
ALV GRID 셀을 Pushbutton으로 나타내서 사용자가 해당 셀을 클릭하면 다른 트랜잭션 화면으로 이동하거나 더 많은 정보를 조회할 수 있도록 한다. <br>Pushbutton을 클릭하게 되면 ALV GRID는 button_click 이벤트를 호출하게 된다.
```abap
DATA : BEGIN OF GT_OUTTAB OCCURS 0.
    INCLUDE STRUCTURE <DDIC-STRUKTUR>. " 책에 이렇게 쓰여있었음 오타인지는 모름
```