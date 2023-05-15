# 6 Foreign Key
Foreign Key는 RDBMS에서 테이블 간의 연결의 정의하며, Data Integrity 및 Data Consistency를 보장하기 위해 사용된다. <br>

Ex) 사용자가 서울 = '02', 부산 = '051'과 같은 징겨 번호 코드를 입력할 때 존재하지 않는 번호를 배제하고 정확한 코드를 입력할 수 있도록 <br>
도와주는 기능을 한다. <br>
ABAP 영역에서 사용하는 Foreign Key는 ABAPP Dictionary에만 정의되어 있으며, 실제 DB에는 존재하지 않는다. <br>
이러한 이유때문에라도 DBMS에서 직접 테이블에 데이터를 추가하는 작업은 금지되어야 한다.
