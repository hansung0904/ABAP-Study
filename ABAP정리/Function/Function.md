# Function (함수)
Function은 Subroutine과 유사하게 기능별로 모듈화하고 재사용이 가능하도록 지원한다. <br>
Subroutine이 Local Modularization이라 하면, Function Module은 Global Modularization 이라고 한다.

- Function Module은 Function Group이라고 불리는 POOL에 소속되어야 한다.
- Functino Module은 예외 처리 기능을 제공하여 에러가 발생하면 예외 사항을 호출한 프로그램에 전달할 수 있다.
- Function Module은 호출 프로그램에 상관없이 Stand-alone 모드에서 테스트할 수 있다.

Function을 호출할 때 Input 파라미터를 입력하고, Function 수행 결과를 Output 파라미터로 받게 된다. <br>
Function은 Function Group (TYPE F 프로그램)에 소속되어 동작한다.<br>
Function Group은 개발 패키지처럼 유사한 기능의 Function 등을 모아 놓은 Container를 의미한다.

Function Group을 생성하고, Function Module을 추가하여 ABAP 프로그램에서 Function을 호출하는 방법에 대해서 정리한다.

## Function Module
Funciton Module은 중앙 라이브러리 (R/3 Repository)에 저장되는 특별한 Global 서브루틴이다. <br>
이러한 의미에서 Function Module을 Global Modularization이라 부르기도 한다. <br>
하나의 프로그램에서 가은 기능의 구문을 여러 번 사용하면 스크립트가 길어지고, 변경 사항이 발생할 경우 구문마다 수정해야 하는 비효율적인 문제가 발생하게 된다.

이때 Function을 이용한 모듈화를 구현해서 재사용을 제공하고 스크립트 수를 줄일 수 있다. <br>
R/3 System에는 우리가 ABAP 프로그램에서 호출해서 사용할 수 있도록 이미 수많은 Function Module이 만들어져 있다. <br>
당연히 추가로 필요한 기능은 Function Module을 생성해서 사용할 수도 있다.<br>
Function Module의 인터페이스는 Import Parameters, Export Parameters, Changing Parameters, Exceptions 등을 포함한다.

-   Import Parameters : Function Module에 전달하는 값이며 선택 사항이다.
-   Export Parameters : Function Module로부터 ABAP 프로그램에 전달받는 값이며 선택사항.
-   Changing Parameters : Function Module에 값을 넘기고, 그 값을 바꿀 수 있다.
-   Tables : 인터널 테이블을 Function Module에 전달하고 받을 수 있다.
-   Exceptions : 에러에 대한 정보를 제공한다.

## Function Group
Function Group은 여러 Function Module을 모아 놓은 Container이다. Function Group은 직접 실행할 수 없다. <br>
Function을 호출하였을 때, 시스템은 호출한 프로그램의 Internal 세션 안으로 Function Group 전체를 Load 한다. <br>
이것은 Function Group 내에서 데이터를 공유하고, 스크린을 생성해서 호출하고, PERFORM Subroutine 등을 공유 할 수 있도록 한다. <br>
그리고 주의해야 할 점은 Function이 실행될 때 이 Function이 소속된 Group 내의 모든 Function이 영향을 받는다는 것. <br>
이것은 Function 하나에 에러가 발생하면, 동일 Group 내의 모든 Function이 실행되지 않는다. <br>
그래서 Function Group 내에 중요한 FUnction을 많이 생성하는 것은 검토가 필요하다. <br>
특히 인터페이스에 사용되는 RFC의 경우는 더욱 신중을 요구한다.

Function Group의 이름은 26자까지 가능하며, Function Builder를 통해 Function과 Group을 생성하게 되면 시스템은 자동으로 Main Program과 Include Program을 생성 한다. <br>
이때 Main Program의 이름은 'SAPL'이 Function Group 앞에 붙어 구성된다. <br>
예를 들어, fgrp라는 Function Group의 Main Program 이름은 'SAPLFGRP'가 된다. <br>
Program SAPL<"fgrp">는 다음의 INCLUDE 프로그램을 포함하게 된다.

- L<"fgrp">TOP. : FUNCTION-POOL 구문을 포함하고 있다. Function Group 전체에 사용할 수 있는 전역 변수를 선언한다.
- L<"fgrp">UXX. : Include 프로그램 L<"frgrp">U01, L<"frgrp">U02와 같이 기술한다. 이것은 실제 Function Module을 포함하고 있다.

# 7가지의 탭
## Attribute - 속성
Attribute에서 가장 중요한 세팅은 Processing Type을 설정하는 것 <br>
이곳에서 내가 만들 Function Module을 *Normal Function Module, Remoted-Enabled Module, Update Module* 중 어떤 것으로 만들지를 설정할 수 있다. <br>
디폴트로는 Normal Function Module로 설정되어 있다.

 *Normal Function Module*은 SAP 시스템 안의 어떠한 ABAP 프로그램에서 호출이 가능하다. <br>
 *Remote-enabled Function* Module은 내부 뿐만 아니라 외부(remote system)에서도 호출이 가능하다. <br>
 이러한 종류의 함수 유형은 SAP 시스템 간의 상호작용 혹은 SAP 시스템과 외부 시스템과의 상호작용에도 도움을 준다.<br>
 Update Modules는 updating 동안 사용한다.

 가장 많이 사용하는 것이 Normal Function Module, Remote-enabled Function Module이며 두 가지의 차이점은 외부에서 호출되어 사용될 수 있냐의 유무이다. <br>
 개발자적인 관점에서 호출뿐만 아니라 두 유형의 차이점에는 Pass Value를 파라미터 설정 단계에서 클릭해줘야하는지의 차이도 있다.

 ## Import