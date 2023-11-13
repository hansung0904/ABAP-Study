# BDC vs BAPI

BDC(Batch Data Communication) : SAP 시스템으로 대용량 데이터를 전송할 수 있는 기술. <br>

BAPI(Business Application Programming Interfaces) : 다른 개발사가 제공해 주는 외부 Interface <br>
쉽게 이야기하자면 예를 들어 우리가 로그인 할 떄 카카오톡 로그인, 구글 로그인, 페이스북 로그인 등 이런 기능들을 사용할 수 있게 하는 것이 API인데 그것을 business-API라고 생각하면 된다.

간략하게 정리를 한다면

***BDC = Standard,CBO 둘 다 가능 <br>***
***BAPI = Standard만 가능.***

|BDC|BAPI|
|------|---|
|BDC는 BAPI보다 느리다.|BAPI는 BDC보다 빠르다.|
|BDC는 일반 사용자처럼 모든 화면을 진행하므로 속도가 느리다.|BAPI는 데이터베이스에 직접 업데이트를 하기 때문에 빠르다.|
|BDC는 백그라운드 처리 옵션을 사용할 수 있으므로 대용량 데이터 업로드에 선호된다.|BAPI는 일반적으로 소규모 데이터 업로드에 사용된다.|
|세션 방식의 경우 SM35, Call Transaction 방식의 프로그램에서 오류를 처리 할 수 있다.|오류를 처리하려면 BAPI에 대한 Exception 매개변수를 사용해야한다.|

BDC 단점
1. T-CODE(SM35)에서 레코딩을 해야하기 때문의 약간의 노가다성 개발이 필요할수 도 있다.
2. 관련이 없는 데이터도 화면에 나오기 때문에 속도가 저하된다.

BAPI 단점
1. parameter가 많기 때문에 적절한 예제를 찾기가 힘들다.
2. 오류를 찾기가 힘들다.