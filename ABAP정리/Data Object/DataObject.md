# Data Object

프로그램에서는 숫자, 문자 등의 형태로 이루어진 데이터를 제어하기 위해서는 메모리라는 컴퓨터 내부적인 작업공간에 할당해서 사용하게 된다.

이 때 메모리 공간 내에서 데이터를 담기 위한 하나의 객체를 Data Obeject라 한다.

Data Object에 담긴 데이터들은 프로그램 시작시 메모리에 할당되어 존재하게 되며, 종료시에는 메모리에서 소멸되는 휘발성을 가진다. 만약 데이터를 저장해야 할 경우라면 DB라는 별도 저장공간에 저장하게 된다.

ABAP 프로그램에서 일반적으로 가장 많이 사용되는 Data Object의 형태는 다음과 같다.
- 필드(field) - 단일 값을 가진 형태. 흔히 변수(Variable)라고 부른다.
- 구조체 (Structure) - 여러 필드의 집합으로 하나의 구조로 모인 1차원 형태
- 인터널 테이블(Table) - 동일한 구조가 여러 행으로 쌓이는 2차원 형태, 배열이라고도 한다.

ABAP에서 Data Object를 선언하는 방법은 다양한 방법이 있지만 그 중 대표로는 'DATA'가 있다.

'DATA'의 일반적인 사용 문법은 다음과 같다.
```abap
DATA [Data Object Name] TYPE [Data Type].
```
선언되어지는 Data Object에는 프로그램 내에서 지칭할 수 있는 이름이 있어야 한다. -> Data Object Name <br>
TYPE 구문 뒤에는 Data Type을 명시해 줌으로써 Data Object의 형태 및 속성을 결정한다. -> Data Type

추가적으로 선언한 Data Object에 값(데이터)을 넣을 시에는 다음과 같이 우측(데이터)에서 좌측(데이터를 담을 Data Object)으로, 넣어준다는 의미인 '='로 표기한다.

```ABAP
Data Object Name = Value.
```

우측 대상엔 데이터가 아닌 데이터를 담고 있는 또 다른 Data Object가 올 수 있으며, 그 때는 그 Data Object에 들어 있는 값이 좌측 Data Object로 전달된다.

Data Object를 선언하는 선언 구문은 'DATA' 외에도 'TABLES', 'PARAMETERS', 'FIELD-SYMBOL', 'CONSTANTS' 등이 존재한다.