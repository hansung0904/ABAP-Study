# 필드 심볼과 구조체
필드 심볼을 구조체에 할당하여 사용하려면 다음 구문을 활용
```ABAP
DATA: BEGIN OF gs_line,
    col1(1) TYPE c,
    col2(1) TYPE c VALUE 'X',
    END OF gs_line.
    FIELD-SYMBOLS <fs> LIKE gs_line.
    ASSGIN gs_line TO <fs>.
    MOVE <fs>-col2 TO <fs>-coll.
```
필드 심볼을 구조체처럼 사용하고자 하 경우에는 필드 심볼 선언 시에 LIke 또는 TYPE을 선언해야한다. <br>
제목은 필드 '필드 심볼과 구조체'이지만, 실제 학습하려고 하는 것은 필드 심볼의 정적 타입과 Fully Type 필드 심볼 선언이다. <br>
이것은 필드 심볼의 타입이 이미 정의되어(Specifying the Type Fully)있으면, 필드 심볼과 기술적 속성이 같은 데이터 오브젝트만이<br>
필드 심볼에 할당될 수 있음을 의미한다. <br><br> 필드 심볼 타입을 선언하지 않으면 프로그램이 실행된 시점 이후 데이터 오브젝트가 할당되어야 필드 심볼은 내부 구조를 가지게 된다. <br>
즉 프로그램 소스 코드에서 <fs>-co1 처럼 명시적으로 구조체 필드를 선언해서 사용하려면<br>
필드 심볼 타입을 완전하게 정의해야 한다.
