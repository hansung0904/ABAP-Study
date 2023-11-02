# CLOI_PUT_SIGN_IN_FRONT
SAP 에서는 -부호가 숫자뒤로 화면에 출력된다.

화면에 출력시 - 부호를 숫자 앞으로 이동하는 펑션이다.

Ex)
```abap
DATA:    lv_numc(2) TYPE c ,
         lv_num     TYPE i.
   
lv_num   = 1 - 2.
lv_numc = lv_num.

CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
  CHANGING
    value = lv_numc.

* <결과>
lv_num   =  1-
lv_numc  =  -1

* 참고
* 파라미터 value는 char type 으로 사용해야 하므로 숫자 필드를 char필드로 이동해서 사용해야한다.
```