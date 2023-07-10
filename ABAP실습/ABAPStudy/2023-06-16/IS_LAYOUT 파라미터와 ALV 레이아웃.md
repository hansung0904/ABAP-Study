# IS_LAYOUT 파라미터와 ALV 레이아웃
IS_LAYOUT 파라미터를 이용해서 합계 금액을 보여주거나 줄무늬 패턴으로 조회되도록 하는 등 ALV 화면 속성을 정의한다. <br>

자주 사용하는 ALV 레이아웃 개별 속성이다.
|필드|설명|목적|
|------|---|---|
|NO_COLHEAD|ALV 칼럼 헤더를 조회되지 않게 한다.|ALV 속성|
|ZEBRA|라인 단위별로 줄무늬 패턴 형성|색상|
|NO_VLINE|Grid의 수직선을 보이지 않는다.|ALV 속성|
|NO_HLINE|Grid의 수평선을 보이지 않는다.|ALV 속성|
|EDIT|편집 모드|GRID에만 사용|
|NUMC_SUM|NUMC 필드의 합산 기능 옵션|합계 옵션|
|NO_INPUT|필드 카탈로그 INPUT으로 설정된 모든 필드 <BR> 입력 불가 설정|LIST ALV만 사용|
|NO_KEYFIX|Key 필드도 스크롤 사용할 수 있도록 설정|ALV 속성|
|DEF_STATUS|ALV 디폴트 STATUS 설정|PF_STATUS|
|COLWIDTH_OPTIMIZE|데이터 길이만큼 칼럼 길이를 지정한다.|ALV 속성|
|LIGHTS_FIELDNAME|예외 사항 필드 설정|ALV 속성|
|NO_SUBTOTALS|Subtotal 불가|Total 옵션|
|TOTALS_BEFOR_ITEM|합계 금액을 맨 위의 라인에 보여준다.|LIST ALV만 사용|
|BOX_FIELDNAME|Checkbox로 사용할 필드 이름 설정|LIST ALV만 사용|
|KEY_HOTSPOT|Key 필드는 hotspot으로 설정|ALV 속성|
|CONFIRMATION_PROMPT|ALV 리스트를 빠져나갈 때 확인 팝업창 오픈|추가 기능|