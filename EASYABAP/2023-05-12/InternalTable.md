# Structer(구조체) 배열과 Internal Table
C 언어에서의 구조체 배열 선언
```C
STRUCT sawon {
    char NO[6];
    char NAME[10];
    char part[16];
};
STRUCT s_type sawon[100]
```
---
ABAP에서의 인터널 테이블 선언
```ABAP
TYPES: BEGIN OF S_type,
    no(6)   TYPE c,
    name(10) TYPE c,
    part(16) TYPE c,
END OF s_type.
TYPES t_type TYPE STANDARD
    TABLE OF s_type INITIAL SIZE 100.
DATA sawon TYPE t_type.
```
C와 ABAP의 비교
|구문|C 언어|ABAP 언어|
|------|---|---|
|선언|STRUCT 구조체[건수] {};|DATA 테이블명 TYPE 테이블 타입. <br> INITIAL SIZE 건수.|
|값 할당|sawon[1].name='Kimsungjoon'; <br> sawon[2].name = 'Kimminjae';|sawon-name = 'Kimsungjoon'. <br> APPEND sawon. <br> sawon-name = 'Kimminjae'. <br> APPEND sawon.|
|값 사용|PRINTF( sawon[1].name ) <br> PRINTF ( sawon[2].name )|LOOP AT sawon. <br>WRITE sawon-name. <br> ENDLOOP.|

구조체 선언과 유사하게 인터널 테이블(구초제 배열)도 두 언어 사이에 큰 차이가 없음. <br>
다만, 값을 할당하고 사용하는 구문의 차이가 있을 뿐이다.<br>
C 언어의 구조체 배열은 배열 순번을 지정해서 값을 할당해서 사용한다.<br><br>
반면 ABAP 언어의 인터널 테이블은 구조체 배열(ARRAY)의 개념을 모두 지원하며 추가로 실제 데이터베이스 테이블의 모습과 유사하게 사용할 수 있도록 구현되었다.<br>
C 언어에서 구조체 배열을 사용해서 프로그램을 실행하면 Arrayp 구조가 이미 메모리에 Load 되어서 100건의 사원 정보 방이 생성된다.

C 언어가 배열을 선언할 때 미리 크기를 지정하는 반면에 인터널 테이블은 INITIAL SIZE 구문으로 테이블 크기만 선언할 뿐 미리 메모리에 Load 하지 않는다. 따라서 INSERT 또는 APPEND 구문을 사용해서 Line이 추가될 때마다 Load 한다.<br>
이러한 측면에서 인터널 테이블을 동적인 구조체 배열 (Dynamic Data Object)이라고도 정의한다. <br>

- **Internal Table은 동적인 구조체 배열(Dynamic Data Obejct)이다.**
- **INITIAL SIZE 구문은 실제로 메모리 공간을 할당하는 것이 아니라 예약(RESERVE)을 한다.**<br>
<br>

ABAP 프로그래밍 언어에서 인터널 테이블은 항상 할당과 추가(APPEND) 구문이 쌍으로 움직여야 함을 명심하자.<br>

**할당하고 추가하고, 할당하고 추가하고** 버릇이 되도록 되새기자.