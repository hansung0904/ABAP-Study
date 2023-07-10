# 프로그램 구조(선언)
Report 프로그램은 다음과 같이 크게 3가지 구조로 분류 가능<br>
① 데이터 선언부와 조회 선택 화면(SELECTION SCREEN)<br>
② 실행 시점까지의 Event<br>
③ 데이터를 뿌려주는 List Event<br>

조금 뒤에는 데이터 선언부와 SELECTION SCREEN에 대해서 공부해보자.

## 프로그램 선언문
프로그램의 선언하는 구문에는 REPORT <프로그램 이름>의 기본 구조에 추가 옵션들이 존재한다.<br><br>**1) 프로그램 LIST Heading 지정** <br>
프로그램을 실행한 리스트 화면에 프로그램 이름을 기본 Heading으로 사용할지 결정하게 된다. <br>
다음 구문을 기술하면 기본 Heading을 삭제하게 된다.
```ABAP
REPORT Z12_02 NO STANDARD PAGE HEADING.
WRITE 'List Heading Test'.
```
<br>**2) Line-Size**
Output List의 넓이를 지정한다 .<br>
넓이를 0으로 설정하거나, LINE-SIZE 구문을 삭제하면 표준길이를 사용하게된다.
```ABAP
REPORT Z12_03 LINE-SIZE 30.

WRITE 1 Line Size Test' .
```
<br>**3) Message ID**
ABAP 프로그램에서 사용할 MESSAGE ID를 선언한다.
```ABAP
REPORT Z12_04 MESSAGE-ID <message-id>.
```