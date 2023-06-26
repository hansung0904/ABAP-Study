* SUBROUTINE PRACTICE
* 서브루틴을 보고 뭔가 뭔지 또는 언제 VALUE문을 쓰고 안쓰는지에 대한 실습.
* USING : 값 던지기
* CHANGING : 값을 던져서 가져오기
* TABLES : USING + CHANGING

*--> Example Start
*--> USING 만 사용
DATA :
  lv_value1 TYPE n VALUE 5,
  lv_value2 TYPE n VALUE 5.

PERFORM xxx_pf
  USING
        lv_value1
        lv_value2.

WRITE :/ 'lv_value1 = ', lv_value1,
         'lv_value2 = ', lv_value2.

FORM xxx_pf
  USING
        pv_value1
        pv_value2.

  pv_value1 = '1'.
  pv_value2 = '2'.
ENDFORM.

*--> Example Start
*--> CHANGING 만 사용
DATA :
  lv_value1 TYPE n VALUE 5,
  lv_value2 TYPE n VALUE 5.

PERFORM xxx_pf
  CHANGING
    lv_value1
    lv_value2.

WRITE :/ 'lv_value1 = ', lv_value1,
         'lv_value2 = ', lv_value2.

FORM xxx_pf
  CHANGING
    pv_value1
    pv_value2.

  pv_value1 = '3'.
  pv_value2 = '1'.
ENDFORM.

*--> value를 사용하게 되면 값이 변하지 않음.
DATA : lv_value_test1 TYPE n VALUE 5,
       lv_value_test2 TYPE n VALUE 5.

PERFORM example_value
  USING
        lv_value_test1
        lv_value_test2.

WRITE :/ 'lv_value_test 1 ' , lv_value_test1,
         'lv_value_test 2 ' , lv_value_test2.

FORM example_value
  USING
        VALUE(pv_value1)
        VALUE(pv_value2).

  pv_value1 = '3'.
  pv_value2 = '1'.
ENDFORM.