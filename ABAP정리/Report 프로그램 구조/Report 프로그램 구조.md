# SAP Report 프로그램 구조

## 1. 프로그램 구조 (선언)
1-1 DATA
```abap
DATA : GT_M0323 LIKE ZOJT01_T0323 OCCURS 0 WITH HEADER LINE.
```
1-2 SELECTION SCREEN
- 프로그램 조회 조건을 입력할 수 있는 SELECTION SCREEN을 생성

1&#46; PARAMETER
- 사용자 정의 INPUT 필드를 정의
- 1개의 값만 입력받을 수 있음(select-option과 같은 multiple 기능 x)
```abap
" 필수 선택 옵션 추가
PARAMETERS M_1 LIKE GT_M0324-ZGUBUN OBLIGATORY.
```
2&#46; SELECT-OPTIONS
- 사용자 정의 INPUT 필드를 정의
- 2개의 값 입력받을 수 있음
- SELECT-OPTIONS 쓸 때 참조할 TABLE-FIELD 선언해야한다. (PARAMETER는 선언 안해줘도 된다)
- SELECT OPTIONS에서 참조하는 테이블이 있다면 Top Include에서 **TABLES 명령을 통해 해당 테이블을 선언해주어야 에러가 발생하지 않는다.**
```ABAP
" 1. 기본 SELECT-OPTION
SELECT-OPTIONS S_DATE FOR GT_DATA-ZDATE.
```

![](img/../../img/1-1.png)
```abap
" 2. TO 가 사라짐
SELECT-OPTIONS S_DATE FOR GT_DATA-ZDATE NO INTERVALS.
```

![](img/../../img/1-2.png)

```ABAP
" 3. MULTIPLE이 사라짐
SELECT-OPTIONS S_DATE FOR GT_DATA-ZDATE NO-EXTENSION.
```
![](img/../../img/1-3.png)

3&#46; SELECT-SCREEN
- 시스템이 생성하는 화면을 사용자 입맛에 맞게 구서용소를 배치

1-3. CONSTATNS, RANGE, DEFINE

1&#46; CONSTANTS
- X라는 값이 디폴트, 반복적으로 같은 값 쓸 때 사용

```ABAP
GC_X TYPE C VALUE 'X'.
```

2&#46; RANGES
- 테이블의 필드를 참조해서 만듬
- 무조건 INTERNAL 테이블이 됨
- SIGN(I,E), OPTION(EQ = , BT <>, GT>), LOW, HIGH

```ABAP
GR_RANGE FOR MARA-MATNR.
```

3&#46; DEFINE
- 매크로 선언
```ABAP
DEFINE _CLEAR.
CLEAR: &1. &1[].
END-OF-DEFINITION.

= CLEAR: GT_DATA, GT_DATA[] 같은 의미
```

## 2. 프로그램 구조(이벤트)
프로그램을 실행하면 화면에 보이는 필드들을 초기화하고, 사용자가 입력한 값에 대한 결과를 반환하는 사용자 이벤트에 대해 기술

2-1&#46; INITIALIZATION
- 프로그램을 실행했을 대 가장 먼저 수행.
- 변수에 초깃값을 지정할 때 사용.

```ABAP
INITIALIZATION.
P_1 = 'AA'.
```

2-2&#46; AT SELECTION-SCREEN
- SELECTION-SCREEN에서 Input Field의 값이 변동되었을 때 실행되는 이벤트
- INITIALIZATION과 START-OF-SELECTION 사이에서 후애
- 사용자 액션에 대해 반응하고, 화면 필드를 조절

```ABAP
"AUTHORITY 체크 가능

AT SELECTION-SCREEN.
    AUTHORITY-CHECK OBJECT 'Z_TEST'
```

2-3&#46; START-OF-SELECTION
- 데이터베이스에서 원하는 데이터를 가져오는 실질적인 작업
- LDB -> GET 구문, 일반 프로그램 -> SQL 구문
```ABAP
" START-OF-SELECTION
" 아래 코드의 핵심은 실행버튼 눌렀을 때 밑에 PROGRESS BAR가 진행되는 것.

DATA : G_TOTAL TYPE I,
       G_CNT TYPE I,
       G_INDEX TYPE I.

DATA : GT_SFLIGHT TYPE TABLE OF SFLIGHT WITH HEADER LINE.

START-OF-SELECTION.
    SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT FROM SFLIGHT.

    DESCRIBE TABLE OF GT_SFLIGHT LINES G_TOTAL.

    LOOP AT GT_SFLIHGT.
        G_CNT = G_CNT + 1.
        PERFROM PROGRESS_INDICATOR USING G_CNT G_TOTAL ' PROCESSING... '.
    ENDLOOP.

    WRTIE 'SUCCESS'.
```

2-4&#46; END-OF-SELECTION
- 실행 환경에서 호출되는 마지막 이벤트
- SELECT 구문에서 모든 데이터를 읽은 후 화면에 WRITE 하기전에 수행
- 인터널 테이블에 저장된 데이터들을 변형하는 작업 가능

```ABAP
" END-OF-SELECTION
" START-OF-SELECTION에서 데이터를 읽어와 END-OF-SELECTION에서 데이터를 화면에 뿌려준다.

DATA : GS_STR TYPE SCARR,
       GT_ITAB TYPE TABLE OF SCARR.

START-OF-SELECTION.
    SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_ITABE FROM SCARR.

END-OF-SELECTION.
    LOOP AT GT_ITAB INTO GS_STR.
        WRITE :/ GS_STR-CARRID, GS_STR-CARRNAME.
    ENDLOOP.

FORM PROGRESS_INDICATOR USING VALUE(P_CUR) VALUE(P_TOTAL) VALUE(P_TEXT).
    DATA : LV_TEXT(50) TYPE C, LV_IDX(3) TYPE N.

    LV_IDX = ( P_CUR / P_TOTAL ) * 100.

    CONCATENATE LV_IDX ' % : ' P+TEXT INTO LV_TEXT.

    CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
            PERCENTAGE = LV_IDX
            TEXT = LV_TEXT
        EXCEPTIONS
            OTHERS = 0.
ENDFORM.
```

## 3. 프로그램 구조 (List Process 이벤트)
조회 화면에서 조회 조건 입력 값을 입력한 후에 사용자가 실행하면 데이터를 화면에 뿌려줌.

3-1&#46; TOP-OF-PAGE
- 새로운 페이지에 첫 번째 데이터가 출력되기 전에 수행
- 페이지의 Header
- NO STANDARD PAGE HEADING 옵션으로 생성된 프로그램에서 직접 HEADER를 입력할 때 사용
- 추가 옵션이 없을 경우 기초적인 LIST 생성시에만 사용

```ABAP
" TOP-OF-PAGE
" 글머리 작성하기
TOP-OF-RANGE.
    WRITE : SY-TITLE, 60 'PAGE NO: ' , SY-PAGNO.
    ULINE.
    WRITE : / 'ENJOY ABAP', SY-DATUM.
    ULINE.

START-OF-SELECTION.
    DO 4 TIMES.
    WRITE / SY-INDEX.
    ENDDO.        
```

3-2&#46; END-OF-PAGE
- 현재 페이지의 남은 공간이 부족할 때 수행
- 페이지의 Footer

```abap
"END-OF-PAGE
" 명시된 line-count, line-size를 넘어가면 수행

TOP-OF-RAGNE.
    WRITE : 'Top of page'.
    ULINE.

END-OF-PAGE.
    ULINE.
    WRTIE :/30 'Page NO: ' , SY-PAGNO.

START-OF-SELECTION.
    DO 20 TIMES.
        WRITE / SY-INDEX.
    ENDDO.        
```

3-3&#46; AT LINE-SELECTION

- report의 특정 line을 더블클릭하거나 f2키를 눌렀을 때 발생

```abap
START-OF-SELECTION.
    WRTIE ' FIRST LIST '.

    FORMAT HOTSPOT ON COLOR 7.
    WRTIE :/ 'CLICK THIS LINE'.
    FORMAT HOTSPOT OFF COLOR OFF.

AT LINE-SELECTION.
    WRITE: 'SECONDARY LIST'.
    WRITE :/ 'SY-UCOMM = ' , SY-UCOMM.    
```

3-4&#46; AT PF<'NN'>
- 키보드 F키
- Function Key nn을 눌렀을 때 발생(nn은 1~24번까지의 숫자)

```abap
" AT PF<NN>
" 키보드 f키 눌렀을 때 실행

START-OF-SELECTION.
    WRTIE 'Function Key Test PF5, PF6, PF7'.

AT PF5.
    PERFORM WLIST.

AT PF6.
    PERFORM WLIST.

AT PF7.
    PERFORM WLIST.

FROM WLIST.
    WRITE:
    /   'YOU SELECTED BELOW FUNCTION KEY',
    /   'SY-SCOMM = ' , SY-UCOMM.
ENDFORM.        
```

3-5&#46; AT USER-COMMAND
- 프로그램에서 Function으로 선언된 기능을 수행
- **GUI SATUS 생성 (SET-PF-STATUS)**
  - 표준 리포트 프로그램에서 제공하는 메뉴를 삭제하거나 기능을 추가
  - ABAP프로그램 영역과 독립적으로 존재
  - T-CODE : SE41에서 생성해서 화면에 동적으로 추가
  - EXCLUDING옵션을 사용해서 메뉴 중 일부 비활성화 기능

3-6&#46; TOP-OF-PAGE DURING LINE-SELECTION
- Secondary List의 header를 Control 할 때 사용

```abap
" TOP-OF-PAGE DURING LINE-SELECTION
" 하위 페이지 HEADING 설정
TOP-OF-PAGE.
    WRITE 'First List TOP-OF-PAGE'.
    ULINE.

TOP-OF-PAGE DURING LINE-SELECTION.
    WRITE 'SECONDARY LIST TOP-OF-PAGE.
    ULINE.

AT LINE-SELECTION.
    PERFORM WRITE_LIST.

START-OF-SELECTION.
    WRITE : 'DOUBLE-CLICK THIS LINE'.

FORM WRITE_LIST.
    WRITE : 'SECONDARY LIST',
    / ' SY-PFKEY : ' , SY-PFKEY.
ENDFORM.                    
```

3-7&#46; WRITE 구문
- OUTPUT 리스트에 데이터를 쓰는 기능

1&#46; AT pl
- 필드의 위치와 길이를 지정.

```ABAP
DATA :GT_DATA TYPE TABLE OF SFLIGHT WITH HEADER LINE.

TOP-OF-PAGE.
    WRITE :/50 'REPORT FORMAT' CENTERED.
    WRITE :/48 '-------------' CENTERED.

SKIP.

START-OF-SELECTION.
    " 1번째 네모 블럭 위의 뚜껑과 양옆
    WRITE :/(51) SY-ULINE, 53(68) SY-ULINE,
           / SY-VLINE NO-GAP, 51 SY-VLINE NO-GAP, 53 SY-VLINE NO-GAP, 120 SY-VLINE NO-GAP.

    WRITE : 2(9) 'REPORT NO' NO-GAP CENTERED, SY-VLINE NO-GAP.
    WRITE : 12(9) '00001' NO-GAP CENTERED, SY-VLINE NO-GAP.

    WRITE : 54(11) 'REPORT DATE' NO-GAP CENTERED, SY-VLINE NO-GAP.
    WRITE : 66(10) SY-DATUM NO-GAP CENTERED, 120 SY-VLINE NO-GAP.
    WRITE :/(51) SY-ULINE, 53(68) SY-ULINE.
SKIP.
```

# 4. 프로그램 만드는 순서

1. **DATA 선언 - 변수 선언**
2. **조회조건 만들기**
3. **실제 데이터 가져오기 (DB) -> START-OF-SELECTION.**
4. **가져온 데이터를 가공하기**
5. **가공한 데이터를 화면에 뿌려주기 -> END-OF-SELECTION.**