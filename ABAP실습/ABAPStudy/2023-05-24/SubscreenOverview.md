# SubScreen
Subscreen은 Runtime 환경에서 다른 스크린의 Sub Area에 포함되도록 한다. <br>
그림과 같이 하나의 스크린이 또 다른 스크린을 자기 자신 안에 포함하는 것.<br>
<img src="https://help.sap.com/doc/saphelp_nw73ehp1/7.31.19/en-us/4a/44b362954c0453e10000000a421937/loio4a44b364954c0453e10000000a421937_LowRes.png" width="300px">

Subscreen은 6절에서 학습하게 될 TabStrip에서 주로 사용된다.<br>
Subscreen은 각각의 Flow Logic을 가질 수 있는데, 일반 스크린에서 사용하는 방법과 몇 가지를 제외하고는 같다.<br>
예를 들어 Subscreen은 자신의 OK_CODE 필드를 가질 수 없으며(메인 스크린의 OK_CODE를 상속받는다.)<br>
MODULE ... AT EXIT-COMMAND 모듈은 메인 스크린에서만 관리할 수 있다.

Subscreen을 생성하려면 다음의 순서로 작업하자.

**①스크린 상에서 스크린 Area를 정의하고,**<br>
**②Subscreen을 정의한 다음**<br>
**③Subscreen 영역 안에 Subscreen을 배치한다.**<br>

**Subscreen에서 특이사항 및 주의할 점** <br>
&emsp; **• Subscreen의 크기 조정 때문에 배치된 스크린 요소들리 잘리지 않도록 스크린 요소를 재배치하여야 한다.**<br>
&emsp; **• 여러 개의 Subscreen을 생성할 때 각각의 스크린 요소들의 이름을 유일하게 지정해주어야한다. <br>&emsp;&emsp; 스크린과 ABAP 프로그램과의 데이터 통신이 일어날 때 문제가 되기 때문**<br>
&emsp; **• Subscreen은 OK_CODE 필드를 가질 수 없다. Subscreen 상에서 발생한 사용자 액션에 대한 Function Code는 메인 스크린의 OK_CODE 필드에 저장한다.**<br>
&emsp; **• Flow Logic 중 MODULE AT EXIT-COMMAND를 가질 수 없다. 왜냐하면, Type E Function은 Main Program에서만 사용될 수 있기 때문이다.**<br>
&emsp; **• Subscreen은 자신의 GUI STATUS를 가질 수 없으며, 다음과 같은 구문을 사용할 수 없다.**<br>

**SET TITLEBAR** <br>
**SET PF-STATUS**<br>
**SET SCREEN**<br>
**LEAVE SCREEN**<br>
**LEAVE TO SCREEN**<br>
