# PAI 모듈 구현
PAI 모듈은 사용자가 입력 필드에 값을 입력하고 Enter 키를 입력하거나, 스크린의 푸쉬 버튼을 클릭하였을 대와 같은 User Diaglog에 반응하는 이벤트이다. <br>
GUI STATSUS에서 추가해준 4개의 버튼에 해당하는 스크립트를 추가한뒤에 <br>
각 버튼을 클릭하면서 테스트를 해보면<br>
GUI STATUS 생성 시 Function Type을 E로 생성하게 되면 AT EXIT-COMMAND 구문을 수행하게 된다.<br>
예제 코드에서 MODULE screen_exit_0100 AT EXIT-COMMAND.<br>
모듈을 PAI에서 먼저 구현해서 프로그램을 빠져나가는 로직은 따로 구현하는게 좋다. <br>
스크린 Flow Logic이 어떠한 위치에 있더라도 E 타입의 Function이 수행되면, 이 구문은 즉시 실행된다.<br>
AT EXIT-COMMAND 구문은 스크린 필드가 ABAP 프로그램 필드로 복사되기 이전에 발생하므로 <br>
가장 먼저 발생하게 되는 모듈이다 <br>
&emsp; **(단, OK_CODE는 스크린 필드에서 ABAP 프로그램 필드로 복사된다.)**