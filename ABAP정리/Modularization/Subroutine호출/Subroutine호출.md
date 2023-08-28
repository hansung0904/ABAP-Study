# Subroutine 호출
Subroutine을 호출하는 방법에는 Internal, External 두 가지가 존재한다. <br>
PERFORM 구문을 이용해서 ABAP 프로그램 내에서 Subroutine을 호출할 수 있으며, 다른 ABAP 프로그램 내의 Subroutine도 호출해서 사용할 수 있다.

다음의 2번째 구문처럼 외부 Subroutine을 호출하는 경우 External Call이라고 하며, <br>
Subroutine 이름 다음에 괄호를 사용해서 외부 프로그램 이름을 입력한다. <br>
Subroutine 이름은 조건에 따라 동적으로 사용할 수 있다.

```abap
PERFORM subr.
PERFORM subr (prog) [IF FOUND].
```

## 1 내부 Subroutine 호출
같은 ABAP 프로그램에서 선언한 Subroutine을 호출하려면 단순히 PERFORM 구문으로 이름만 지정하면된다. <br>
문자열 2개를 Subroutine에 전달해서, 하나의 변수에 연결하는 프로그램을 만들어보면

```abap
REPORT Z04_09.

DATA : gv_val1(10) TYPE c VALUE "Hello".
DATA : gv_val2(10) TYPE c VALUE "My Name is".
DATA : gv_val3(20) TYPE c.

PERFORM concate_string USING gv_val1 gv_val2 CHANGING gv_val3.

FORM concate_string USING value(p_val1) value(p_val2) CHANGING value(p_val3).

    CONCATENATE p_val1 p_val2 INTO p_val3 SEPARATED BY space.

    PEFORM write_data USING p_val3.

ENDFORM.

FORM write_data USING value(p_val).
    WRITE :/ p_val.
ENDFORM.    
```

## 2 외부 Subroutine 호출
ABAP 프로그램은 다른 프로그램의 Subroutine을 호출해서 사용할 수 있도록 지원한다. <br>
외부 프로그램을 호출한 때는 [IF FOUND] 구문을 사용해서, 해당 Subroutine이 존재하는지 체크하는것이 바람직 <br>
체크하지 않았을 때 Subroutine이 존재하지 않으면 덤프 에러가 발생한다.

```abap
PERFORM subr(prog) [USING p1 p2 ...]
                [CHANGING p1 p2 ...] [IF FOUND].
```

```abap
REPORT Z04_10.

DATA : gv_first(10)     TYPE c VALUE 'External',
       gv_second(10)    TYPE c VALUE 'CALL',
       gv_result(20)    TYPE c.

PERFORM concate_string(z04_09) IF FOUND
                                USING gv_first gv_second
                                CHANGING gv_result.

```
## 3 Subroutine 동적 호출
### 3.1 Subroutine name 동적 지정
***외부 프로그램의 Subroutine을 호출할 경우에 이름을 동적으로 지정할 수 있다.(내부 프로그램도 같은 형태로 사용이 가능하다.)***

```abap
PERFORM (fsubr) [IN PROGRAM (fprog)] [USING p1 p2 ...]
                                        [CHANGING p1 p2 ...]
                                        [IF FOUND].
```

```abap
REPORT Z04_11.

DATA : gv_first(10) TYPE c VALUE 'Dynamic',
       gv_second(10) TYPE c VALUE 'CALL'.
       gv_result(20) TYPE c.

DATA : gv_pname(8) TYPE c VALUE 'Z04_09',
       gv_subname(20) TYPE c VALUE 'COCATE_STRING'.

TRANSLATE GV_PNAME TO UPPER CASE.

PERFORM (gv_subname) IN PROGRAM (gv_pname) IF FOUND
                        USING gv_first gv_second CHANGING gv_result.
```
위 프로그램의 에제는 4-9 프로그램의 Subroutine을 동적으로 호출하고 있는데, 동적 구문을 사용할 때는 <br>
**프로그램 이름과 서브루틴 이름을 반드시 대문자로 지정해주어야 하며, 예제에서는 TRANSLATE 명령을 사용해서 대문자로 변환했다.**

### 3.2 LIST를 이용한 Subroutine 호출
다음 구문과 같이 LIST를 이용해서 Subroutine을 차례대로 호출할 수 있다.
```abap
PERFORM idx OF subr1 subr2 ... subrn.
```
시스템은 idx의 순서에 따라 Subroutine List를 호출하게 된다. 오직 Internal Subroutine에서만 사용할 수 있으며 <br>
파라미터를 사용할 수 없는 단점이 있다.

```abap
REPORT Z04_12.

DO 2 TIMES.
    PERFORM SY-INDEX OF subr1 subr2.
ENDDO.

FORM subr1.
    WRITE / '1 Subroutine is called.'.
ENDFORM.

FORM subr2.
    WRITE / '2 Subroutine is called.'.
ENDFORM.
```

ABAP 프로그램에서 사용할 수 있는 순환 반복 구문은 3가지가 존재한다. <br>
순환 구문 내에서 EXIT 명령을 만나면 순환 구문을 빠져나온다. <br>
CONTINUE 명령을 만나면 이후 스크립트를 실행하지 않고 다음 순환을 실행한다. <br>
CHECK 명령은 값을 비교해서 참일 경우에만 이후 구문 수행하고 거짓이면 다음 순환을 실행한다. <br>

- DO ~ ENDDO 순환 구문
  - 순환 횟수를 지정할 수 있는 구문. 횟수를 지정하지 않으면 무한 LOOP 수행.
  - 현재 순환 횟수는 시스템 변수 SY-INDEX에 저장.

- WHILE ~ ENDWHILE 순환 구문
  - WHILE 구문의 다음의 표현식이 참 이면 반속순환 지속.
  - 현재 순환 횟수는 시스템 변수 SY-INDEX에 저장

- LOOP ~ ENDLOOP 순환 구문
  - 인터널 테이블의 라인을 차례대로 Work Area 또는 Header Line으로 이동하는 순환 구문
  - 현재 순환 횟수는 시스템 변수 SY-TABIX에 저장된다. **SY-TABIX는 인터널 테이블의 라인 번호.**