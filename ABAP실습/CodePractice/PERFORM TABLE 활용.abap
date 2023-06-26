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