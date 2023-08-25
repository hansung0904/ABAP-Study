# SAP Adobe Form

T-CODE : SFP

SAP Adobe Form이란? 
증명서 출력, 그 외 양식들 만들 수 있게끔 해주는 것

인터페이스는 양식을 뿌려줄 구조, 데이터를 뿌려 주는걸 넣는 곳

인터페이스부터 만들어야함.
import 는 양식을 호출하기 위해서 기준되는 키값들을  fp_job_open을 먼저 넣고
양식 이름 넣고 어떤 폼 형식을 호출할것인지..

임포트에 받을 키값들을 선언해주고
global data = 양식쪽에 뿌려줄 데이터들 집합 (선언해주고)

code initialization에 데이터 조회하는 로직 짜주고

그러고 폼을 만들때 

처음엔 백지임

master page랑 page 만 보일거임 
안에는 내용들도 하나도 없을거임

page type을 A4나 이런걸로 바꾸고

그 아래 하위 페이지에 필드들을 선언해줄건데

object library에 버튼 체크박스 데이트 필드 등등 많음
실무에서 자주쓰이는건 테이블 텍스트 텍스트필드

floating field로 데이터 선언해서 데이터 바인딩 시켜서 가져올 수 있음 {} 생긴애들

img 파일들은 T-cod se78


