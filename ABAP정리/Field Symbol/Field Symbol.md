# Field Symbol 기초

Field Symbol은 메모리에 선언 될 변수, 구초제, 인터널 테이블의 공간을 참조하는 동적 변수이다.<br>
ABAP Program이 실행되는 시점에 Data Type과 구조가 결정되는 C Pointer와 유사한 개념이다.<br>

Field Symbol은 두가지 선언 방법이 있다. <br>
Field Symbol은 동적으로 ABAP Program이 실행중에 데이터 공간이 결정되기 때문에 abap 로직에따라 동적 구성이 가능하다

## Field Symbol Typing Addtion - generic_type
TYPE ANY, TYPE ANY TABLE로 선언된 아래 두가지 유형은 아래와 같이 차이점을 가지고 있다
```ABAP
FIELD-SYMBOLS : <FS_VALUE1> TYPE ANY,       "변수 , 구조체
                <FS_VALUE2> TYPE ANY TABLE. " 인터널 테이블
```

generic type의 데이터 유형은 ABAP Structure나 ABAP Internal Table을 ASSIGN 해야한다 <BR>
아래와 같이 ASSIGN 구문을 사용해서, Field Symbol과 String에 문자로 입력된 구조체 이름을 연결 가능하다.
```ABAP
IF r1 EQ abap_true
    lv_string = 'gs_scarr'.
ELSEIF r2 EQ abap_true.    
    lv_string = 'gs_spfli'.
ELSE.
    lv_string = 'gs_sflight'.
ENDIF.    

*Assign - 할당(연결작업)
ASSIGN (lv_STRING) TO <fs_value1>.

* 값할당 - String 방식
<fs_value1> = '100 AA Airline Code'.

WRITE : <fs_value1>.
```

<fs_value1>는 예를들어, GS_SCARR와 같은 필드를 구성하지만, 우리가 <br>일반적으로 사용하는 = 방식으로는 원하는 필드에 값을 할당 할 수 없다.

실제로, FS_VALUE1은 GS_SCARR와 동일한 필드로 구성되지만, 값을 할당 할 때는 String 방식으로 저장 된다. "100 AA Airline Code"처럼 String으로 구성했다.

UNSSIGN 구문을 사용하면, 필드심볼 변수 <fs_value1>을 재사용 할 수 있다.

```ABAP
*할당해제 - 재사용
UNASSIGN <fs_value1>.

*할당할 스트럭쳐변수를 변경.
lv_string = 'gg_sflight'
ASSGIN (lv_string) TO <fs_value1>.

lv_string = 'gt_sflight[]'.
ASSIGN lv_string TO <fs_value2>.
```

String 방식으로 선언되어, 원하는 필드에 값을 할당하기 어렵지만, 아래 구문을 사용하면 손쉽게 원하는 필드에 값을 할당 할 수 있다.

구조체에는 할당 할 필드가 존재해야 한다.

***ASSIGN COMPONENT "필드명" OF STRUCTURE "구조체" TO <필드심볼 변수>. <BR>***
***CHECK SY-SUBRC EQ 0. <필드심볼 변수> = "할당하고 싶은 값" <BR>***
***UNASSIGN <필드심볼 변수>.***

Field Symbol Typing Addtion - Complete_type

Field Symbol을 선언 할 때, Data Type을 Complete하게 지정 한다. <br>
이렇게 선언 할 경우, 위 Generic type과 달리, "="를 사용해서 필드에 값을 쉽게 할당 할 수 있다.

```ABAP
*Field Symbol
FIELD-SYMBOLS : <fs_structure> TYPE scarr,
                <FT_ITAB>      TYPE ty_scarr.

*값 발췌
SELECT SINGLE * FROM scarr
    INTO @DATA(lv_scarr).

*참조
ASSIGN gs_scarr TO <fs_structure>.

*값할당
<fs_structure>-mandt    =   lv_scarr-mandt.
<fs_structure>-carrid   =   lv_scarr-carrid.
<fs_structure>-carrname =   lv_scarr-carrname.

WRITE :/ <fs_structure>-mandt    COLOR 3 ON,
         <fs_structure>-carrid    COLOR 3 ON,
         <fs_structure>-carrname   COLOR 3 ON.    
```

LOOP ASSIGNING FIELD SYMBOL 구문 <br> - 위 구문을 사용하면, 인터널 테이블 필드와 동일한 구조체를 내부적으로 ASSIGN하여 필드심볼을 Complete Type으로 선언 한다. <br> - 문법은 아래와 같이 구성된다.

Syntax <br>
LOOP "인터널 테이블" ASSIGNING FIELD-SYMBOL (<필드심볼>) <BR>
~ <BR>
ENDLOOP.

```ABAP
*인터널 테이블 가공
SELECT * FROM scarr
INTO TABLE @DATA (lt_scarr) UP TO 1 ROWS.

*인터널 테이블과 Field Symbol 참조
ASSIGN gt_scarr TO <ft_itab>.

*인터널 테이블 값 할당
MOVE-CORRESPONDING lt_scarr TO <ft_itab>.

*LOOP선언시, Fieldsymbol 변수선언, Assign 수행,
*다음행 수행 전 변경사항이 있으면, Update
LOOP AT <ft_itab> ASSIGNING FIELD-SYMBOL(<fs_scarr>).
    <fs_scarr>-mandt = <fs_structure>-mandt.
    <fs_scarr>-carrid = 'zz'.
    <fs_scarr>-carrname = <fs_structure>-carrname.
    <fs_scarr>-currcode = <fs_structure>-currcode.
    <fs_scarr>-URL = <fs_structure>-URL
ENDLOOP.

```

## 필드 심볼 할당
필드 심볼을 선언하여 프로그램 내에서 사용하려면 반드시 ASSIGN 구문을 이용해서 오브젝트를 할당하여야 한다.

```ABAP
TYPES : BEGIN OF T_LINE,
            COL1 TYPE C,
            COL2 TYPE C,
        END OF T_LINE.

DATA: GS_WA TYPE T_LINE,
      GT_ITAB TYPE HASHED TABLE OF LINE WITH UNIQUE KEY COL1, KEY(4) TYPE C VALUE 'COL1'.

FIELD-SYMBOS <FS> TYPE ANY TABLE.
ASSIGN GT_ITAB TO <FS>.
```

필드 심볼에 오브젝트를 할당하려면 ASSIGN 구문을 활용한다.
ASSIGN 구문은 크게 다음 3가지 기능으로 분류된다.
- Assgin 구문의 기본 구조
- 구조체 필드를 필드 심볼에 Assign
- 필드 심볼과 Casting

## Assgin 구문의 기본 구조
Static Assign <br>
필드명을 이미 아는 경우라면 다음 예문 이용

```abap
ASSIGN DOBJ TO <FS>.

" ASSIGN이 성공하면 SY-SUBRC = 0 실패하면 SY-SUBRC = 4 를 리턴한다.
```

## Offset을 이용한 Static Assign
필드 일부분만을 필드 심볼에 Assign을 할 경우가 있다.

```ABAP
ASSIGN DOBJ [+OFF] [(LEN)] TO <FS>.
```

ABAP 프로그램에서 위 예문의 off를 Offset이라고 하고, Len을 Length라고 부른다. <br>
Len을 명시적으로 선언하지 않으면 ABAP은 데이터 오브젝트(dobj)의 길이와 동일하게 간주한다.<br>

```abap
DATA : STRING1(10) VALUE '0123456789'
STRING1+5.
```

위 구문은 실제 string1+5(10)와 동일한 의미로 string1이 할당된 메모리 영역을 벗어나게 된다.<br>
이렇게 사용해도 문제는 없지만, 필드 심볼은 Data Area를 넘어가면 에러가 발생한다.

```ABAP
WRITE / LINE-STRING1+5.
ASSIGN LINE-STRING1+5 TO <FS>.
```
첫 번째 구문은 수행되나, 두 번째 구문의 필드 심볼에서는 에러가 발생하여 컴파일되지 않는다.

## Assign 구문의 동적인 사용
필드 심볼에 할당하는 필드명을 알 수 없을 경우(프로그램 내에서 동적으로 할당되는 경우)에는 동적 ASSIGN 구문을 이용한다.

```abap
ASSIGN (dobj) TO <fs>.
```

동적인 ASSIGN 구문은 아래 코드의 GV_1, GV_2, GV_3처럼 같은 패턴으로 이루어진 변수들을 한 번에 출력할 때 유용하게 사용할 수 있다. <br>
아래 예제 코드에서는 5개의 변수를 필드 심볼에 동적으로 ASSIGN 하지만, 실무에서는 이보다 훨씬 많은 변수를 동적으로 구성하는 경우를 만날 수 있다. <br>
그리고 뒤에서 학습하게 되는 구조체를 동적으로 출력 할 때도 자주 활용된다.

```abap
DATA : GV_1 TYPE C VALUE 'A',
       GV_2 TYPE C VALUE 'B',
       GV_3 TYPE C VALUE 'C',
       GV_4 TYPE C VALUE 'D',
       GV_5 TYPE C VALUE 'E'.

DATA : GV_FNAME TYPE C LENGTH 10.
DATA : GV_IDX TYPE N.

DO 5 TIMES.
    CLEAR : GV_FNAME.
    GV_FNAME = 'GV_'.
    GV_IDX = SY-INDEX.
    CONCATENATE GV_FNAME GV_IDX INTO GV_FNAME.

    ASSIGN (GV_FNAME) TO <FS>.

    WRITE :/ GV_FNAME, ' : ' , <FS>.

ENDDO.    
```

## 구조체의 필드를 필드 심볼에 Assign
구조체의 개별 필드를 필드 심볼에 ASSIGN 할 수 있다. 다음 구문은 구조체 STRUC의 COMP(필드)를 <br>
필드 심볼 <'FS'>에 할당하는 것을 보여준다.

```ABAP
ASSIGN COMPONENT comp OF STRUCTURE struc TO <fs>.
```

필드 시볼 타입을 구조체르 선언한 경우나 TYPE ANY로 선언한 경우에는 필드 심볼을 Structure 구조로 할당할 수 있다. <br>
comp 항목에 올 수 있는 것은 line의 순번이나 컬럼명이다.

## 필드 심볼과 Casting
데이터 오브젝트를 필드 심볼에 ASSIGN 할 경우에, CAST를 이용해서 모든 데이터 타입을 필드 심볼에 Assign 할 수 있다.

프로그램 용어로 CAST는 암묵적 형 변환과 명시적 형 변환 2가지로 분류되어 사용된다. <br>
필드 심볼에서 Casting이 어떠한 역할을 하게 되는지 살펴보자.

## 암묵적 형 변환(Implicit Casting)
필드 심볼의 데이터 타입이 Fully Type으로 선언되어 있거나 기본 데이터 타입 -c, n, p, x-을 사용한 경우에 암묵적 형 변환을 사용한다. <br>
즉, 타입이 정해진 필드 심볼과 데이터 오브젝트 타입이 다른 경우에는 CASTING 구문을 이용해서 ASSIGN 해야 한다.

```ABAP
ASSIGN <VAR> TO <FS> CASTING.
```

## 필드 심볼과 인터널 테이블
변수와 같이 인터널 테이블도 같은 과정으로 필드 심볼에 할당하여 사용할 수 있다. <br>
***필드 심볼을 이용하여 인터널 테이블을 변경하게 되면 Work Area로 복사하는 과정이 생략되기 때문에 성능 향상에 도움이 된다. <br>***

필드 심볼을 인터널 테이블에 할당하여 사용하려면 다음 구문과 같이 사용한다.
```ABAP
TYPES : BEGIN OF T_LINE,
    COL1 TYPE C,
    COL2 TYPE C,
    END OF T_LINE.

DATA : GS_WA TYPE T_LINE,
       GT_ITAB TYPE HASHED TABLE OF T_LINE WITH UNIQUE KEY COL1,
       GV_KEY(4) TYPE C VALUE 'COL1'.

FIELD-SYMBOLS <FS> TYPE ANY TABLE.
ASSIGN GT_ITAB TO <FS>.
READ TABLE <FS> WITH TABLE KEY (GV_KEY) = 'X' INTO WA.
```

'필드 심볼과 인터널 테이블'이지만 실제 정의하고자 하는 것은 필드 심볼의 동적 타입 선언과 Generic Type 필드 심볼이다. <br>
이것은 일반적인 타입의 필드 심볼 (Generic Type Specification)로 정의되며, 프로그램 실행 시점에 필드 심볼의 타입을 동적으로 할당하는 기술을 의미한다.<br>
위 코드에서 필드 심볼 &lt;fs&gt;은 타입이 정해지지 않은 인터널 테이블로 선언되었다. <br>
그리고 ASSIGN 구문을 통해 인터널 테이블 itab이 필드 심볼에 할당된다. <br>
이후 필드 심볼 &lt;fs&gt;는 col1을 키 필드로 하는 인터널 테이블의 메모리 주소(address)에 동적으로 연결되게 된다.

```abap
REPORT Z10_09.

TYPES : BEGIN OF T_LINE,
        COL1 TYPE C,
        COL2 TYPE C,
        END OF T_LINE.

DATA : GS_STR TYPE T_LINE.

DATA : GV_FNAME(4) TYPE C VALUE 'COL1'.

DATA : GT_ITAB1 TYPE SORTED TABLE OF T_LINE WITH UNIQUE KEY CO1.

DATA : GT_ITAB2 TYPE HASHED TABLE OF T_LINE WITH UNIQUE KEY CO1.

DATA : GT_ITAB3 TYPE STANDARD TABLE OF T_LINE.

DATA : GT_ITAB4 TYPE T_LINE OCCURS 0 WITH HEADER LINE.

FIELD-SYMBOS <FS> TYPE ANY TABLE.

ASSIGN GT_ITAB1 TO <FS>.

READ TABLE <FS> WITH TABLE KEY (GV_FNAME) = 'X' INTO GS_STR.
```