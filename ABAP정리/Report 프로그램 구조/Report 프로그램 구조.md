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

![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/1-1.png?token=GHSAT0AAAAAACGLEIWJWPT2XNHXDJEIRF4WZHG3Q4A)
```abap
" 2. TO 가 사라짐
SELECT-OPTIONS S_DATE FOR GT_DATA-ZDATE NO INTERVALS.
```

![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/1-2.png?token=GHSAT0AAAAAACGLEIWIQSJAIKJVTZQRRHMMZHG3RGQ)

```ABAP
" 3. MULTIPLE이 사라짐
SELECT-OPTIONS S_DATE FOR GT_DATA-ZDATE NO-EXTENSION.
```
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/1-3.png?token=GHSAT0AAAAAACGLEIWIG3NKCCFUFS6OQ7DWZHG3RMQ)

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