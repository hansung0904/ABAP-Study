# SELECT-OPTIONS
PARAMETERS가 하나의 값만 입력받을 수 있는 INPUT 필드인 반면에 SELECT-OPTIONS는 2개의 INPUT 필드를 통해 다양한 조건 값<br>
을 입력받을 수 있다. RANGE 변수와 같은 구조를 가지고 있다. <br>
SELECT-OPTIONS는 FOR 구문과 항상 병행해야한다.<br>
이때 FOR 구문 다음에 올 수 있는 값은 TABLES로 선언된 테이블 필드명이나 <br>
DATA로 선언된 변수이어야 한다.<br>

| 구문                                    | 발생                                                                                                                                             |
|---------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| DEFAULT g                             | 기본값 세팅                                                                                                                                         |
| DEFAULT g ... OPTION OP... <br>SIGN s | OPTION과 SING을 지정 <BR> OPTION: EQ(같다), BT(사이 값), NB(사이값 제외), GE(이상), LE(이하) <BR> GT(초과), LT(미만), NE(같지 않다) <BR> SIGN:Inclusive(I), Exclusive(E) |
| DEFAULT g TO h                        | SELECT-OPTION의 LOW 값에서 HIGH 값을 지정 구간 값(between)을 지정한다.                                                                                         |
| DEFAULT g TO h... OPTION op .. SIGN s | 앞의 두 구문을 조합한 것으로 OPTION은 BT와 NB만 가능하다.                                                                                                         |
| MEMORY ID pid                         | MEMORY 파라미터 지정                                                                                                                                 |
| MATCHCODE OBJECT mobJ                 | 4.0 이후 버전은 SEARCH HELP를 사용한다. mobj에 Search Help명을 <br> 입력하게 되면 Possible Entry가 할당된다.                                                           |
| NO-DISPLAY                            | 화면에 보이지 않는다.                                                                                                                                   |
| LOWER CASE                            | 대소문자를 구별한다.                                                                                                                                    |
| OBLIGATORY                            | 필수 필드로 지정한다. 화면 필드에는 물음표가 표시된다.                                                                                                                |
| NO-EXTENSION                          | 버튼을 제거한다.                                                                                                                                      |
| NO INTERVALS                          | HIGH 값을 제거한다.                                                                                                                                  |
| VISIBLE LENGTH vlen                   | 필드의 일부 길이까지만 화면에 보이게 설정한다.                                                                                                                     |
| NO DATABASE SELECTION                 | LDB에 사용되는 옵션으로 일반 리포트에서는 아무런 기능을 수행하지 않는다.                                                                                                     |
| VALUE-REQUEST                         | LDB(DBIdbSEL include)에서 F4 VALUE HELP를 추가할 수 있도록함                                                                                              |
| HELP-REQUEST                          | VALUE-REQUEST와 유사하며, 필드 HELP를 생성한다.                                                                                                            |


