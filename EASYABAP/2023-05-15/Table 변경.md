## Table 변경
테이블에 데이터가 존재할 때 필드 속성을 변경하면 데이터베이스 내에서 ALTER TABLE이 수행된다. 이때 변경된
오브젝트는 <br>
Active, Inactive 버전의 두 가지가 동시에 존재한다. <br>
Active 버전의 ABAP Dictionary 오브젝트들은 실행 환경의 프로그램에서 사용된다. <br>
Inactive 버전은 Active 버전이 변경되었을 때 생성되며, 구문 체크가 수행되지 않는다. <br>
그리고 현재 실행 중인 프로그램에 영향을 미치지 않는다. <br>
변경된 내용을 적용하기 위해 활성화(Activation)를 실행하면 TIMESTAMP가 변경되는데, 변경된 오브젝트와 관련된 프로그램이 실행되면 <br>
TIMESTAMP를 확인해서 최신 버전을 호출하게 된다. <br>
실질적으로 Conversion은 다음과 같이 임시 TABLE로 복사 생성하고 나서 데이터를 복사하는 과정을 거치게 된다.

**• 테이블에 잠금(Lock)을 설정한다.** <br>
**• Index를 삭제하고 테이블 이름을 변경한다 (QCM<tab_name>)** <br>
**• Inactive 버전의 테이블을 Active 버전으로 만들고 DB에 테이블을 재생성한다.** <br>
**• Rename 한 테이블의 데이터를 새로 생성한 테이블에 복사한다.** <br>
**• 테이블 잠금(Lock)을 해제한다.** <br>