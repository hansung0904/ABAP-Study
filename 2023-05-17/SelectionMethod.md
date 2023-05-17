# Selection Method
Search Help는 실행 시점에 데이터베이스에서 데이터를 가져와서 적중 리스트를 구성하게 된다. <br>
이때 사용되는 데이터베이스 대상을 Selection Method라고 한다.<br>
Selection Method로는 ABAP Dictionary Table 또는 View를 사용할 수 있다.<br>
단, Maintenance View는 사용할 수 없다.<br><br>적중 리스트는 사용자에게 입력 가능한 리스트를 보여준다.<br>
한 테이블에 필요한 값이 존재할 때는 Selection Method에 해당 테이블만 선택하면 된다.<br>
그러나 원하는 데이터가 두 개 이상의 테이블에 존재하면 <br>
&emsp; 예를 들어 코드 내역을 가지는 Text 테이블이라도 링크를 걸어 보여 주고자 한다면 <br> 테이블 엔트리는 외부키로 연결된 View를 이용해야 한다.

|TYPE|내역|설명|
|------|---|---|
|A|값 세트에 따른 다이얼로그|적중리스트 기준 100개 <br>이상이면 C 유형으로 조회<br> 이하면 D 기준으로 조회|
|C|값 제한 다이얼로그|값을 입력받아야만 리스트 조회|
|D|값 즉시 조회|즉시 리스트 조회|

Search Help의 위치를 결정하는 SPOS(Position in dialog box)와 LPOS(Position of Hit List) 속성은 <br>
Dialog Box의 위치를 결정하게 된다. 숫자를 이용해서 순서를 지정하고 '0'이나 값을 입력하지 않으면 화면에 조회되지 않는다.