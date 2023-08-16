# Subroutine 개념
Subroutine은 FORM으로 시작해서 END FORm으로 종료되는 구문을 의미한다. 코드의 모듈와(modularization), 구조화, 재사용이 주목적이다. <br>
즉, Subroutine은 의미 있는 기능별로 프로그램을 구조화함으로써 전체적인 코드 흐름을 파악하는데 도움이 되며 <br>
시스템 유지보수의 편의성을 증진하는 장점이 있다. <br>
PERFORM 구문과 변수, 인터널 테이블 등의 팔마ㅣ터 값을 주고받는 Function Module이 Subroutine에 해당한다.

# PERFORM 구문
프로그램을 생성하고 PERFORM 구문을 통해 Subroutine을 호출하면 FORM 구문이 실행된다.

## 구문 예시
간단하게 텍스트를 출력하는 PERFORM 구문을 실습해보자

```abap
REPORT Z01_01.

PERFORM WRITE_DATA

FORM WRITE_DATA.
    WRITE 'Welcome to SAP'
ENDFORM.    
```

## 구문 작성 절차
PERFORM 구문 작성 절차는 다음과 같다.

Step 1. PERFORM 구문 작성 <br>
Subroutine으로 사용할 구문은 '동사_목적어' 네이밍 룰을 지켜서 작성한다. <br>
아래와 같이 데이터를 출력(Write)하는 구문은 'write_data'와 같이 이름을 지어서 직관적으로 쓰임새를 알아볼 수 있도록 한다. <br>

Step 2. Subroutine 생성
FORM 구문을 생성하는 방법은 2가지인데 <br>
첫째, 직접 스크립트를 입력하는 방법 <br>
둘째, GUI기반 생성방법이 있다.<br>

구문 이름에 마우스 커서를 올리고 마우스 왼쪽 버튼 더블클릭 <br>
해당 구문은 현재 Subroutine으로 존재하지 않고 있기 때문에 객체로 만들 것인지 묻는 팝업창이 뜸 <br>
Yes 클릭

Step 3. Include 프로그램 선택 <br>
INCLUDE 프로그램을 선택하는 팝업창이 뜨게 되고, Subroutine이 소속되어 있는 Main Program을 선택하고 우측 하단에 체크 버튼 클릭.

Step 4. 스크립트 추가 
생성된 FORM~ENDFORM 구문 사이에 실행할 스크립트를 작성한다.

```abap
FORM WRITE_DATA.
    WRITE : 'WELCOME TO SAP'
ENDFORM.    
```

Step 5. 프로그램 활성화 및 실행 <br>
프로그램을 활성화 하고 실행하면 데이터가 출력되는 것을 확인할 수 있다.
