*&---------------------------------------------------------------------*
*& Report ZPRACTICE_CHS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpractice_chs.

*PERFORM의 TABLES 입장
DATA : lt_table TYPE TABLE OF scarr.

BREAK-POINT.

PERFORM xxx_pf
  TABLES
    lt_table.

FORM xxx_pf
  TABLES
    pt_table.

  BREAK-POINT.

ENDFORM.