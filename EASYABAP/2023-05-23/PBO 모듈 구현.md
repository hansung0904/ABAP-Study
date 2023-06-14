# PBO 모듈 구현

## PBO 모듈 구현 및 GUI STATUS 추가

PBO 모듈은 화면을 초기화거나 스크린 요소의 속성을 변경하는 작업을 주로 수행하게 된다. <br>

|     |                                   |
|-----|-----------------------------------|
| • T | 변수, 인터널 테이블 등을 그룹 지은 INCLUDE 프로그램 |
| • S | 파라미터 등을 한 그룹으로 모은 INCLUDE 프로그램    |
| • C | 클래스 오브젝트를 한 그룹으로 모은 INCLUDE 프로그램  |
| • F | PERFORM 구문을 그룹 지은 INCLUDE 프로그램    |
| • O | PBO 모듈 INCLUDE 프로그램               |
| • I | PAI 모듈 INCLUDE 프로그램               |

## PBO 모듈 구현 및 출력 전용 속성 변경

| 키워드        | 내역                                                                            |
|------------|-------------------------------------------------------------------------------|
| NAME       | 필드 이름(*,#,/,-,_,& 문자 가능)                                                      |
| TEXT       | 필드 텍스트                                                                        |
| Dropdown   | Input/Output 필드만 설정 가능                                                        |
| With Icon  | Output 필드만 설정 가능                                                              |
| Icon name  | Text 필드, Push 버튼, Radio 버튼, Check Box만 icon 설정 가능                             |
| Scrollable | Def.Length가 Vis.Length보다 클 때 스크롤 사용                                           |
| Line/Colum | 필드의 라인/칼럽 위치를 설정                                                              |
| Def.Length | 필드 속성의 길이를 설정                                                                 |
| Vis.Length | 스크린에 보이는 필드길이, Scrollable이 선택되어야 함                                            |
| Height     | 높이 설정. Text 및 entry element는 항상 1의 값을 가진다.                                    |
| Groups     | Modification Group, 여러 개 필드를 한번에 변경할 때 사용한다.                                  |
| FctCode    | Function Code 설정, Push 버튼과 Dropdown List가 설정된 <br> Input/Output 필드만 설정할 수 있다. |
| FctType    | Function Type을 설정한다.                                                          |
| ON_CTMENU  | Context 메뉴를 설정한다                                                              |