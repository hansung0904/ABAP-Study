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
