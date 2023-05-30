# ALV GRID 컨트롤의 구조
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/ALV%EC%9D%98%EC%8B%A4%ED%96%89%EC%88%9C%EC%84%9C.png)

ALV를 이용해서 데이터를 화면에 뿌려주려면 최소한 다음 2가지 작업을 해주어야 한다.

**1) 인터널 테이블 선언** <br>
화면에 보이게 될 인터널 테이블을 선언한다. ALV에서 데이터 정보를 저장하는 인터널 테이블 영역을 아웃풋 테이블이라고 한다. 

**2) 데이터의 구조(필드 카탈로그)** <br>
ALV GRID 컨트롤이 스크린에 조회되는 구조를 정의한다. <br>
즉, ALV GRID 컨트롤에서 정의되는 데이터의 구조, 기술 속성, 내역과 같은 정보들을 가지고 있다.<br>
일반적으로 ABAP Dictionary의 테이블 또는 구조체를 이용하거나, 인터널 테이블의 구조를 그대로 사용한다.<br>

ALV GRID 컨트롤에 전달되는 아웃풋 테이블에 대한 정보는 ALV GRID 컨트롤이 작동하는 이상은 <br>
유용하게 작용한다.<br>
아웃풋 테이블은 ABAP Dictionary 오브젝트를 이용할 수 도 있지만, 필드 카탈로그만으로<br>
ALV 구조를 생성할 수 있다.<br>
필드 카탈로그는 ALV 화면에 보이게 되는 필드들의 정보를 담는 테이블이다.<br>
예를 들어, ALV 필드의 타입, 속성, 길이 등을 정의하게 된다.<br>
필드 카탈로그는 LVC_T_FCAT 타입의 테이블이다.<br>
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/ALV%EC%9D%98%20%EB%82%B4%EB%B6%80%EC%A0%81%EC%9D%B8%EA%B5%AC%EC%A1%B0.png)

그림은 ALV가 화면에 보이기까지 내부적으로 구성되는 순서를 보여주고 있다.<br>
ALV를 물리적으로 화면에 보이게 하려면 먼저 ALV 영역을 지정해야 한다.<br>
이것은 스크린 레이아웃 페인터의 Custom Control을 이용해서 설정하게 된다.<br>

그리고 ALV를 화면에 보이게 하려면 스크린 영역과 ALV를 연결하는 SAP 컨테이너 컨트롤이<br>
반드시 존재해야 한다.

ALV는 화면의 SAP 컨테이너와 연결되어 화면에 뿌려지게 된다.<br>
컨테이너는 'Container'라는 영어 단어의 의미에서 알 수 있듯이 화면 내에서<br>
"무엇을 담는다."라는 것을 표현한다.
