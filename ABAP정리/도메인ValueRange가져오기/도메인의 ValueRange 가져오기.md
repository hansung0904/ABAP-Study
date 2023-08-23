# 도메인의 Value Range 가져오기

도메인의 Value Range를 가져오는 방법에는 여러가지가 존재한다 <br>
```abap

*--> 1

CALL METHOD CL_RECA_DDIC_DOMA=>GET_VALUES
    EXPORTING
        ID_NAME = 'ZBLIN'
    IMPORTING
        ET_VALUES = LT_I04
    EXCEPTIONS
        NOT_FOUND = 1
        OTEHRS = 2.

LT_I04 도메인의 fixed value와 text를 받는다.

*--> 2
CL_MEV_UTILITY=>GET_DOMAIN_VALUES(IV_DOMNAME = '도메인이름' IV_VALUE = '필드에 넣어줄 값').
이 클래스를 선언한 변수에 넣어주면된다.

*--> 3
SELECT SQL 구문으로 값을 가져올수도 있다.

```
