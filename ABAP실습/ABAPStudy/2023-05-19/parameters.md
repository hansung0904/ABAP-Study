# PARAMETERS

PARAMETERS는 사용자가 값을 입력하도록 Input 필드를 정의한다. <br>
다음 구문을 사용하여 변수를 선언한다. <br>
Data Type F는 SELECTION SCREEN에서 지원되지 않으므로<br>
파라미터로 선언될 수 없다.

```ABAP
PARAMETERS <p> [(<length>)] <type> [<decimals>].
```

PARAMETERS 변수와 같이 TYPE을 정의하지 않으면 기본 CHAR 1자리 TYPE이 정의된다. <br>
PARAMETERS에 입력된 값은 데이터를 조회하는 SELECT 구문의 조건 등에 사용된다.<br>
파라미터는 1개의 값만 입력받을 수 있으며, 체크박스로 보이는 것과 같은 옵션을 추가할 수 있다.<br>

| 구문                    | 발생                                                                               |
|-----------------------|----------------------------------------------------------------------------------|
| DEFAULT 'A',          | 기본 값 세팅                                                                          |
| TYPE CHAR10.          | Data Type 정의                                                                     |
| LENGTH N,             | TYPE C, N X or P에만 적용되며, 길이를 정함                                                  |
| DECIMALS dec          | 소수점 자리를 지정한다.                                                                    |
| LIKE g                | 오브젝트와 같은 데이터 타입 선언                                                               |
| MEMORY ID pid         | 메모리 파라미터 할당                                                                      |
| MATCHCODE OBJCEC mobj | 4.0 이후 버전은 Search Help를 사용 <BR> mobj에 Search Help 명을 입력하게 되면 Possible Entry가 생성됨 |
| MODIF ID modid        | screen-group을 지정해서, 그룹별로 화면 속성을 제어하기 위함                                          |
| NO-DISPLAY            | 화면에 보이지 않음                                                                       |
| LOWER CASE            | 대소문자 구별                                                                          |
| OBLIGATORY            | 필수 필드로 지정, 화면 필드에는 물음표가 표시                                                       |
| AS CHECKBOX           | CHECK BOX로 표현                                                                    |
| RADIBUTTON GROUP radi | 라디오 버튼으로 표현 <br> 두개 이상의 필드를 Radio Group으로 선언                                     |
| VISIBLE LENGTH vlen   | 필드의 일부 길이까지만 화면에 보이게 설정                                                          |
| VALUE CHECK           | 테이블의 필드 속성을 상속받아 Check Table 값을 체크할 수 있음 (외부 키)                                  |
| LIKE (g)              | 파라미터를 동적으로 선언할 수 있음. 실행 시에 g는 ABAP Dictionary에 존재하는 <br>오브젝트가 할당되어야 한다.          |
| AS LISTBOX            | ABAP Dictionary 필드의 INPUT HELP와 연결되면 LIST BOX로 보인다.                              |
| USER-COMMAND ucom     | 체크 박스와 라디오 버튼에만 작용. 라디오 버튼을 클릭하면 USER COMMAND 수행                                 |
| AS SEARCH PATTERN     | LDB에서 사용하며 SEARCH HELP의 키값으로 인터널 테이블 구성                                          |
| VALUE-REQUEST         | LDB에서 F4 VALUE HELP를 추가할 수 있도록 함                                                 |
| HELP-REQUEST          | VALUE-REQUEST와 유사하고, 필드 HELP를 생성함                                                |