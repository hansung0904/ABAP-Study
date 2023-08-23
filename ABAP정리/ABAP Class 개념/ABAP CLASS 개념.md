# ABAP Class(OOP)
SAP ABAP에서 중요한 OOP의 기준 CLASS에 대해 알아보자

Class는 실생활에서 추상화한 객체. <br>
SAP ABAP에서는 두가지의 형태를 지원한다. <br>
객체는 실생활의 어떠한 요구사항을 반영한 것으로 <br>
Attribute, Event, Interface, Method 등의 기능을 가질 수 있다.<br>
**이 말은 즉 -> 캡슐화가 가능하다**

Global Class <br>
- T-CODE : SE24에서 생성/조회/수정이 가능한 클래스

Local Class <br>
- SAP ABAP Program내에서 선언해서 사용하는 클래스

```ABAP
"선언
CLASS <Class name> DEFINITION. 

" PUBLIC SECTION, PRIVATE SECTION, PROTECTED SECTION..


...

END CLASS.
```

## Class의 구성요소들에 대해서 알아보면..
DATA LO-CLASS TYPE REF To \<CLASS 명>. <br>
-> 객체 잠조 변수는 이미 존재하는 객체를 참고하거나 초기화 할 수 있으며 객체를 가리키는 참조변수가 객체의 실체를 알고 있으며 클래스의 인스턴스는 객체를 가르키는 참조 변수를 사용해서 주소를 지정한다.

객체참조 변수를 이용하는 객체들은 구성요소에 직접접근은 불가하므로, Reference(객체의 주소)를 이용해야한다.

## Instance
하나의 클래스로부터 객체화 선언한 형태

## Component
ATTRIBUTE, METHOD, EVENT, INTERFACE, CONSTRUCTOR 등의 구성요소

## 접근 제한영역
CLASS의 접근 제한영역은 크게 3가지로 구분
- PUBLIC SECTION
  - 하나의 클래스내에 선언된 컴포넌트들은 모든 클래스에서 상속 받아 사용할 수 있는 영역
  - 클래스와 사용자 간의 인터페이스 역할

- PROTECTED SECTION
  - 자신과 상속받은 클래스에서만 컴포넌트들을 접근할 수 있는영역으로 자식과의 인터페이스 역할

- PRIVATED SECTION
  - PRIVATED 선언 컴포넌트들은 같은 클래스에서만 메서드를 사용할 수 있는영역으로 외부에서 접근할 수 없음.
  - 완전히 클래스에서 캡슐화되어 타 클래스에서 사용불가.

## ATTRIBUTE
CLASS내에서 선언된 data Field로 Type C,I,F,N을 가질 수 있음 <br>
또한  Reference variable 또한 정의가 가능하며, 클래스 내에서 객체를 참조하는 형태.