# Subroutine 종료
Subroutine은 END FORM. 구문을 만나게 되면 정상적으로 종료된다. <br>
그러나 EXIT, CHECK 구문을 활용해서 Subroutine 수행 중에 종료할 수 있다. <br>
EXIT 구문을 만나게 되면 바로 Subroutine을 빠져나오고, CHECK 구문은 값을 비교해서 참일 경우에만 이후 구문 수행하게 된다.

```abap
REPORT Z04_13.

PARAMETERS : P_VAL TYPE CHAR10.

PERFORM END_SUBR USING P_VAL.

FORM END_SUBR USING VALUE(P_VAL).

    CASE P_VAL.
        WHEN 'EXIT'.
            WRITE 'Subroutine EXIT'.
            EXIT.
        WHEN 'CHECK'.
            WRITE 'Value CHECK'.
            CHECK P_VAL NE 'CHECK'.
        WHEN OTHERS.

    ENDCASE.

    WRITE 'Subroutine is normally ended'.

ENDFORM.                                 
```

예제 4-13은 PARAMETERS 변수를 이용해서 사용자에게 값을 입력받고 CASE 조건문에서 Subroutine을 제어하고 있다. <br>
사용자가 'EXIT'을 입력하면 WRITE 구문을 실행하고 EXIT 명령을 만나면 Subroutine을 빠져나온다.

ABAP 프로그램에서 사용할 수 있는 조건 분기문은 2가지가 존재하는데, 분기문은 모든 프로그램의 기본 로직을 구성하고 있으며, <br>
논리적인 값을 비교해서 수행한다.

- IF~ENDIF 분기문
  - 조건문의 논리적인 값 비교 참이면 다음 구문 실행하고 분기문을 빠져나온다.

- CASE ~ ENDCASE 분기문
  - 하나의 변수에 여러 개의 값이 존재할 경우, 해당 값마다 실행되는 구문을 다르게 설정하는 분기문.

