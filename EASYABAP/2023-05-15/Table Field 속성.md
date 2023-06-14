# 4 Table Filed 속성
테이블은 데이터를 유일하게 구분할 수 있는 Key Field와 이외의 내용을 저장하는 Generic Field로 구성되어 있다.
테이블에 255문자 이상 장문의 내용을 저장해야 할 경우 STRING 타입을 이용할 수 있다. <br>
테이블은 총 3개의 STRING 필드를 가질 수 있으며, 하나의 테이블이 포함할 수 있는 필드의 크기가 ABAP Dictionary 레벨에서 제한되어 있다. <br>

테이블의 Key와 Initial Value의 속성에 대해서 알아보면 <br>

## 4.1 Key Field
필드를 테이블의 Key 값으로 사용할 땐 Key 체크박스를 선택하면 되고, Key 필드는 테이블의 데이터를 유일하게 구분할 수 있는 필드들로 <br>
구성하는 것이 바람직하다. <br>
즉, 사원 테이블에서 중복된 사원 번호가 존재하지 않는다면, 사원 번호 필드 하나만 Key 필드로 설정하면 된다. <br>
만약 사원 번호가 중복될 수도 있다면 이름도 포함해서 2개의 필드를 Key로 설정할 수 있다. <br>

**• 테이블의 총 Key 필드 수는 16개까지 가능** <br>
**• Key 필드의 길이는 모두 합해서 최대 120자까지 가능하다.** <br>
**• Key 필드는 Initial Value가 기본으로 선택된다.** <br>
**• Key로 선택된 필드는 Primary Index로 자동 생성된다.** <br>

## 4.2 Initial Value
먼저 NULL 과 Initial Value란 무엇인가? <br><br>
**NULL** <br>
NULL 은 없음이다. <br>
NULL은 값이 존재하지 않는 것. 메모리 공간을 점유하지 X
NULL은 다음과 같은 값(표현)이 될 수 없다. <br>
: 0, ", '', SPACE, 공백
NULL은 할당, 연산 비교할 수 없는 대상 <br>
ABAP 언어에는 IS NULL, IS NOT NULL 비교연산자를 SQL 구문에서 사용할 수 있다. <br> <br>

**Initial Value의 정의** <br>
Initial Value는 값이 존재하는 것이다. 그러므로 메모리 공간을 점유한다. <br>
Initial Value는 다음과 같은 값(표현)이 될 수 있다. <br>
:0, ", '', SPACE, 공백<br>
Initial Value는 할당, 연산, 비교할 수 있는 대상이다. <br>
ABAP 언어에는 IS INITIAL, IS NOT INITIAL 비교연산자를 사용할 수 있다.<br>

Initial Value는 값이 존재하지 않으면 Null 값이 아니라 초기값을 가지게 한다는 의미이며 Initial Value는 Data Type마다 다르다. <br>

|타입|초기값|
|------|---|
|I|0|
|F|0|
|P|0|
|C|'', space|
|D|'00000000'|
|N|'0 ... 0'|
|T|'000000'|
|X|X'0...0'|

Key 값은 Null 값을 허용하지 않기 때문에 Key 값으로 선택하였다면 Initial Vlaue를 선택하지 않아도 자동으로 포함된다. <br>
여기서 중요한 점은 추가 필드가 생성될 때에만 Initial Value를 설정하는 것이 의미가 있다는 것. <br>
즉, 기존의 데이터들을 Initial 속성으로 값을 저장할건지, null로 저장할 건지를 설정하는 것.

다음과 같은 구문을 사용하게 되면, null로 저장된 사원 데이터들은 조회가 되지 않는다.
```ABAP
SELECT * FROM zemp WHERE home < > SPACE
```

null 값을 포함하는 데이터까지 정확하게 가져오려면 다음과 같이 SQL 기술
```ABAP
SELECT * FROM zemp WHERE home is not null
```

***Null 값이 인식되는 구문은 오직 'IS NULL' or 'IS NOT NULL' 뿐임을 인지하여야 함*** <br>
이미 사용하고 있는 CBO 테이블에 필드를 추가하는 경우가 빈번하게 생긴다. 실제 현업에서 Initial Value를 설정하지 않아서 이와 같은 오류에 접하는 경우가 발생할 수 있기 때문에 **개념을 정확히 이해하고 있도록 하자** <br>
Initial Value를 선택하지 않더라도 신규 추가된 테이블에 데이터를 추가하게 되면 기본적으로 Initial Value가 저장된다. <br>
테이블에 신규 필드가 추가되면 DB에서 다음 구문이 수행된다.
```ABAP
ALTER TABLE table name ADD FIELD field name..
```

신규 필드에 Initial Value를 선택하고나서 테이블을 활성화하면 신규 필드의 전체 레코드에 다음 구문이 수행된다.
```ABAP
UPDATE table name SERT 필드 = Initial value..
```