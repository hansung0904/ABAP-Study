# Function ALV Overview

Function ALV는 이름에서 유추할 수 있듯이 Function(함수)으로 제공되기 때문에 개발자는 이미 구현된 기능을 적절히 사용하면 된다.<br>
스크린을 생성할 필요가 없고, 스크립트를 일일이 기술할 필요가 없어서 비교적 생산성이 높은 개발 방법을 제공하고 있다.<br>
이러한 연유로 구식방법인 Function ALV가 여전히 실무에서 많이 활용되고 있으며, GRID(Object기반)를 이용한 ALV와 함께 앞으로도<br>
지속적으로 사용될 것이다.

SAP사에서 Function ALV의 다양한 예제를 SLIS라는 패키지에서 제공하고 있다.<br>
이번 장을 통해 Function ALV의 구조와 구현 방법에 대해 이해하고 적절한 예제를 찾아서 활용해 나가보도록 하자.

Report-1 타입의 주요 기능은 WRITE 구문을 통해서 사용자에게 데이터를 보기 좋은 형태로 제공하는 것.<br>
이와 유사하게 구현된것이 LIST를 이용한 Function ALV이다.<br>
REUSE_ALV_LIST_DISPLAY 함수를 이용해서 구현이 가능하다.