# Temporary Subroutine
메인 메모리에서 동자하는 동적 서브루틴을 정의할 수 있다.
```abap
GENERATE Subroutine POOL <itab> NAMe <prog>.
```

위 구문은 실행 중인 프로그램의 Main 메모리에 Subroutine POOL을 생성하게 된다. <br>
Subroutine Pool의 소스 코드를 &#60;itab&#62; 인터널 테이블에 삽입하며, 8자리 Type C의 &#60;prog&#62; 서브루틴 프로그램을 생성하게 된다. <br>
즉, 동적으로 서브루틴을 사용하고자 할 경우 서브루틴 풀(프로그램)을 생성해서 사용할 수 있다. <br>
이것은 인터널 테이블을 동적으로 선언해야 하는 경우 등에 아주 유용하게 사용된다.

예를 들어, 사용자가 매출 금액을 기간을 설정해서 조회하는 프로그램이 있다고 가정해보자. <br>
사용자는 동적으로 해당일을 선택할 수 있기 때문에 인터널 테이블의 칼럼 수를 미리 정의하기가 곤란하다. <br>
이럴 때는 GENERATE 구문을 이용하면 입력된 일수만큼 인터널 테이블을 동적으로 선언할 수 있다. <br>
이 외에도 동적 인터널 테이블을 생성하는 방법은 여러 가지가 있다. <br>
서브루틴 풀은 생성된 프로그램이 실행된 상태에서만 존재한다. <br>
하나의 프로그램에 36개까지 서브루틴 풀을 생성할 수 있다. <br>
에러가 발생하게 되면 SY-SUBRC = 8 이 리턴된다.

```abap
REPORT Z04_14.

DATA : gt_code(72) OCCURS 10,
       gv_prog(8),
       gv_msg(120).

APPEND 'PROGRAM SUBPOOL.' TO gt_code.

APPEND 'FORM dynamic_subr.' TO gt_code.
APPEND 'WRITE / ' 'Dynamic Subroutine is called' '.' TO gt_code.
APPEND 'ENDFORM.' TO gt_code.

GENERATE SUBROUTINE POOL gt_code NAME gv_prog
MESSAGE gv_msg.

IF sy-subrc NE 0.
    WRITE :/ 'Subroutine POOL is failed'.
ELSE.
    WRITE :/ 'Subroutine POOL name : ' , gv_prog.
    SKIP 1.
    PERFORM dynamic_subr IN PROGRAM (gv_prog).
ENDIF.
```
