# Report program Overview
ABAP Programming의 기본이 되는 Type-1 Program을 흔히 Report Program, Executable Program 혹은 Interactive Program이라고 
한다. <br>
데이터베이스에서 원하는 데이터를 추출하고 해당 데이터를 정보로 활용할 수 있는 구조로 변경하여 리포트 형식으로 조회한다. <br>
그리고 프로그램 자체적으로 직접 실행(Executable)이 가능하며 SUBMIT이라는 키워드를 통해서 다른 프로그램에서 호출할 수 있다.

Type-1 프로그램을 생성하고 실행시키면 그림 12-1과 같은 흐름에 의해 처리된다. <br>
가장 먼저 INITIALIZATION을 만나고, SELECTION-SCREEN에서 사용자의 입력 사항에 따라 해당하는 엔트리를 읽고, <br>
데이터를 가공해서 결과를 보여준다. 

이러한 프로세스 자체가 데이터를 읽고 조회하는데 가장 적합하므로 흔히 Report Program이라 한다. <br>
Report Program을 실행하였을 때 프로그램의 흐름은 각각의 이벤트를 통해 통제된다. <br>
이벤트 블록(프로세싱 블록)은 SELECTION-SCREEN이나 리스트 등에서 일어나는 사용자 액션에 의해 발생하는 이벤트의 의해서 호출된다.<BR>
![](../img/5-10.png)