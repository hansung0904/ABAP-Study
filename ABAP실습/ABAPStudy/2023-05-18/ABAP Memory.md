# ABAP Memory
SPA/GPA 파라미터는 SAP Memory 영역을 할당하는 반면, EXPORT를 수행하게 되면 <br>
ABAP Memory 영역을 할당하게 된다. <br><br> EXPORT 구문을 이용해서 데이터 오브젝트를 ABAP Memory에 LOAD 할 수 있다.<br>
SAP Memory를 이용하려면 파라미터 ID를 생성해야하지만 ABAP Memory를 사용하는 경우는 메모리 ID 명을<br>
프로그램 레벨에서 임의로 지정할 수 있다. <br><br> ABAP Memory를 이용해서 데이터를 넘겨주려면 EXPORT/IMPORT 구문을 사용하며, <br>
같은 파라미터 ID 명을 사용해야 한다. <br>
EXPORT/IMPORT 구문은 다른 프로그램을 호출할 때 데이터 오브젝트를 넘겨주기 위해 자주 사용된다.<br>
다른 프로그램을 호출할 때 다음과 같은 명령어(CALL TRANSACTION, SUBMIT, CALL DIALOG)를 사용하면<br>
내부 세션이 생성되고 ABAP Memory에 존재하는 데이터가 공유된다. <br><br> ABAP Memory 영역은 내부 세션에서만 데이터가 공유되므로,<br>
다른 외부 세션의 프로그램에 데이터를 넘겨줄 수 없다.(Shared Buffer를 사용하면 가능하다.) <br>
즉 EXPORT/IMPORT는 같은 윈도우 창에서만 메모리 영역을 공유하므로 새 창을 띄워서 작업할 때는 메모리 영역이 사라지게 되는 것에 주의해야 한다. <br>

```ABAP
EX[ORT obj1 ... objn TO MEMORY ID key.
```

```ABAP
IMPORT obj ... bojn FROM MEMORY ID key.
```
ABAP Memory에 저장된 내용을 삭제하려면 다음 구문을 사용한다.<br>
***이때 ID key를 생략하면 전체 메모리를 삭제하게된다 주의 요망!!!***
```ABAP
FREE MEMORY [ID key].
```
트랜잭션 또는 실행 가능한 프로그램을 호출할 때 두 가지 경우로 나누어 정리해보자.<br><br> 첫째, 호출된 프로그램이 종료되고 호출한 프로그램으로 되돌아올 때에는 호출된 프로그램은 삭제되지 않고 비활성화된 상태가 된다.<br>
그리고 메모리에 저장된 값들은 스택으로 옮겨진다 이러한 작업은 9개까지 가능하다. <br><br> 둘째, 호출된 프로그램이 수행을 종료하고 호출한 프로그램으로 복귀하지 않으면 <br> 호출된 프로그램은 호출한 프로그램을 내부 세션에서 자신과 바꾸어 버리고 호출한 프로그램의 메모리 값은 삭제된다. 
