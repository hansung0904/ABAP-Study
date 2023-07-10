# ALV GRID 컨트롤 인스턴스
ALV 프로그램에서 사용하는 인스턴스는 CL_GUI_ALV_GRID 클래스를 참고하는 변수로 정의되어 있다. <br>
다음 구문을 이용해서 객체 참조 변수를 선언한다.<br>
```ABAP
DATA : gv_grid TYPE RET TO cl_gui_alv_grid.
```
위 구문의 gv_grid 변수는 CL_GUI_ALIV_GRID를 참고하는 객체 참조 변수이다.<br>
그리고 CREATE OBJECT 구문으로 클래스의 생성자를 호출해서 ALV GRID 인스턴스를 생성한다.<br>
```ABAP
CREATE OBJECT gv_grid.
```
ALV GRID 컨트롤은 화면에 보이는 모든 정보를 가지고 있으며, 클래스의 메서드를 호출해서 ALV 화면의 속성을 재정의하고 변경할 수 있다.