# Tabstrip의 종류
스크린 레이아웃에서 Tabstrip과 Tab Title을 정의하려면, Tabstrip Area는 유일한 이름, <br>
위치, 넓이, 높이를 지정하여야한다.<br>
사용자가 윈도우 크기를 조절할 때 Tabstrip의 크기도 조절하도록 설정할 수 있다. <br>
Tabstrip Area를 정의할 때 (생성할 때), 두 개의 Tab Title이 자동으로 생성된다.(물론 하나의 Tap Title만으로도 구성할 수 있다.)<br>
Tab Title은 기술적으로 Pushbutton과 같은 개념의 오브젝트라고 간주하면 된다.<br>

즉 Tap Titel은 Pushbutton과 같은 속성을 가지고 있다.<br>
이름이 존재하고, 텍스트를 지정할 수 있으며(동적인 할당 가능), FUnction code가 존재하고 아이콘을 보여줄 수 있다.

Tapstrip 생성은 다음과 같은 단계로 진행된다.

**① 스크린에 Tab Area 영역과 Tab Title을 정의한다.** <br>
**② 각 Tab Title에 Subscreen 영역을 할당한다.** <br>
**③ 스크린 Flow Logic을 프로그래밍한다.** <br>
**④ ABAP Processing Logic을 프로그래밍한다.** <br>

SAPgui 또는 Application Server에서 paging을 할 것인지를 결정해주어야 하는데, <br>
SAPgui를 선택했다면 각각의 Tab Page는 자신의 Subscreen을 가지고 있어야 하며,<br>
Application Server를 선택하였다면 모든 Tab Page에서 공유되는 하나의 Subscreen 영역만 지정하면 된다.
