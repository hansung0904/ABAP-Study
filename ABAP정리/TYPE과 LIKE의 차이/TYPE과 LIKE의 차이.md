# TYPE과 LIKE의 차이

TYPE과 LIKE의 차이는 Data Object 선언시 TYPE 또는 LIKE 뒤에 <br>
**Data Object와 Data Type 중 어느 것을 reference 하는지 차이**라고 볼 수 있다.

**• Data Object : 실제 메모리 공간에 할당된 존재. <br>**
**• Data Type : 메모리 공간을 차지하지 않고 Data Object를 정의하기 위한 하나의 템플릿.**

영어사전에서 TYPE과 LIKE의 뜻을 찾아보면 <br>

<U>TYPE은 형태,틀,종류 등으로 정의하고 있고 <br>
LIKE는 '~와 같은', '~와 비슷한'등으로 정의되며 어느 한 대상(실체)과 비교해서 사용하게 된다.</U>

구문의 뜻으로 보면 TYPE 뒤에는 Data Type이 오고, <br>
ABAP Dictionary에 Structure Type / Table / Classic View 가 이에 해당한다.

SAP 에서 과거에는 사용가능하도록 만들어 놓았지만 SAP ABAP도 버전업이 되면서 <br>
LIKE는 Data Object인 경우에만 사용하라고 권고 하고 있다.

추가로 CLASS 같은 OO(Objected-Oriented) 개념에서는 TYPE만 사용 가능하다.

정리하자면, <br>
***TYPE은 뒤에 Data Type을 reference 할 때 사용*** <br>
***LIKE는 뒤에 Data Object를 reference 할 때 사용***