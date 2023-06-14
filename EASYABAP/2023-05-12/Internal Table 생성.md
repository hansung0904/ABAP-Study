# Internal Table 생성
&emsp; 인터널 테이블은 구조체 타입을 정의하고 나서 그 타입을 참고해서 생성하는 것이 일반적이다. <br>

&emsp; 다음 2가지 방법을 이용하면 인터널 테이블을 생성할 수 있다. <br>

  - **Local Table Type을 이용한 인터널 테이블 생성**<br><br>
  - **Global ABAP Dictionary Type을 이용한 테이블 생성** <br><br>
  
## &emsp; 4.1 Local Table Type을 이용한 인터널 테이블 생성
&emsp;&emsp; 개별 ABAP 프로그램에만 사용되는 인터널 테이블을 생성하는 경우에 주로 사용된다. <br>&emsp;&ensp;&ensp;&nbsp;다음과 같이 첫 번째 구조체 타입을 선언하고, 두 번째 구조체 타입을 참고하는 테이블 타입을 <br>&emsp;&ensp;&ensp; 선언하고, 세번째 이 타입을 참고하여 인터널 테이블을 생성하게 된다.

```ABAP
TYPES: BEGIN OF t_str,
        ~~~
        End of t_str
```

```ABAP
TYPES t_itbal TYPE STANDARD TABLE OF t_str
    with [{UNIQUE|NON-UNIQUE} KEY <keys>]
    INITIAL SIZE 100.
```

```ABAP
DATA: gt_itab TYPE t_itab
            [WITH HEADER LINE].
```
<br>
실무에서는 구조체 타입을 선언하고, 이 구조체 타입을 참고하는 인터널 테이블을 선언하는 2번째 <br> 방법을 많이 사용한다.
<br><br>
즉, 3단계를 통해 인터널 테이블을 생성하는 방법에서 인터널 테이블 타입을 선언하는 두 번째 단계를 <br>생략하고, 구조체 타입을 참고해서 바로 인터널 테이블을 생성한다.