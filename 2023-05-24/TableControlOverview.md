# Table Control
화면에 많은 데이터가 조회되어야 할 경우 테이블 컨트롤을 사용하게 된다. <br>
테이블 컨트롤은 칼럼 헤더와 칼럼 정보를 가지는 Simple 컨트롤의 한 종류로 <br>
엑셀 시트와 같이 Tabualr 형태로 데이터를 보여준다. <br>
ABAP은 스크린 내에서 테이블 데이터를 보여주거나, 조정할 때 두 가지 형태의 메커니즘을 제공하는데,<br>
그것은 Table Control과 Step Loop이다. <br>

테이블 컨트롤은 하나의 정의된 Row들로 구성된 테이블이라면, Step Loop는 하나 이상의 Row를 확장하는 개념으로<br>
T-CODE:MB1A와 같은 트랜잭션에서 Input 필드들을 그룹으로 묶어서 LOOP를 수행하면서 처리할 수 있도록 한 것이다.<br>
테입르 컨트롤이 Step Loop보다 장점이 많아서 주로 사용된다.<br>

현재 실무에서는 ALV가 등장하면서 테이블 컨트롤보다 ALV가 많이 사용되고 있다.
<br>

&emsp;**• 테이블 컨트롤의 LINE은 Keywords, Input/Output필드, Radio Button, Checkbox, Radio Button Group, 그리고 Push Button을 포함할 수 있다.**
&emsp;**• LINE은 255칼럼까지 지정할 수 있다.** <br>

&emsp;***TIP) T-CODE:BIBS에서 테이블 컨트롤을 선택해서 소스를 분석해보는것도 좋은 습관이다.***
