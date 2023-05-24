# Subscreen 영역 정의
Subscreen 영역은 스크린 페인터에서 정의하게 되며, 각각의 Subscreen은 이름, 위치, 길이, 높이를 지정해야 한다. <br>
Subscreen 영역은 스크린의 다른 요소와 겹쳐져서는 안된다.<br>
최종 사용자가 윈도우의 크기를 조절할 때 Subscreen도 수직/수평으로 크기를 조절 할 수 있도록 설정할 수 있으며,<br>
사용자가 윈도우 크기를 조절할 때마다 PAI 이벤트가 호출된다.

## Include Subscreen
Subscreen을 메인 스크린에 추가하려면 PBO와 PAI 이벤트에 다음 구문을 추가해주자.
```ABAP
[PBO]
    CALL SUBSCREEN <area>
        INCLUDING <program> <dynp>.
```
```ABAP
[PAI]
    CALL SUBSCREEN <area>
```
PBO 이벤트에서 CALL SUBSCREEN 구문은 Subscreen의 PBO Flow Logic을 호출한다. <br>
메인 스크린의 CALL SUBSCREEN 구문 다음의 모듈은 Subscreen의 PBO 로직이 수행된 이후에 호출된다. <br>
Subscreen 영역에 추가되는 Subscreen은 실행 시점에만 알 수 있으므로 dynpro로 부른다.<br>

이와 마찬가지로 PAI 이벤트의 CALL SUBSCREEN 구문은 Subscreen의 PAI Flow Logic을 호출하게 된다.<br>
Subscreen 요소와 ABAP 프로그램의 필드가 같은 이름으로 존재한다면 데이터 복사가 자동으로 일어나게 된다.