# ALV GRID 요소

ALV GRID 요소(Element)에 대해서 알아보자. <br>

• Output of Exception : Grid를 신호등 표시로 보여준다. <br>
• Coloring Row : Grid의 라인 색상을 지정한다. <br>
• Coloring Cell : Grid의 셀 색상을 지정한다. <br>
• Displaying Cell as Pushbutton : 셀을 Pushbutton으로 보이게 한다. <br>

## 신호등(Exceptions) 처리
Exceptions는 경계값을 가지는 필드를 구간에 따라서 그래픽을 이용해서 데이터를 조회하게 한다. <br>
ALV 필드가 신호등 아이콘으로 조회되며 특정 필드의 값에 따라 색상이 변경된다. <br>
이것은 최종 사용자에게 데이터의 긴급함, 중요함에 대해서 쉽게 인식하게 해준다.<br>
예를 들어서 재고 관리에서 안전 재고의 수준은 녹색,안전 재고의 위험수준은 노란색<br>
안전 재고를 초과하게 되면 빨간색 신호 등으로 설정할 수 있다.

신호등 필드를 추가하기 위해서는 인터널 테이블에 아래와 같이 light 필드를 추가한다.
```ABAP
DATA: BEGIN OF GT_OUTTAB OCCURS 0.
      INCLUDE STRUCTURE <DDIC-Struktur>.
DATA: light TYPE C.   "신호등 표시로 보이기 위한 필드
DATA: END OF GT_OUTTAB. 
```

***예제코드 Z15_20.abap 참고***<br>
① Exceptions 필드 추가 <br>
인터널 테이블(OUTPUT)에 신호등을 표시할 필드를 TYPE C로 선언해서 추가한다. <br>
② ALV 레이아웃 설정에서 excp_fname 속성을 이용해서 신호등 필드를 설정한다.<br>
③ 예약석에 따라 신호등 색의 변화<br>
0석보다 작으면 빨간색, 50석보다 작으면 노란색, 그 외에는 녹색으로 보이도록 인터널 테이블 <br> 데이터를 변경한다.

## Coloring Rows
ALV GRID에서 강조하고 싶은 라인의 색상을 변경할 수 있다. 먼저, 인터널 테이블에 linecolor 필드를 추가하자.

```ABAP
DATA: BEGIN OF GT_OUTTAB OCCURS 0.
    INCLUDE STRUCTURE <DDIC-Struktur>.
DATA: linecolor(4) TYPE c.
DATA: END OF GT_OUTTAB.    
```

① LINE COLOR 필드 추가<br>
인터널 테이블(OUTPUT)에 line color를 표시할 필드를 TYPE C로 선언해서 추가한다. <br>
② INFO_FNAME 필드 설정<br>
ALV 레이아웃 설정에서 컬러 지정 필드를 설정한다. <br>
③ Carrid ID에 따라 색깔 변경<br>
Carrid ID가 'AA'이면 Blue, 'AZ'이면 Yellow, 'DL'이면 Green 색상을 보여주도록 설정한다.

**GT_SFLIGHT-linecolor = 'C100'.** 구문에서 C100의 세부적인 표현법은 아래 그림에서 설명한다.
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/Cxyz%20%EC%83%89%EC%83%81%20%EA%B5%AC%EC%A1%B0.png)

Cxyz에서 색상을 표현하는 x에 설정할 수 있는 값은 아래 표와 같음.
|x|색상|사용 목적|
|------|---|---|
|1|gray-blue|헤더|
|2|light gray|리스트|
|3|yellow|Total|
|4|blue-green|Key 칼럼|
|5|green|양호한 값을 표현하는 목적|
|6|red|부정적인 값을 표현하는 목적|
|7|orange|Control level|

## Coloring Cells
ALV GRID에서 강조하고 싶은 셀의 색상을 변경할 수 있다. <br>
그러나 앞에서 살벼폰 라인 단위의 색상 강조보다 시스템 리소스를 많이 사용한다. <br>
인터널 테이블에 LVC_T_SCOL 타입의 컬러 테이블을 추가해보자.

```ABAP
DATA : BEGIN OF GT_OUTTAB OCCURS 0.
    INCLUDE STRUCTURE <DDIC-Struktur>.
DATA : cellcolor TYPE LVC_T_SCOL. "CELL 색상 지정을 위한 필드 추가
DATA : END OF GT_OUTTAB.    
```

① CELL COLOR 필드 추가<br>
인터널 테이블에 line color를 표시할 필드를 TYPE LVC_T_SCOL로 선언해서 추가한다. <br>
② CTAB_FNAME 필드 설정<br>
ALV 레이아웃 설정에서 셀에 색상을 지정하기 위한 필드를 설정한다. <br>
CELLCOLOR는 색상이 변경되는 필드가 아니라, 아웃풋 테이블에서 색상이 변경될 셀 정보를 담는 인터널 테이블이다.<br>
③ CELL 색상 지정<br>
PLANE TYPE에 따라서 색상을 지정할 수 있는 스크립트를 추가한다.<BR>
1. 필드가 PLANETYPE일 경우만 색상을 변경. 만약 IF 구문을 주석 처리하게 되면, 라인전체가 색상이 변경되어서 Coloring Rows와 같은 효과가 있다.
2. lt_color 인터널 테이블에 필드명과 색상 정보를 추가한다.
3. 아웃풋 테이블의 CELLCOLOR 필드에 셀 정보와 색상 정보를 추가한다.

## 셀을 Pushbutton으로 보이기
ALV GRID 셀을 Pushbutton으로 나타내서 사용자가 해당 셀을클릭하면 다른 트랜잭션 화면으로 이동하거나 <br> 더 많은 정보를 조회할 수 있도록 한다. Pushbutton을 클릭하게 되면, ALV GRID는 button_click 이벤트를 호출하게 된다.
```ABAP
DATA : BEGIN OF GT_OUTTAB OCCURS 0.
    INCLUDE STRUCTURE <DDIC-Struktur>.
DATA : cellbtn TYPE LVC_T_STYL.
DATA : END OF GT_OUTTAB.    
```
① Pushbutton 필드와 CELL 스타일 필드 추가<br>
CHK 필드는 Pushbutton으로 보이게 될 필드이며, CELLBTN은 Pushbutton과 같은 스타일 정보를 저장하게 되는 칼럼이다. <br>
② STYLEFNAME 필드 설정<br>
ALV 레이아웃 설정에서 STYLEFNAME을 설정 필드를 지정한다. <br>
③ Pushbutton 처리<br>
CHK 필드를 Pushbutton으로 조회할 수 있도록 설정한다. Coloring Cell 로직과 유사하다.<br>
④ 버튼 클릭의 이벤트 등록<br>
Pushbutton을 클릭하게 되면 반응하는 이벤트 핸들러 메서드를 등록한다. <br>
⑤ 이벤트 메서드 정의<br> 이벤트 메서드를 정의한다. <br>
⑥ 이벤트 메서드 구현<br>
버튼을 클릭하게 되면 해당 라인의 carrid 칼럼 값을 읽어 정보 메시지 창을 실행하는 스크립트를 추가한다.