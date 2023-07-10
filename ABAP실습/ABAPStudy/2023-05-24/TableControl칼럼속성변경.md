# Table Control 칼럼 속성 변경

테이블 컨트롤의 칼럼 속성을 변경하는 방법은 CELL, COLUMN 레벨로 크게 두 분류가 존재한다. <br>
CELL 레벨에서 필드의 속성을 변경하려면 LOOP AT 구문을 사용해서 병렬 처리를 수행하고 CELL을 변경해야한다.<br>
그리고 COLUMN 단위의 속성을 변경하려면 CXTAB_CONTROL 구조체의 속성을 이용해야한다.<br>
SAP 메뉴얼에서 두 가지 분류로 나뉘는 것이 아니라, 업무를 통한 노하우에 의한 <br>
구분이므로 착오가 없어야 한다.

CXTAB_CONTROL 속성

| 항목            | 타입           | 내역                                                                                                  |
|---------------|--------------|-----------------------------------------------------------------------------------------------------|
| FIXED_COLS    | I            | 고정 칼럼 수                                                                                             |
| LINES         | I            | 테이블 컨트롤의 라인 수, 수직 스크롤 설정을 위한 목적으로 사용                                                                |
| TOP_LINE      | I            | 스크롤을 선택해서 PAI를 호출하면 NEXT POB에서 TOP에 조회되는 라인 번호<br> ABAP 프로그램에서 변경가능.                                |
| CURRENT_LINE  | I            | LOOP ...ENDLOOP 구문 내의 현재 라인 번호 <br> SY-STEP+(TOP_LINE-1)값으로 시스템에서 자동 세팅, <br> ABAP 프로그램에서 변경할 수 없다. |
| LEFT_COL      | I            | 사용자가 수평 스크롤을 선택할 때 왼쪽의 고정 칼럼 수를 설정한다.                                                               |
| LINE_SEL_MODE | I            | 라인 선택 모드를 설정한다. <br> 0: 라인을 선택할 수 없음 <br> 1: Single 라인 선택 가능 <br> 2: Multiple 라인 선택 가능              |
| COL_SEL_MODE  | I            | 칼럼 선택 모드를 설정한다. <br> 0: 칼럼을 선택할 수 없음 <br> 1: Single 칼럼 선택 가능 <br> 2: Multiple 칼럼 선택 가능              |
| LINE_SELECTOR | C(1)         | 이 속성이 'X'로 설정되어야 라인 선택가능 <br> 즉, LINE_SEL_MODE가 효력이 생김. <br> ABAP 프로그램에서 변경 가능.                     |
| H_GRID        | C(1)         | 수평 구분자                                                                                              |
| V_GRID        | C(1)         | 수직 구분자                                                                                              |
| COLS          | CXTAB_COLUMN | 아래 표에서 설명                                                                                           |
| INVISIBLE     | C(1)         | 보이지 않게 설정                                                                                           |

CXTAB_COLUMN 속성

| 필드        | 타입         | 내역             |
|-----------|------------|----------------|
| SCREEN    | SCREEN     | 스크린 구조의 속성     |
| INDEX     | I          | 칼럼 위치(조회 순서)   |
| SELECTED  |            | 선택된 칼럼         |
| VISLENGTH | ICON-OLENG | 칼럼이 보이는 넓이     |
| INVISIBLE |        | 칼럼을 보일 것인지를 설정 |