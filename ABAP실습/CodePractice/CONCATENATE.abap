*&---------------------------------------------------------------------*
*& Report ZPRACTICE_CHS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpractice_chs.

* CONCATENATE PRACTICE

DATA: t1 type c LENGTH 10 VALUE '안',
      t2 type c LENGTH 10 VALUE '녕',
      t3 type c LENGTH 10 VALUE '하',
      t4 type c LENGTH 10 VALUE '세',
      t5 type c LENGTH 10 VALUE '요'.

CONCATENATE t1 t2 t3 t4 t5 into data(lv_result). "변수 t1,t2,t3,t4,t5를 사용해서 연결
write:/ '1) ', lv_result.

CONCATENATE t1 t2 t3 t4 t5 into lv_result SEPARATED BY space. "space 대신 '1'을 넣게 되면 안1녕1하1세1요 출력.
write:/ '2) ', lv_result.

CONCATENATE t1 t2 t3 t4 t5 into lv_result RESPECTING BLANKS. " RESPECTING BLANCKS를 통해서 변수모다 공백을 주었음 ->
                                                             " 영어 그대로 공백을 존중하겠다라는 의미
write:/ '3) ', lv_result. 