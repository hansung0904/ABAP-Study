# SALV 종류와 구현
SALV는 함수 및 GRID를 이용해서 ALV를 통합한 패키지라고 설명했다. <BR>
이것은 ALV를 화면에 보여줄 스크린을 추가로 생성할 것인지, 아니면 자동으로 생성되는 화면을 이용할 것인지 <BR>
하는 문제로 귀결될 수 있다. SALV는 다음 3가지 ALV 모드를 지원한다.

**• 전체 화면 모드 <BR>**
**• 전체화면 -Classic List 모드 <br>**
**• 컨테이너를 이용한 모드**

GRID를 이용한 ALV 프로그램에서 사용하게 되는 인스턴스는 CL_GUI_ALV_GRID 클래스를 참고하는 변수로 정의되어져 있다. <BR>
SALV는 기본적으로 CL_SALV_TABLE 클래스를 참고하게 된다.

SALV를 화면에 출력하려면 SALV 인스턴스를 생성해야 하는데, 이때 FACTORY 메서드를 사용하게 된다. <BR>

ALV를 화면에 출력하려면 2개 메서드만으로 충분하다. <br>
• FACTORY : 화면에 출력할 데이터를 정의하게 된다. ALV 리스트 형태를 정의하게 된다.<br>
• DISPLAY : 메서드를 호출하기만 하면 스크린에 ALV가 조회된다.

FACTORY 메서드는 Static 메서드이기 때문에 => 기호를 이용하고 <br>
DISPLAY 메서드는 Instance 메서드이기 때문에 -> 기호를 이용해서 호출한다. <br>
SALV 인스턴스를 생성하는 FACTORY 메서드의 내부 스크립트에는 CREATE OBJECT 구문으로 <br>
클래스를 참고하는 객체를 생성하게 된다. FACTORY 메서드를 호출할 때 다음의 파라미터를 정의하게 되고<br>
해당하는 값으로 SALV 리스트 형태가 결정된다.

**• LIST_DISPLAY <BR>**
**• R_CONTAINER <br>**
**• CONTAINER_NAME**

|리스트 타입|LIST_DISPLAY|R_CONTAINER|CONTAINER_NAME|
|------|---|---|---|
|전체화면|ABAP_FALSE|초기값|초기값|
|Classic List|ABAP_TRUE|초기값|초기값-|
|컨테이너 이용|ABAP_FALSE|CL_GUI_CONTAINER를 참고하는 <BR> 객체 참조 변수|컨테이너 이름|

SALV를 화면에 출력하기 위한 주요 과정은 다음의 3단계로 요약이 가능하다. <BR>
인터널 테이블 gt_itab은 애플리케이션 데이터를 저장하고 있으며, <br>
gr_table은 SALV의 Main 클래스인 cls_salv_table의 객체 참조 변수이다. <br>
gr_table은 SALV 화면에 출력하는 용도로 사용되고, ALV Table이라고 부르기도 한다.

① 데이터 추출<br>
```abap
DATA gt_itab TYPE TABLE OF sflight.
DATA gr_table TYPE REF TO cl_salv_table.

SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_itab.
```
② SALV 인스턴스 생성<br>
```abap
CALL METHOD cl_salv_table=>factory
    IMPORTING
        R_SALV_TABLE = gr_table
    CHANGING
        t_table = gt_itab.        
```
③ SALV 테이블 조회<br>
```ABAP
gr-_table->display().
```