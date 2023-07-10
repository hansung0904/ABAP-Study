# Search Help Overview
Input Help는 화면 필드에서 사용자가 입력할 수 있는 값을 조회하는 SAP 표준 기능이다.<br>
Input Field를 생성하거나 조회하는 방법은 3가지가 있다.<br>

- ABAP Dictionary Search Help를 이용한 Input Help <br>
T-CODE:SE11에서 Search Help를 생성해서 테이블 필드에 할당한다.<br>
그리고 스크린 필드는 테이블 필드의 속성을 상속받아 Input Help로 사용할 수 있다. <br>
테이블 필드에 Search Help가 존재하지 않는다면 Check Table의 데이터와 <br>
Domain의 Fixed Value가 Input help에 연결된다. <br>
그리고 Static input help라고 부르는 DATS와 TIMES 타입은 달력과 시간 구조로 정의되어 있는 Input Help를 이용한다.
- 스크린을 이용한 Input Help <br>
스크린 페인터에서 개별 필드에 직접 Input Help를 할당하거나, 스크린의 PAI 이벤트에서 입력 값을 제한할 수 있다.
다음 구문은 empno 필드에 '00001', '00002' 이외의 값은 입력되지 않도록 제한한다.
```ABAP
FIELD empno VALUES ('00001', '00002').
```
다음 구문은 테이블 데이터를 이용해서 값을 제한한다.
```ABAP
FIELD <f> SELECT * FROM <dbtab>
```

- Dialog Module에서의 Input Help <br>
 사용자가 Screen 필드에서 f4 키를 입력할 때 POV 이벤트에서 Dialog 모듈을 호출함으로써 Input Help를 화면에 보여줄 수 있다.

***Input Help와 Search Help는 같은 것이 아니다.*** <br><br>
Input Help에 주로 사용되는 것이 이번 ㅈ아에서 중점적으로 살펴보게 되는 Search Help 오브젝트이다. <br>
Search Help는 탐색 도움말로서 ABAP Dictionary 오브젝트이다.<br>
Search Help의 예전 이름은 MATCHCODE 라고 불리었는데, <br><br>
다음 구문을 이용해서 Search Help를 PARAMETERS에 연결한다.
```ABAP
PARAMETER <param> MATCHCODE OBJECT <search help>
```

Search Help는 사용자가 화면 필드에 값을 입력하고자 할 때 입력 가능한 값의 List를 보여주는 기능을 한다. <br>
Possible Value를 찾기 위한 여러 가지 필드의 선택 조건을 주고 사용자가 입력한 조건을 참고해서 결과값만을 보여준다. <br>
이 때 F4 키를 누르면 입력 가능한 Dialog Box에 조회된다.<br><br> Search Help는 다음 두 가지 타입으로 분류된다. <br><br>
**Elementary Search Help** <br>
- 기본 탐색 도움말
- 하나의 Tab으로 구성됨
- Selection Method의 데이터 활용

**Collective Search Help** <br>
- 일괄 탐색 도움말
- 여러 개의 Tab으로 구성됨
- Elementary Search Help의 조합으로 구성

화면 필드에 Search Help를 추가하는 방법은 크게 3가지
- **Data Element 에 Search Help 추가** <br>
- **Table Field에 Search Help 추가** <br>
- **Screen Field에 Search Help 추가** <br>