# Types of Messages
메시지 처리는 MESSAGE 구문이 실행되는 프로그램의 문맥에 따라 달라진다. <br>
특정 메시지 유형이 전송된 후의 시스템 동작은 문맥에 따라 다르다.

## Message Type
- A : Termination Message
    - 메세지가 Dialog Box에 표시되고 프로그램이 종료된다. <br> 사용자가 메시지를 확인한 후에는 제어가 다음으로 높은 수준의 영역 메뉴로 돌아간다. <br> 이 유형의 메시지는 현재 작업으로 처리할 수 없는 오류가 발생하거나 시스템 관련 오류가 발생한 경우에만 사용해야 한다.

- E : Error Message
    - 프로그램 문맥에 따라 Error Dialog Box가 나타나거나 프로그램이 종료된다. <br> 오류가 수정되지 않으면 프로그램 실행이 계속되지 않는다. <br> 이러한 유형의 메시지는 입력값의 유효성 검사에 사용되거나 오류로 인해 프로그램 실행이 진행할 수 없는 경우에 사용된다.

- I : Information Message
    - 메시지는 Dialog Box에 표시된다. <br> 사용자가 메시지를 확인한 후에는 MESSAGE 문 이후의 프로그램이 즉시 계속된다. <br> 이 유형의 메시지는 데이터베이스 업데이트와 같은 성공적인 작업을 나타내는 데 사용된다. <br> 또한 정보를 제공하는 메시지를 사용된다.

- S : Status Message
    - MESSAGE 문 이후에 프로그램은 정상적으로 계속되며, 메시지는 다음 화면의 상태 표시줄(status bar)에 표시된다. <br> 이 유형의 메시지는 어떤 작업의 상태를 표시하는 데 사용된다.

- W : Warning Message
    - 프로그램 문맥에 따라 Error Dialog Box가 나타나거나 프로그램이 종료된다. <br> 사용자는 [Enter]를 눌러 프로그램 실행을 계속할 수 있다. <br> 이 유형의 메시지는 사용자에게 필요한 정보가 누락되었음을 경고하기 위해 사용된다.

- X : Exit Message
    - 메시지가 표시되지 않고, 프로그램이 short dump와 함께 종료된다. <br> short dump와 함께 프로그램이 종료되는 것은 일반적으로 런타임 오류가 발생할 때 발생한다. <br> X 유형의 메시지는 프로그램 종료를 강제하는데 사용된다. <br> short dump에는 메시지 ID가 포함된다.