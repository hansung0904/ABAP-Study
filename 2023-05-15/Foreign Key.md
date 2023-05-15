# 6 Foreign Key
Foreign Key는 RDBMS에서 테이블 간의 연결의 정의하며, Data Integrity 및 Data Consistency를 보장하기 위해 사용된다. <br>

Ex) 사용자가 서울 = '02', 부산 = '051'과 같은 징겨 번호 코드를 입력할 때 존재하지 않는 번호를 배제하고 정확한 코드를 입력할 수 있도록 <br>
도와주는 기능을 한다. <br>
ABAP 영역에서 사용하는 Foreign Key는 ABAPP Dictionary에만 정의되어 있으며, 실제 DB에는 존재하지 않는다. <br>
이러한 이유때문에라도 DBMS에서 직접 테이블에 데이터를 추가하는 작업은 금지되어야 한다.

Foreing Key는 두 테이블 사이의 관계를 타나태는데 이때 Foreing Key 테이블의 필드는 Check 테이블의 Primary Key 값을 참조한다. <br>
Foreign Key로 불리는 테이블의 필드는 Check 테이블의 Primary Key를 의미한다. <br>
Foreign Key로 연결된 필드는 두 테이블 간에 필드명이 달라도 같은 Data Type을 가져야 한다. <br>
또한, 같은 Domain을 사용한 필드도 가능하다.

## 6.1 Check Field와 Value Check
Foreign Key가  Check Field와 연결되어 있는 것은 Foreign Key 필드에 입력되는 값은 Check 테이블에 값이 있는지 확인 과정을 거치게 된다는 <br> 것을 의미한다.
Check 테이블에 값이 없으면 Foreign Key 필드에 값이 입력되지 않는다.

## 6.2 Generic과 Constant Foreign Key
Check 테이블의 모든 Key 필드를 Foreign Key로 Check 할 필요는 없다.<br>
이 경우 Foreign Key로 연결할 필요 없이 Generic Foreign Key 또는 Constant Foreign Key로 정의하게 된다.

1. Generic Foreign Key <br>
Check 테이블에 여러개의 Key 필드가 있을 때 그 중 체크할 필요가 없는 필드에 Generic Key를 설정하면 Check 테이블에서 필드의 값을 무시하고 체크하게 된다. <br>
즉, SELECT 문이 수행될 때 조건절에서 Generic 필드의 조건이 삭제된다.
2. Constant Foreign Key <br>
Foreign Key를 위해서 상수 값을 지정해서 사용할 수 있다. <br>
이 필드의 값이 상수 값과 일치하면 Foreign Key에 값이 입력되고 일치하지 않으면 입력되지 않는다.
 