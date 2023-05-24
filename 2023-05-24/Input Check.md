# Input Check
사용자가 화면의 Input 필드에 값을 입력하면, 필드가 허용하는 올바른 타입의 데이터인지 체크하게 된다. <br>
이것을 프로그램 용어로 검증(Validation)이라 부른다. <br>

스크린에는 3가지 유형의 Input Check 로직이 존재한다. <br>

**• Automatic Input Check** <br>
**• Input Checks in the Flow Logic** <br>
**• Input Checks in Dialog Module** <br>

**1.Automatic Input Check**
Automatic Input Check는 스크린 필드의 데이터가 ABAP 프로그램으로 복사되거나 Dialog 모듈이 호출되기 <br>
이전에 PAI 이벤트에서 자동으로 수행된다.

필수 입력 필드, 데이터 포맷 체크 그리고 ABAP Dictionary 레벨의 체크가 수행된다.<br>
Automatic Input Check가 수행되기 이전에, Function code가 E타입으로 선언된<br>
MODULE〈xxx〉 AT EXIT-COMMAND를 호출할 수 있다. <br>
만약 필수 필드가 설정된 스크린에서 사용자가 <EXIT> 버튼을 클릭해서 화면을 빠져나가려고 할 경우에 <br>
Function code가 E로 설정되어 있지 않으면, Automatic Input Check가 가장 먼저 수행되어 에러가 발생하고<br>
사용자는 화면을 빠져나갈 수 없게 된다.<br>

즉, AT EXIT-COMMAND는 필수 필드를 입력하지 않고 스크린을 빠져나가기 위한 목적으로 주로 사용된다.

**2. Input Check in the Flow Logic** <br>
Dialog 모듈이 호출되기 이전에 Flow Logic에서 Input Check를 수행한다. <br>

Example)
```ABAP
FIELD <f> VALUES (<v1>, <v2>, ..).
```
이 구문은 필드에 '00001'이외의 값이 입력되면 에러가 발생한다. <br>

또한, 데이터베이스 테이블 레벨에서 다음과 같이 체크가 가능하다.
```ABAP
FIELD <f> SELECT * FROM <dbtab>
    WHERE <k1> = <f1> AND <k2> = <f2> AND...
    [INTO <g>] WHENEVER [NOT] FOUND SEND ERRORMESSAGE|WARNING
    [<num> [WITH] <h1>...<h4>].
```
일치하는 값을 찾지 못하면 에러 메시지나 경고 메시지를 보여주고, 필드 <f>를 입력대기 상태로 만든다. <br>

**3. Input Check in Dialog Module** <br>
PAI 모듈에서 Input Check를 수행한다. <br>
실무에서 가장 많이 사용하는 방법은 아래 방법이다.
```ABAP
FIELD <f> MODULE <mod>.
```
사용자가 입력한 값을 제한하거나, 테이블에 존재하는 값인지 체크할 수 있다. 
또한, 모듈로 존재하기 때문에 많은 기능을 추가해서 사용이 가능하다.
```abap
FIELD <f> MODULE <mod> ON INPUT.
```

