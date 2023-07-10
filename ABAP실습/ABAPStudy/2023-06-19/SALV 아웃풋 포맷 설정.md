# SALV 아웃풋 포맷 설정
SALV의 기본적인 이론과 함께 3가지 유형의 리스트 프로그램을 실습했다. <BR>
이번 절에서는 SALV의 서브클래스를 호출해서 리스트의 아웃풋 형태를 변경하는 방법에 대해서 학습해보자.

## SALV와 서브 클래스
표준으로 제공하는 SALV의 포맷 이외에 사용자 위주의 설정을 하려면 Main 클래스인 CL_SALV_TABLE과 관계된 <BR> 서브클래스들에 대해서 알고 있어야 한다.
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/SALV%EC%9D%98%20%EC%84%9C%EB%B8%8C%ED%81%B4%EB%9E%98%EC%8A%A4.png) <br>
SALV에서는 클래스 간의 다이어그램 구성이 가능 해졌으며, 이러한 구조를 ALV Object Model이라는 개념으로 소개하고 있다.

GRID를 이용한 ALV에서 레이아웃을 설정하려면 LVC_S_LAYO 타입의 변수를 선언하고 ALV를 호출하는 메서드의 파라미터로 값을 전달했다. <br>
그러나 SALV에서는 ALV Table 이외의 부가적인 설정 사항들은 개별 오브젝트로 제공하고 있다.

Main 클래스인 CL_SALV_TABLE과 서브클래스들을 연결하려면 'GET*'으로 시작하는 이름의 메서드를 이용해서 개별 클래스들을 SALV에 탑재하려면 각각의 메서드르 이용하게 된다. <br>

정리하면 SALV의 Main 클래스에 서브클래스를 연결하려면 이 순서대로 진행된다. <br>
① 서브 클래스의 객체 참조 변수 선언<br>
```abap
DATA gr_display TYPE REF TO cl_salv_display_settings
```
② 서클래스 타입에 해당하는 Main 클래스의 메서드 호출<br>
```abap
gr_display = gr_table->get_display_settings().
```
③ 서브 클래스의 메서드를 이용해서 세부 사항 설정<br>
```abap
gfr_display->set_striped_pattern(value = 'X').
```

## 칼럼 속성 변경
SALV의 특정 칼럼 속성을 변경할텐데 SALV에서 개별 칼럼의 속성에 접근해서 변경하려면 두 개의 서브클래스를 이용해야 한다. <BR>
ALV Object Model을 아래 그림에서 설명한다.
![](https://raw.githubusercontent.com/hansung0904/ABAP-Study/main/EasyABAPCapture/SALV%20%EA%B0%9C%EB%B3%84%20%EC%B9%BC%EB%9F%BC%20%EC%A0%91%EA%B7%BC%20%EB%B0%A9%EB%B2%95.png)

칼럼 속성을 설정하려면 다음 순서대로 작업한다.<br>
① CL_SALV_COLUMNS_TABLE을 참고하는 GR_COLUMNS 객체 참조 변수 선언<br>
② GR_TABLE의 GET_COLUMNS 메서드를 이용해서 SALV의 모든 칼럼에 대한 정보를 전달<br>
③ CL_SALV_COLUMN_TABLE을 참고하는 GR_COLUMN 객체 참조 변수를 선언<br>
④ GR_COLUMNS의 GET_COLUMN 메서드를 이용해서 개별 칼럼에 접근<br>
⑤ GR_COLUMN의 메서드를 이용해서 개별 칼럼의 속성을 변경

## SALV 선택모드
SALV 리스트를 조회한 다음 사용자가 여러 행(Row)을 선택하거나 개별 셀을 선택할 수 있는 타입을 설정할 수 있다.<br>
이것은 CL_SALV_SELECTIONS 클래스의 SET_SELECTION_MODE 메서드를 이용해서 구현한다.<br>
메서드 호출시 사용되는 파라미터는 TYPE I 유형이며 <br>
IF_SALV_C_SELECTION_MODE의 상수값을 사용할 수 있다.