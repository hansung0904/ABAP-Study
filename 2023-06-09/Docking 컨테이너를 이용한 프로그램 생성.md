# Docking 컨테이너를 이요한 프로그램 생성
Custom 컨테이너가 스크린에서 영역을 지정하는 반면에, Doking 컨테이너는 인스턴스를 생성할 때 직접 스크린과 크기를 지정하게 된다. <br>
즉, Docking이라는 단어의 의미 그대로 Custom 컨테이너를 통하지 않고, ALV가 사용될 영역과 스크린 번호를 지정해서 직접 닻을 내려서 생성하게 된다.

![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/Docking%20%EC%BB%A8%ED%85%8C%EC%9D%B4%EB%84%88%EC%9D%98%20%EA%B5%AC%EC%A1%B0.png)

SAP는 컨테이너를 결정짓는 클래스가 다르고 스크린에 영역을 지정하지 않는다는 것 외에는 Custom 컨테이너와 프로그램 사용법이 유사하다. <br>
먼저 ,Docking 컨테이너 클래스를 참고하는 컨테이너 객체 참조 변수와 ALV 인스턴스를 선언한다.

```ABAP
DATA : g_docking TYPE REF TO cl_gui_docking_container,
       g_grid TYPE REF TO cl_gui_alv_grid.
```

CREATE OBJECT 구문으로 cl_gui_docking_container 클래스의 생성자를 호출해서 g_docking 인스턴스를 생성한다.