# Range 변수
업면허 관리 개편 업무를 하다가 Range변수때문에 애를 먹은적이 있다. <br>
정리해보자.

Range 변수는 잘 알아두면 여러모로 편리한 구문이다.

보토 웹페이지나 프로그램의 입력화면으니 Edit box는 단일 입력을 받도록 되어 있다. <br>
여러 줄을 입력받거나 범위를 입력받으려면 화면을 수정 코딩하는 번거로움이 있는데 이것은 Internal Table 형식으로 극복한것이다.

TYPE-1 Report 프로그램의 SELECTION-SCREEN 구성시 사용하는 SELECT-OPTIONS 변수도 같은 형식을 취하고 있다.

## 1 선언
```ABAP
REPORT zhr_practice.

RANGES lr_matnr FOR mara-matnr.

DATA lr_matnr TYPE RANGE OF matnr.

DATA lr_matnr LIKE RANGE OF mara-matnr.

DATA : BEGIN OF lr_matnr OCCURS 0,
         sigin  TYPE ddsign,
         option TYPE ddoption,
         low    TYPE mara-matnr,
         hight  LIKE mara-matnr,
       END OF lr_matnr.
```
보통 RANGES 구문을 사용해서 선언하며 다른 방법으로도 선언이 가능하다.

## 2 구조
선언과 같이 RANGES 변수를 선언하면 변수는 자동적으로 4개의 필드를 가진 Internal Table이 된다. <br>
각 필드의 기능을 살펴보자. <br>
SIGN TYPE DDSING,
OPTION TYPE DDOPTION,
LOW TYPE dobj,
HIGH TYPE dobj.

### 2-1 값 필드 LOW , HIGH
조건값을 넣을 LOW, HIGH는 참조한 변수와 같은 유형으로 선언이 된다. 1과 같이 선언하면 MATNR과 같은 CHAR 18자리의 변수가 선언된다.

### 2-2 SIGN
저장한 값을 포함할지 제외할지 결정하는 지시자로 I(INCLUDE 포함), E(EXCLUDE 제외)의 값을 가질 수 있다. <br>
그 Domain 값을 보면 알 수 있다. (DOMAIN : DDSIGN -> Value Ranges)

### 2-3 OPTION
주어진 값에 대한 조건을 지정할 수 있다. 보다 크다, 같다 등의 연산자라 생각하면 된다. <br>
도메인의 값을 보면 가질 수 있는 값은 다음과 같다. <br>
(DOMAIN : DDOPTION -> EQ : 같음 , BT : between ... and ... , CP : 패턴포함, LE : 보다 작거나 같음, GE : 보다 크거나 같음 <br> NE : 같지 않음, NB : Not between ... and ... NP : 패턴포함 안됨, GT : 보다 큼, LT : 보다 작음.)