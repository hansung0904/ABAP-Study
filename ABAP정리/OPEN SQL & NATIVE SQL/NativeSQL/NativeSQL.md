# Native SQL
OPEN SQL은 데이터베이스의 종류(ORACLE 등)에 상관없이 ABAP Dictionary에서 선언한 모든 오브젝트를 조회할 수 있다. <br>
NATIVE SQL은 데이터베이스 종류에 따라 사용할 수 있는 SQL 구문이 다르다. <BR>
**지금 공부하는 NATIVE SQL은 Oracle 데이터베이스 이므로, MS SQL과 같은 다른 데이터베이스가 설치된 경우에는 정상적으로 실행되지 않는다.**<BR>

ABAP 프로그램에서 NATIVE SQL은 OPEN SQL에 비해 자주 사용되지는 않지만, OPEN SQL에서 지원하지 않는 다양하고 복잡한 SQL을 사용할 수 있다. <BR>

**장점** <BR>
ABAP Dictionary에 생성되지 않은 테이블에 접근할 수 있다.(Oracle의 시스템 테이블 등). <br>
데이터베이스에 의존적인 SQL 구문이므로 OPEN SQL에서는 구현할 수 없는 정밀한 SQL이 가능하다.

**단점** <BR>
EXEC ~ ENDEXEC 사이의 구문 점검(Syntax Check)이 수행되지 않으므로 Dump Error가 발생할 수 있다. <br>
NATIVE SQL이 포함된 ABAP 프로그램은 다른 DB를 사용하는 환경에는 적용할 수 없다. <BR>
Client를 구분하는 MANDT 필드를 SQL 구문 내에 반드시 포함해야 한다.

## 1 기본 구문
NATIVE SQL은 DB 종류에 따라 사용할 수 있는 SQL 구문이 다르다. <BR>
기본 구문은 EXEC SQL로 시작해서 ENDEXEC.로 종료한다. <BR>
그리고 변수명 앞에는 콜론(:) 기호를 반드시 추가해야 한다. <BR>
그리고 NATIVE SQL에는 클라이언트 구분자인 MANDT 필드를 반드시 기술해야 한다.

```ABAP
EXEC SQL.
    <NATIVE SQL statement>
ENDEXEC.    
```

```ABAP
REPORT NATIVESQL_01

DATA :  GV_CARRID    LIKE    SFLIGHT-CARRID  VALUE 'AA'.
        GV_CONNID    LIKE    SFLIGHT-CONNID.S

EXEC SQL.
    SELECT A.CONNID
        INTO :GV_CONNID
        FROM SFLIGHT A
       WHERE A.MANDT = :SY-MANDT
        AND A.CARRID = :GV_CARRID
ENDEXEC.

WRITE GV_CONNID.
```