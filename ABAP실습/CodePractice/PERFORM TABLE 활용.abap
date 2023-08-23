REPORT zpractice_chs.

*PERFORM 테이블 활용
DATA:
      lt_table TYPE TABLE OF scarr.

SELECT * FROM scarr INTO CORRESPONDING FIELDS OF TABLE lt_table.

PERFORM xxx_pf
  TABLES
    lt_table.

cl_demo_output=>display( lt_table ).

FORM xxx_pf
  TABLES
    pt_table LIKE lt_table.

  LOOP AT pt_table.

    pt_table-carrname = 'chs'.

    MODIFY pt_table.
  ENDLOOP.
ENDFORM.


if ls_z4030-checkbox is not initial .
  CONCATENATE i_datum(6) '01' INTO lv_datum.
  PERFORM calc_date_interval USING lv_datum  '00'  '01'  '00'  '+'
                          CHANGING lv_clsdt.

  CONCATENATE lv_clsdt(6) lv_clsdy INTO lv_clsdt.

  IF lv_clsdt < sy-datlo.
    e_close = 'X'.
  ELSEIF lv_clsdt = sy-datlo AND lv_clstm < sy-timlo.
*  ELSEIF lv_clsdt = sy-datlo AND lv_clstm > sy-timlo.
    e_close = 'X'.


endif.