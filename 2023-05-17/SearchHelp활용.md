# Search Help 활용
<img src = "https://help.sap.com/saphelp_scm70/helpdata/ru/cf/21ee93446011d189700000e8322d00/Image342.gif"><br>
그림과 같이 Search HElp는 3가지 방법으로 필드에 추가될 수 있다.<br>
앞 commit에서 공부했지만 다시 한번 정리해보면..<br>

- **Date Element에 Search Help에 추가**<br>
- **Table Field에 Search Help 추가**<br>
- **Screen Field에 Search Help 추가**<br>

## 1 Data Element에 Search Help 추가
Data Element에 Search Help를 추가할 수 있다. <br>
Data Element의 속성을 상속받는 모든 스크린 필드에 Search Help가 자동으로 연결된다.

## 2 Table Field에 Search Help 추가
테이블 필드에 Search Help를 추가하면 테이블 필드를 참고하는 모든 스크린 필드에 Search Help가 연결된다. <br>
Search Help의 Export 파라미터가 테이블 필드에 할당되면 사용자가 리스트를 선택할 때 파라미터와 같은 이름의<br>
스크린 필드들에 값이 반환된다. <br>
또한, Import 파라미터가 테이블 필드에 할당되면, 스크린 필드에 입력된 값은 적중 리스트의 값을 제한하게 된다.

## 3 Screen Field에 Search Help 추가
Screen Painter를 이용해서 스크린 필드에 직접 Search Help를 할당할 수 있는데, 이 경우에는 해당 스크린 필드에만 Search Help가 작동한다.<br>
만약 이와 유사한 여러 개의 스크린에 Search Help를 사용하려면, 테이블 필드에 Search Help를 추가하고 스크린 필드는 테이블 속성을 참고하면 된다.

만약에 Search Help가 여러 가지 방법으로 중복 할당되었다면 어떤 Search Help를 호출하게 될까? <br>

다음과 같은 우선 우선 순위에 따라 Search Help를 호출하게 된다. <br>

① 스크린 필드에 추가된 Search Help<br>
② 테이블 필드에 추가된 SEarch Help<br>
③ Check 테이블의 Input Help<br>
④ Data Element에 추가된 Search Help<br>
⑤ Domain의 Fixed Value<br>
⑥ Time 또는 Calendar Help(예, 날짜 타입-DAT 필드)<br>