# Function ALV 자세히 알아보기
Function ALV에서 사용되는 ***'REUSE_ALV_GRID_DISPLAY' 함수는 가장 기본적이고 중요한 메서드*** <br>
메서드를 호출할 땐 ABAP Dictionary의 구조를 참고하거나 필드 카탈로그를 정의해야 한다. <br>
전자는 앞에 예에서 EXPORTING I_STRUCTURE_NAME = 'SFLIGHT'와 같이 SFLIGHT 테이블과 같은 구조를 참고하는 것을 의미.<br>
후자는 직접 ALV의 필드들을 스크립트를 이용해 하나하나 구성하는 것을 의미 <br>

그리고 'REUSE_ALV_GRID_DISPLAY' 함수를 호출 할 때 다음 구문과 같은 파라미터를 이용해서, 프로그램을 실행하기 이전에 테이블을 정렬하거나 <br>
필터링하는 기능들을 사용할 수 있다.

```ABAP
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
EXPORTING
    I_CALLBACK_PROGRAM                  ALV 함수를 호출하고 반환할 프로그램
    I_CALLBACK_PF_STATUS_SET            ALV 프로그램 내의 STATUS 설정
    I_CALLBACK_USER_COMMAND             ALV 프로그램의 버튼 기능구현, FORM 구문 명
    I_STRUCTURE_NAME                    ALV 구조 설정: 구조체, 테이블
    I_GRID_TITLE                        ALV GRID의 헤더 타이틀
    I_GRID_SETTINGS                     ALV GRID 설정(편집 시 즉시 이벤트 호출 등)
    IS_LAYOUT                           ALV의 레이아웃 설정
    IT_FIELDCAT                         ALV의 구성 항목인 칼럼(필드 카탈로그) 설정
    IT_EXCLUDING                        ALV 기본 버튼 제거 항목
    IT_SORT                             ALV 조회 시 기본 SORT 칼럼 설정
    IT_FILTER                           ALV 조회 시 필터 설정
    I_SAVE                              ALV 레이아웃 저장 시 옵션
    IS_VARIANT                          ALV 레이아웃을 저장하고 호출하도록 설정
    IT_EVENTS                           ALV의 이벤트 정의
TABLES
    T_OUTTAB                            ALV에 출력될 데이터 영역(인터널 테이블)
```