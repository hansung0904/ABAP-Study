# Data Type
Data Type은 Data Object의 형태 및 속성을 부여하는 역할을 하며, <br>
Data Object를 정의하기 위한 하나의 템플리승로도 표현 할 수 있다.

빵집에서 쿠키를 만들 때 각종 모양의 틀로 찍어서 모양을 만드는 것 처럼, <br>
그 찍어내는 틀을 Data Type으로, 찍혀서 나온 쿠키를 Data Obejct로 비유할 수 있다.

이러한 템플릿(Data Type)은 ABAP에서 사전에 미리 정의되어 있기도 하고, <br>
우리가 프로그램을 개발하면서 직접 정의를 할 수도 있다. <br>
또한 Data Object는 메모리 공간을 할당되는 존재지만 Data Type은 메모리 공간에 존재하지 않는다.

Data Type은 다음과 같이 3가지로 나눌 수 있다.
- ABAP Predefined Type(기본 Type)
- 프로그램 내에서 정의한 Type
- ABAP Dictionary에서 정의된 Type

이 3가지 Type은 Data Object 선언시 'TYPE' 구문 뒤에 사용되어 진다.
```ABAP
DATA [Data Object Name] TYPE [Data Type].
```

## 프로그램 내에서 정의한 Type
프로그램 내에서만 사용할 목적으로 정의하며, Type이 선언된 프로그램에서만 사용가능하다. 'TYPES' 구문을 이용해서 사용할 Type을 정의한다.

'TYPES'의 일반적인 사용 문법은 다음과 같다.
```ABAP
TYPES [Data Type Name] TYPE [Data Type].
```
'TYPES'의 다양한 옵션을 통해서 Data Object의 모든 형태 (필드 / 구조체 / 인터널 테이블 )의 Type이 정의가 가능하다.

## ABAP Dictionary에서 정의된 Type
ABAP Dictionary(T-CODE se11)에서 정의된 Type들을 말하고, <br>
이 곳에서 정의된 Type들은 Global 하게 사용이 가능하기 때문에 <br>
프로그램에서 별도 정의 없이 모두 사용할 수 있다.

ABAP Dictionary에서는 모든 형태의 Data Object Type을 정의할 수 있다.

공통적으로 구조체 형태를 가진 Data Type 들은 구조체를 구성하는 필드 중 하나를 택해 필드 형태의 Data Object 선언시에도 사용될 수 있다. <br>
표기법은 'Structure-Field명'과 같이하며 '-'로 구분한다.

또한 선언 구문을 활용해서 구조체 또는 필드 형태의 Data Type 으로도 인터널 테이블 형태의 Data Object를 선언할 수 있다.
