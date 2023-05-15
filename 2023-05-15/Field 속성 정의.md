## 1.1 Field 속성 정의 (Data Type, Field Length, Short Text)
데이터 필드에는 데이터 타입, 필드 길이, 내역을 설정해주어야 함. <br>
필드 속성은 Data Element와 Predefined Type 두 가지 방식을 이용해서 지정할 수 있음. <br>
Data Element는 사용자가 직접 생성할 수 있는 오브젝트이며, 이미 존재하는 Data Element를 입력하면 데이터 타입, 길이와 내역이 자동으로 지정된다. <br>
Data Element를 생성할 때 이미 필요한 정보를 다 입력하기 때문이다. <br>
Predefined Type을 이용하면 데이터 타입, 필드 길이, 내역을 직접 입력해줄 수 있다.

## 1.2 Reference Field와 Reference TAble
수량을 표현하는 데이터 타입 QUAN 과 화폐량을 표현하는 데이터 타입 CURR는 단위를 정의하는 참조 필드를 지정해주어야 함. <br>
예를 들어, 자재량은 1000개와 같이 수량을 명시적으로 표현해줌. <br>
하지만 단위 kg, g, ton 등에 따라서 그 값이 전혀 다른 데이터가 될 수도 있음. <br>
통화의 경우도 KRW, USD, JPY 등 단위가 다양하기 때문에 이 두가지 데이터 타입은 단위를 반드시 참고하도록 하자. <br>
전자는 Unit of measure, 후자는 Currency Key를 지정해주어야 하며, QUAN 또는 CURR 타입을 사용하는 표준 프로그램으로 <br>
BDC를 수행할 때 단위를 참조하지 않으면 에러가 발생하기때문이다. <br>
이 문제를 해결하려면 수량을 표현하는 필드에 값과 함께 단위 정보를 추가해주자

```ABAP
WRITE 원천 비용 TO 변환 비용 UNIT 'KG'.
```
CURR 타입도 동일함.
```ABAP
WRITE 원천 비용 TO 변환 비용 CURRENCY 'KRW'.
```

SAP 시스템을 운여하다 보면 화면 상에 조회되는 비용이 예상치 못한 값으로 산출되는 당황스런 경험을 한두 번은 하게 될텐데 <br>
이것은 테이블에 저장된 비용이 통화 유형에 따라 소수자릿수가 달라지기 때문에 발생하는 문제다.

