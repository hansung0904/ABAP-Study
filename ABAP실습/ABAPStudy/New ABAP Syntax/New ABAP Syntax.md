# SAP ABAP New Syntax 정리(After 7.40)

SAP ABAP 컴포넌트가 7.40 이상이라면 아래 New Syntax를 사용할 수 있다.

## 0. 버전 보는 방법
- 시스템 -> 상태 -> 제품버전 내 세부사항
- SAP_ABA 버전확인

## 1. Data Statement 예제
|Before 7.40 |With 7.40|
|------|------|
|DATA text TYPE String. <br> text = ABC.|DATA(text) = 'ABC'.|

## 2. Loop at into work area 예제
|Before 7.40 |With 7.40|
|------|------|
|DATA: ls_0001 TYPE pa0001l. <br> DATA: lt_0001 TYPE TABLE OF pa0001. <br> LOOP AT lt_0001 INTO ls_0001. <br> ENDLOOP.|DATA: lt_0001 TYPE TABLE OF pa0001. <br> LOOP AT lt_0001 INTO DATA(ls_pa0001).<br> ENDLOOP.|

## 3. Loop at assigning 예제
|Before 7.40 |With 7.40|
|------|------|
|FIELD-SYMBOLS: TYPE any. <br> DATA: lt_0001 TYPE TABLE OF pa0001. <br> LOOP AT lt_0001 ASSIGNING. <br> ENDLOOP|DATA: lt_0001 TYPE TABLE OF pa0001. <br>LOOP AT lt_0001 ASSIGNING FIELD-SYMBOL(). <br> ENDLOOP.|

## 4. Read assigning 예제
|Before 7.40 |With 7.40|
|------|------|
|DATA: lt_0001 TYPE TABLE OF pa0001. <br> DATA: ls_0001 TYPE pa0001. <br> DATA: lv_index TYPE i. <br> READ TABLE lt_0001 INDEX lv_index INTO ls_0001.|lv_index = 1. <br> ls_0001 = lt_0001[lv_index].|

## 5. Read Table with key 예제
|Before 7.40 |With 7.40|
|------|------|
|DATA: lt_0001 TYPE TABLE OF pa0001. <br> DATA: ls_0001 TYPE pa0001. <br> DATA: lv_pernr TYPE persno. <br> DATA: lv_Begda TYPE d. <br> READ TABLE lt_0001 WITH KEY pernr = lv_pernr <br> begda = lv_Begda INTO ls_0001.|DATA: lt_0001 TYPE TABLE OF pa0001. <br> DATA: ls_0001 TYPE pa0001. <br> DATA: lv_pernr TYPE perno. <br> DATA: lv_begda TYPE d. <br> ls_0001 = lt_0001[pernr = lv_pernr begda = lv_begda].|

## 6. Does record exist? 예제
|Before 7.40 |With 7.40|
|------|------|
|DTA: lt_0001 TYPE TABLE OF pa0001 WITH HEADER LINE. <br> DATA: lt_pernr TYPE persno. <br> READ TABLE lt_0001 INDEX 1 TRASPORTING NO FIELDS. <br> IF sy-subrc = 0. <br>ENDIF.|DATA: lt_0001 TYPE TABLE OF pa0001 WITH HEADER LINE. <br> DATA: lv_pernr TYPE persno. <br> IF line_exists( lt_0001[pernr = lv_pernr]).|

## 7. Get table index 예제
|Before 7.40 |With 7.40|
|------|------|
|DATA: lt_0001 TYPE TABLE OF pa0001 WITH HEADER LINE. <br> DATA: lv_tabix TYPE sy-tabix. <br> DATA: lv_pernr TYPE persno. <br> READ TABLE lt_0001 TRANSPORTING NO FIELDS. <br> lt_tabix = sy-tabix.|DATA: lt_0001 TYPE TABLE OF pa0001 WITH HEADER LINE. <br> DATA: lv_pernr TYPE persno. <br> DATA(lv_tabix) = line_index( lt_0001[pernr = lv_pernr]).|

## 8. Conversion Operator 예제
|Before 7.40 |With 7.40|
|------|------|
|DATA: text TYPe c LENGTH 255 VALUE 'chs'. <br> DATA: helper TYPe string. <br> DATA: xstr TYPE xstring. <br> helper = text. <br> xstr = cl_abap_codepage=>convert_to( source = helper ). <br> WRITE:/ xstr.|DATA text TYPE c LENGTH 255. <br> DATA(xstr) = cl_abap_codepage=>convert_to( source = CONV #( text ) ).|

## 9 For Operator1 예제
|Before 7.40 |With 7.40|
|------|------|
|TYPES: BEGIN OF ty_ship, <br> tknum TYPE tknum, <br> name TYPE ernam, <br> city TYPe ort01, <br> route TYPe route, <br> END OF ty_ship.<br> TYPES: ty_ships TYPE SORTED TABLE OF ty_ship WITH UNIQUE KEY tknum. <br> TYPEs: ty_citys TPYE STANDARD TABLE OF ort01 WITH EMPTY KEY. <Br> DATA: gt_ships TYPe ty_ships. <br> DATA: gt_citys TYPE ty_citys, <Br> gs_ship TYPE ty_ship, <br> gs_city TYPe ort01. <br> LOOP AT gt_ships INTO gs_ship. <br> gs_city = gs_ship-city. <br> APPEND gs_city TO gt_citys. <Br> ENDLOOP.|TYPES: BEGIN OF ty_ship, <br> tknum TYPE tknum, <br> name TYPE ernam, <br> city TYPE ort01, <br> route TYPE route, <br> END OF ty_ship. <br> TYPES: ty_ships TYPE SORTED TABLE OF ty_ship WITH UNIQUE KEY tknum. <br> TYPES: ty_citys TYPE STANDARD TABLE OF ort01 WITH EMPTY KEY. <br> DATA: ls_ships TYPE ty_ships. <Br> DATA(gt_citys) = VALUE ty_citys( FOR ls_ship IN gt_ships (ls_ship-city) ).|

## 10. For Operator2 예제
|Before 7.40 |With 7.40|
|------|------|
|TYPES: BEGIN OF ty_ship, <br> tknum TYPE tknum, “shipment NUMBER <br> name TYPE ernam, “name OF PERSON who created the OBJECT <br> city TYPE ort01, “starting city <br> route TYPE route, “shipment route <br> END OF ty_ship. <br> TYPES: ty_citys TYPE STANDARD TABLE OF ort01 WITH EMPTY KEY. <br> TYPES: ty_ships TYPE SORTED TABLE OF ty_ship WITH UNIQUE KEY tknum. <br> DATA: gt_citys TYPE ty_citys, <br> gs_ship TYPE ty_ship, <br> gs_city TYPE ort01. <br> DATA: gt_ships TYPE ty_ships. <br> LOOP AT gt_ships INTO gs_ship WHERE route = ‘R0001’. <br> gs_city = gs_ship-city. <br> APPEND gs_city TO gt_citys. <br> ENDLOOP.|TYPES: BEGIN OF ty_ship, <br> tknum TYPE tknum, “shipment NUMBER <br> name TYPE ernam, “name OF PERSON who created the OBJECT <br> city TYPE ort01, “starting city <br> route TYPE route, “shipment route <br> END OF ty_ship. <br> TYPES: ty_citys TYPE STANDARD TABLE OF ort01 WITH EMPTY KEY. <Br> TYPES: ty_ships TYPE SORTED TABLE OF ty_ship WITH UNIQUE KEY tknum. <br> DATA: gt_ships TYPE ty_ships. <br> DATA: ls_ship TYPE ty_ship. <br> DATA(gt_citys) = VALUE ty_citys( FOR ls_ship IN gt_ships <br> WHERE ( route = ‘R0001’ ) ( ls_ship-city ) ).|

## 11. FOR with THEN and UNTIL|WHILE 예제
|Before 7.40 |With 7.40|
|------|------|
|TYPES:<br> BEGIN OF ty_line, <br> col1 TYPE i, <Br> col2 TYPE i, <br> col3 TYPE i, <br> END OF ty_line, <br> ty_tab TYPE STANDARD TABLE OF ty_line WITH EMPTY KEY. <Br> DATA: gt_itabe TYPE ty_tab, <Br> j TYPE i. <br> FIELD-SYMBOLS TYPE ty_line. <br> j = 1. <br> DO. <br> j = j + 10. <br> IF j > 40. EXIT. ENDIF. <br> APPEND INITIAL LINE TO gt_itab ASSIGNING. <br> -col1 = j. <br> -col2 = j + 1. <br> -col3. j + 2. <br> ENDDO.|TYPES: <br> BEGIN OF ty_line, <br> col1 TYPE i, <br> col2 TYPE i, <br> col3 TYPE i, <br> END OF ty_line, <br> ty_tab TYPE STANDARD TABLE OF ty_line WITH EMPTY KEY. <Br> DATA(gt_itab) = VALUE ty_tab( FOR j = 11 THEN j + 10 UNTIL j > 40 <br> (col1 = j col2 = j + 1 col3 = j+2)).|

## 12. Example for COND 예제
```abap
DATA(time) =
COND string(
WHEN sy-timlo < ‘120000’ THEN
|{ sy-timlo TIME = ISO } AM|
WHEN sy-timlo > ‘120000’ THEN
|{ CONV t( sy-timlo – 12 * 3600 ) TIME = ISO } PM|
WHEN sy-timlo = ‘120000’ THEN
|High Noon|
ELSE
| | ).
```

## 13. Concatenate 예제
```abap
"Before 7.40
DATA lv_output TYPE string.
CONCATENATE ‘Hello’ ‘world’ INTO lv_output SEPARATED BY space.

"With 7.40
DATA lv_output TYPE string.
lv_output = |Hello| & | | & |world|.
```

## 14. Select 예제
```abap
Select SINGLE itpct FROM pa0541 INTO @DATA(lv_itpct)
WHERE pernr EQ @i_struc-pernr.
```