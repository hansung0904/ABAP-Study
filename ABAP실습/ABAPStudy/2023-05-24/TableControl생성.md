# Table Control 생성
&emsp; 모듈 풀 프로그램에서 테이블 컨트롤을 추가하려면 다음과 같은 순서로 진행해야 한다. <br>

&emsp; ① 테이블 컨트롤 영역을 정의한다. <br>
&emsp; ② 테이블 컨트롤 구성 요소를 선언한다.<br>
&emsp; ③ 테이블 컨트롤의 Title을 추가한다.(선택 사항).<br>
&emsp; ④ Module Pool 프로그램 내에서 테이블 컨트롤을 선언한다.<br>

# Table Control 스크립트 구현(LOOP)
테이블 컨트롤을 사용하려면 PBO와 PAI 모듈에 LOOP 구문을 추가해야 한다. <br> 
이것은 LOOP 구문을 수행하며, ABAP 프로그램 필드와 스크린 필드의 데이터가 연결되도록 한다. (row by row로 복사된다.)

PBO 구문의 LOOP 구문은 ABAP 프로그램 필드 데이터가 스크린 필드(테이블 컨트롤)에<br>
조회되게 하고, PAI 구문의 LOOP 구문은 스크린 필드(테이블 컨트롤)의 데이터가 ABAP 프로그램 데이터에 복사되게 한다.<br>
에러를 피하려면 PBO/PAI에 내용이 없는 LOOP 구문이라도 추가해주어야한다.<br>
그리고 프로그램을 실행하면 데이터가 없는 테이블 컨트롤이 조회된 것을 확인하게 된다.

[PBO]
```ABAP
LOOP [WITH CONTROL zemp_con].
ENDLOOP.
```

[PAI]
```ABAP
LOOP [WITH CONTROL zemp_con].
ENDLOOP.
```

# Table Control 스크립트 구현(LOOP AT)
테이블 컨트롤에서 LOOP 구문을 수행하는 방법은 스크린을 이용하는 방법과 인터널 테이블 이용하는 방법 두 가지가 있다.
```ABAP
LOOP [WITH CONTROL zemp_con].
END LOOP.
```
스크린 필드와 ABAP 프로그램 영역 상호 간에 데이터를 line by line 형태로 복사한다.

```ABAP
LOOP AT <인터널 테이블>.
ENDLOOP.
```
스크린 필드와 ABAP 프로그램 영역 상호 간에 데이터를 병행(in Parallel)해서 수행한다.