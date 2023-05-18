## 역참조(Dereference)
역참조는 프로그래밍 언어에서 프로그램 포인터가 가리키는 번지에 저장된 데이터에 접근하는 것.<br>
즉, 데이터 참조가 가리키는 데이터 오브젝트의 변수값에 접근을 하려면 Dereference 과정(=필드 심볼에 Assgin)을 거쳐야 한다.<br>
필드 심볼에서 CASTING 기능도 동일하게 사용할 수 있다.
```ABAP
ASSIGN dref ->* TO <fs> [CASTING ...].
```
CASTING을 사용해서 참조 변수를 필드 심볼에 Assgin 한다는 것은, 동적으로 생성된 데이터 오브젝트의 값에 접근할 때 <br>
필드 심볼의 데이터 타입을 참고하게 된다는 의미.<br>
Dereference(=Assgin)가 성공하게 되면 SY-SUBRC 는 0을 실패하면 4을 리턴해준다. <br>
'->*' 기호는 Dereferencing Operator 라고 한다.