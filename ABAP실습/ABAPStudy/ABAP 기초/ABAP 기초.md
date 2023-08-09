# Data
ABAP Program을 실행하면 PC에서 일어나는 일들 ( = F8을 클릭했을 때)

1. Data는 ABAP Program을 시랳ㅇ하면 소스코드에 작성해둔 룰대로 Memory라는 공간에 데이터를 잠시 적재.
2. 차례까 되면 ABAP Compiler에 의해서 CPU에 할당하여 ABAP 개발자가 작성한 로직에 따라 연산처리를 수행
3. 최종적으로 완료된 DATA를 출력형태에 맞게 조회 된다. (출력형태의 예 : ALV List)

Data를 다루는 첫번째 Data의 속성을 알아야하는데 ABAP에서 Data는 아래와 같은 자료형(Data Type)을 가진다. <br>
C, I, F, P, String, N을 통해, 인간이 인식할 수 있는 형태의 Data를 보관한다. <br>
SAP ABAP Programming에서도 OOP라는 객체지향의 Concept를 활용해서 Data를 관리한다.

## Data 유형별 사례
Data 변수라면 ? : 사용자 ID, 월급 같은정보를 담는 공간으로 사용가능.

Data 구조체라면 ? : 사용자정보로 사용이가능 ( 사용자 ID, 사용자 Password, 주소, 핸드폰번호, 우편번호 등)

Data 인터널 테이블이라면 ? : 사용자정보를 모두 담고 있는 데이터 공간(스터디원 정보.)

Data 공간 <br>
변수 : 1개의 필드 (하나의 공간) <br>
구조체 : 여러개의 필드의 집합 (하나의 구조체, 여러필드의 집합)
인터널 테이블 : 구조체의 필드구조로 N건의 Data를 담아두는 Local 테이블

동의어정리 <br>
구조체는 Structure = Work Area = Header Line <br>
인터널 테이블은 Internal Table = Body

어떤 데이터를 담을 것인가?

하나의 필드 (데이터를 담는 공간) <br>
숫자 (정수형, 실수형, 부동소수 등등) <br>
문자 (문자, 문자열, 숫자문자 등등)

ABAP Program에서 Data를 담는 공간을 선언하는 방법은 크게 3가지가 존재한다.

Data type의 첫번째 : Predefine Type
- Data의 가장 내부적인 Kernel 영역에 존재하는 자료형태

```ABAP
*1. 변수선언
DATA : GV_DATA TYPE I.
DATA : GV_CHAR TYPE C.

*2. 구조체선언
DATA : BEGIN OF GV_STR,
        A1 TYPE C,
        A2 TYPE I,
        A3 TYPE I,
       END OF GV_STR.

*3. 인터널 테이블 선언.
DATA : GV_ITAB TYPE TABLE OF C.        
```

Data type의 두번째 : Local Data Type <br>
ABAP Program상에서만 존재하는 Data Type을 새로 생성해서 Program내에서 사용하는 자료형

```ABAP
*1. 변수 선언
TYPES : TY_DATA TYPE I.

*2. 구조체 선언
TYPES : BEGIN OF TYS_DATA,
            A1 TYPE C,
            A2 TYPE I,
            A3 TYPE I,
        END OF TYS_DATA.

DATA : GV_DATA TYPE TY_DATA.

*3. 인터널 테이블 선언
DATA : GY_TDATA TYPE TABLE OF TYS_DATA.
DATA : GY_SDATA TYPE TABLE OF TY_DATA.
```

Data Type의 세번째 : ABAP Dictionary Data Type

```ABAP
* 1. 변수 선언
DATA : G_CARRID   TYPE SCARR-CARRID,
       G_CARRNAME TYPE SCARR-CARNAME.

* 2. 구조체 선언
DATA : BEING OF GS_WA,
        CARRID TYPE SCARR-CARRID,
        CARRNAME TYPE SCARR-CARRNAME,
        CURRCODE TYPE SCARR-CURRCODE,
       END OF GS_WA. 

* 3. 인터널 테이블 선언
DATA : GT_WA LIKE TABLE OF SCARR.
```
