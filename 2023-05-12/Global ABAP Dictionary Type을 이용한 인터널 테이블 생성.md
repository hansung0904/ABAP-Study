# 4.2 Global ABAP Dictionary Type을 이용한 인터널 테이블 생성

ABAP Dictionary 테이블이나 구조체를 참고해서 인터널 테이블을 생성하는 방법

```ABAP
DATA: itab Type <t_itab> WITH [{UNIQUE|NON-UNIQUE} KEy <keys>]
                        [INITIAL SIZE <n>] [WITH HEADER LINE.]
```
<br>

위 두 가지 방법 외에도 ABAP Dictionary Table Type을 이용해서 인터널 테이블을 생성할 수 있는데 다음 Commit때 <br>다루어 보도록 하자