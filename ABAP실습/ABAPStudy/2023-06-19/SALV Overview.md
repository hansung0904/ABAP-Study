# SALV Overview
넷 위버 플랫폼에서는 함수와 GRID를 이용한 ALV 기능을 통합해서 SALV라는 패키지 프로그램이 배포되었다. <br>
SALV는 함수를 이용해서 ALV를 생성하는 것과 같이 스크린 생성 없이 전체 모드로 ALV를 호출할 수도 있으며,<br>
컨터에너를 이용해서 스크린 내의 컨트롤에서 ALV를 조회할 수도 있다. GRID를 이용한 ALV는 Batch Job으로 등록해서 백그라운드 모드에서는 실행할 수 없지만, SALV는 문제없이 동작한다.<br>
SALV는 기존의 방식에 비해 개발이 편리하도록 세부 기능 등을 통합해서 인터페이스로 제공하고 있다.

그러나 SALV는 데이터를 수정할 수 있는 EDIT 모드는 지원하지 않는다는 단점이 있다.<br>

• CL_SALV_TABLE : 일반적인 ALV 리스트 타입 <BR>
• CL_SALV_HIERSEQ_TABLE : 계층 구조로 조회되는 리스트 타입<BR>
• CL_SALV_TREE : 트리 구조의 리스트 타입 <BR>
