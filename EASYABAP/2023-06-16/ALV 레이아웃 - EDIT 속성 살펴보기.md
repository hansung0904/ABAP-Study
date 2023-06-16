# ALV 레이아웃 - EDIT 속성 살펴보기
필드 카탈로그 레벨에서 필드 레벨로 EDIT 속성을 부여할 수도 있고, ALV 전체 레이아웃 레벨에서 EDIT 속성을 이용할 수도 있다. <br>
EDIT 속성은 ALV GRID에만 설저알 수 있다.
ALV LIST에서는 INPUT 속성을 활용한다.

```ABAP
gs_layout-zbra = 'X'.
gs_layout-confirmation_prompt = 'X'.
gs_layout-edit = 'X'.
```