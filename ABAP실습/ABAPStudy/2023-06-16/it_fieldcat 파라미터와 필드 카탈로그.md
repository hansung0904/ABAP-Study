# it_fieldcat 파라미터와 필드 카탈로그
필드 카탈로그는 ALV에서 조회되는 칼럼들의 필드 정보를 포함하는 slit_t_fieldcat_alv 타입의 테이블 구조를 가진다.<br>
ALV는 필드 카탈로그 정보를 저장하는 인터널 테이블을 이용해 필드 타입을 인식하게 된다.<br>
예를 들어서, 필드가 숫자 타입인지 문자 타입인지 구분하며 화면에 보여줄 필드 길이를 지정할 수 있다.<br>
그리고 체크박스, 라디오 버튼으로 보이게 하고, 필드 수정이 가능하게 하는 등 많은 역할을 하게 된다.

앞의 예제에서는 ABAP Dictionary 테이블을 이용해서 ALV 구조를 만들어 냈다. <br>
그러나 소스 레벨에서 직접 필드 카탈로그를 구성해서 ALV 구조를 만들어낼 수 있따.<br>
이때는 다음과 같이 파라미터를 사용하는 방법이 달라진다.

ABAP Dictionary를 이용한 ALV
```ABAP
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
EXPORTING
    i_structure_name = 'SFLIGHT'
TABLES
    t_outtab         =  gt_itab.    
```

필드 카탈로그를 이용한 ALV
```ABAP
CALL FUNCTION 'REUSE_ALV_GIRD_DISPLAY'
EXPORTING
    it_fieldcat     =   gt_fieldcat
TABLES
    t_outtba        =   gt_itab.    
```

GRID를 이용한 ALV와 같이 필드 카탈로그를 정의하는 방법은 3가지가 있다.

**• ABAP Dictionary 오브젝트를 이용하는 방법<br>**
**• 프로그램 내에서 스크립트로(수동으로) 구성하는 방법 - 필드 카탈로그<br>**
**• 위 두 가지 방법을 혼합해서 사용하는 방법<br>**

ABAP Dictionary 오브젝트(구조체, 테이블)와 필드 카탈로그 두 가지를 혼합해서 사용할 수 있다.<br>
구조체의 필드 이외에 사용자가 정의하는 필드가 추가로 필요한 경우, 필드 카탈로그를 사용하면 된다.<br>
이때 구조체와 필드 카탈로그에 같은 필드가 존재하게 되면, 필드 카탈로그에서 정의한 필드가 높은 우선순위를 가지게 된다.

① 필드 카탈로그 인터널 테이블과 구조체를 각각 선언
```ABAP
REPORT Z16 05.

TYPE-POOLS : slis

DATA gt_fieldcat        TYPE    slis_t_fieldcat_alv.
DATA gs_fieldcat        TYPE    slis_fieldcat_alv.
```

② 필드 카탈로그에 CARRID, CONNID 필드 2개 추가
```ABAP
CLEAR : gs_fieldcat, gt_fieldcat.
gs_fieldcat-col_pos = 1.
gs_fieldcat-fieldname = 'CARRID'.
gs_fieldcat-seltext_m = 'Airline Code'.
APPEND gs_fieldcat TO gt_fieldcat.

CLEAR : gs_fieldcat.
gs_fieldcat-col_pos = 2.
gs_fieldcat-fieldname = 'CONNID'
gs_fieldcat-seltext_m = 'Connection Number'
APPEND gs_fieldcat TO gt_fieldcat.
```

③ ALV 함수 호출 시 필드 카탈로그 파라미터를 이용하도록 스크립트 추가, 기존 테이블을 이용하는 라인은 주석 처리
```ABAP
CALL FUNCTION 'REUSE_ALV_GIRD_DISPLAY'
    EXPORTING
        i_callback_program      =       sy-repid
        it_events               =       gt_events
    *   i_structure_name        =       'SFLIGHT'
        it_fieldcat             =       gt_fieldcat
        i_callback_user_command =       'ALV_USER_COMMAND'
    TABLES
        t_outtab                =       gt_itab.    
```