# Function
Function group -> create -> Function Module <br>
보통의 경우 실무에서 regular function module로 생성 <br>
JAVA도 SAP 같이 프로젝트할 경우 Remote-Enabled module 선택 <br>
&emsp; ***RFC라고 일컬음***

Update Module은 건드리지 않음.<br>
Import 탭은 입력 받는 값 <br>
I_라고 적어주는 것은 Naming Rule (Import를 뜻한다.)<br>
사원번호 (numeric type) 기본값 지정시 ''(single quotation) 필수 <br>
pass by value가 체크 되어있을 시 입력받은 값 변경 가능<br>
&emsp; ***remote 체크시 무조건 필수사항***<br>

Import/Export는 구조까지는(Data type에서의) 허용가능<br>
Changing도 마찬가지<br>
Tables는 진짜 Table만 사용가능<br>

Function에서의 단점 <br>
String이 포함되어 있으면 Table로 구성할 수 없음.<br>
꼼수로 Sturcture String으로 선언해서 사용<br>

Export에서 Error 처리를 Exception에서보다 많이 사용함.<br>
함수 호출은 = Call Function <br>
pattern 버튼을 누르면 call function 호출함수 넣어주면 알아서 만들어준다.<br>
T-CODE : SE37 에서 함수 검색가능

