# View Push Button

![](/ABAP정리/img/view_push_button.png) <br>
그림과 같은 버튼을 구현한다.

## 화면 로직
```abap
PROCESS BEFORE OUTPUT.
  MODULE liste_initialisieren.
  LOOP AT extract WITH CONTROL
   tctrl_zhrv4000 CURSOR nextline.
    MODULE liste_show_liste.
    MODULE liste_deactivate.                        "HRC-20231116-101118
    MODULE init_text_0001.
  ENDLOOP.
  MODULE fill_substflds.
*
PROCESS AFTER INPUT.
  MODULE liste_exit_command AT EXIT-COMMAND.
  MODULE user_command_0001. " APPMETH1 / APPMETH2 Button.
  MODULE liste_before_loop.
  LOOP AT extract.
    MODULE liste_init_workarea.
    CHAIN.
      FIELD zhrv4000-awart .
      FIELD zhrv4000-endda .
      FIELD zhrv4000-begda .
      FIELD zhrv4000-seqnr .
      FIELD zhrv4000-inpty .
      FIELD zhrv4000-mintm .
      FIELD zhrv4000-maxtm .
      FIELD zhrv4000-datim .
      FIELD zhrv4000-tauto .
      FIELD zhrv4000-atdty_ip .
      FIELD zhrv4000-colty .
      FIELD zhrv4000-uname .
      FIELD zhrv4000-aedtm .
      FIELD zhrv4000-aetim .
      FIELD zhrv4000-mintg .
      FIELD zhrv4000-maxtg .
      FIELD zhrv4000-atext .
*    FIELD ZHRV4000-SBCODT .
      FIELD zhrv4000-absquota .
      MODULE set_change_info.
      MODULE set_update_flag ON CHAIN-REQUEST.
      MODULE complete_zhrv4000 ON CHAIN-REQUEST.
    ENDCHAIN.
    CHAIN.                                          "HRC-20231116-101118
      FIELD zhrv4000-begda.                         "HRC-20231116-101118
      FIELD zhrv4000-endda.                         "HRC-20231116-101118
      MODULE temp_delimitation ON CHAIN-REQUEST.    "HRC-20231116-101118
    ENDCHAIN.                                       "HRC-20231116-101118
    FIELD vim_marked MODULE liste_mark_checkbox.
    CHAIN.
      FIELD zhrv4000-awart .
      FIELD zhrv4000-endda .
      MODULE liste_update_liste.
    ENDCHAIN.
  ENDLOOP.
  MODULE liste_after_loop.

PROCESS ON VALUE-REQUEST.
  FIELD zhrv4000-awart MODULE f4_awart_0001.
  FIELD zhrv4000-inpty MODULE f4_inpty_0001.
```

## PBO init_text_0001
```abap

  DATA lv_ddtext TYPE val_text.

  CLEAR gv_moabw.
  SELECT SINGLE moabw FROM t001p
           INTO gv_moabw
          WHERE werks = zhrv4000-werks.

  CLEAR : gv_art01, gv_art01t, zhrv4000-atext.
  IF zhrv4000-awart IS NOT INITIAL.
* 근태유형명
    SELECT SINGLE atext FROM t554t
             INTO zhrv4000-atext
            WHERE sprsl = sy-langu
              AND moabw = gv_moabw
              AND awart = zhrv4000-awart.

* 구분명, 최소일수, 최대일수
    SELECT SINGLE mintg maxtg art01 FROM t554s
             INTO (zhrv4000-mintg, zhrv4000-maxtg, gv_art01)
            WHERE moabw  = gv_moabw
              AND subty  = zhrv4000-awart
              AND begda <= zhrv4000-begda
              AND endda >= zhrv4000-begda.

* 구분 DOMAIN TEXT
    CLEAR lv_ddtext.
    SELECT SINGLE ddtext FROM dd07t
             INTO lv_ddtext
            WHERE domname    = 'ART01'
              AND domvalue_l = gv_art01
              AND ddlanguage = sy-langu.

    gv_art01t = lv_ddtext(2).
  ENDIF.
```

## PAI user_command_0001.
```abap
CASE ok_code.
    WHEN 'APPMETH1' OR 'APPMETH2'.
      GET CURSOR LINE gv_line.
      READ TABLE extract INDEX gv_line.
      zhrv4000+0(19) = extract+0(19).

      SELECT SINGLE FROM zhrt4000
                  FIELDS *
                   WHERE werks = @zhrv4000-werks
                     AND awart = @zhrv4000-awart
                     AND endda = @zhrv4000-endda
                    INTO CORRESPONDING FIELDS OF @zhrv4000.

      CALL SCREEN 0900.
      CLEAR ok_code.
  ENDCASE.
```

## 900번 화면 호출 로직
```abap
PROCESS BEFORE OUTPUT.
  MODULE status_0900.
  MODULE init_alv_0900.
*
PROCESS AFTER INPUT.
  MODULE exit AT EXIT-COMMAND.
  MODULE user_command_0900.
```

## Status_0900 Output
```abap
SET PF-STATUS '0900'.
SET TITLEBAR 'TITLE_0900'.

*-> ALV 버튼 기능 구현처럼 버튼 구현해주고
```

## Init_ALV_0900
```abap
DATA : lt_text TYPE TABLE OF tline WITH HEADER LINE,
         ls_text TYPE zhrs0006.

  DATA : lv_zfkey TYPE tdobname.

  CLEAR : gt_resn, gt_resn[].

  CASE ok_code.
*-> 작성방법(생산)
    WHEN 'APPMETH1'.
      lv_zfkey = zhrv4000-appmeth1.

*-> 작성방법(사무)
    WHEN 'APPMETH2'.
      lv_zfkey = zhrv4000-appmeth2.

  ENDCASE.

  IF lv_zfkey IS NOT INITIAL.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        id                      = zcl_hr_cnst=>tdid-hr40
        language                = sy-langu
        name                    = lv_zfkey
        object                  = zcl_hr_cnst=>tdobj
      TABLES
        lines                   = lt_text
      EXCEPTIONS
        id                      = 1
        language                = 2
        name                    = 3
        not_found               = 4
        object                  = 5
        reference_check         = 6
        wrong_access_to_archive = 7
        OTHERS                  = 8.

    LOOP AT lt_text.
      ls_text-value = lt_text-tdline.
      APPEND ls_text TO gt_resn.
    ENDLOOP.
  ENDIF.

  PERFORM set_cl_resn.

  CALL METHOD gv_redit->set_readonly_mode( 0 ).

  CALL METHOD gv_redit->set_text_as_r3table
    EXPORTING
      table = gt_resn.
```

## user_command_0900
```abap
 CASE save_ok.
*-> 실행
    WHEN 'ACT'.
      PERFORM action.
      CLEAR save_ok.
      LEAVE TO SCREEN 0.

*-> 취소
    WHEN 'CAN'.
      CLEAR save_ok.
      LEAVE TO SCREEN 0.

  ENDCASE.
```

## perform set_cl_resn
```abap
  IF gv_rcontainer IS INITIAL.
    CREATE OBJECT gv_rcontainer
      EXPORTING
        container_name = 'CL_RESN'.

    CREATE OBJECT gv_redit
      EXPORTING
        parent            = gv_rcontainer
        wordwrap_mode     = cl_gui_textedit=>wordwrap_at_fixed_position
        wordwrap_position = 72.

    CALL METHOD cl_gui_cfw=>flush.

*..1. Standard Toolbar
    CALL METHOD gv_redit->set_toolbar_mode
      EXPORTING
        toolbar_mode = cl_gui_textedit=>false.

*..2. Standard line, colum bar
    CALL METHOD gv_redit->set_statusbar_mode
      EXPORTING
        statusbar_mode = cl_gui_textedit=>false.
  ENDIF.
```

## perform action
```abap
 DATA : lt_text TYPE TABLE OF tline WITH HEADER LINE.
  DATA : ls_text TYPE zhrs0006.

  DATA : ls_head TYPE thead.
  DATA : lv_zfkey TYPE tdobname.

  CLEAR : lt_text[], lt_text.
  CALL METHOD gv_redit->get_text_as_stream
    IMPORTING
      text = gt_resn.

  LOOP AT gt_resn INTO ls_text.
    lt_text-tdline = ls_text-value.
    APPEND lt_text.
  ENDLOOP.

  lv_zfkey = |{ zhrv4000-werks }{ zhrv4000-awart }{ zhrv4000-endda }{ ok_code }|.

  CALL FUNCTION 'DELETE_TEXT'
    EXPORTING
      id        = zcl_hr_cnst=>tdid-hr40
      language  = sy-langu
      name      = lv_zfkey
      object    = zcl_hr_cnst=>tdobj
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.

  IF lt_text[] IS NOT INITIAL.
    ls_head-tdobject = zcl_hr_cnst=>tdobj.
    ls_head-tdname = lv_zfkey.
    ls_head-tdid = zcl_hr_cnst=>tdid-hr40.
    ls_head-tdspras = sy-langu.

    CALL FUNCTION 'SAVE_TEXT'
      EXPORTING
        header   = ls_head
      TABLES
        lines    = lt_text
      EXCEPTIONS
        id       = 1
        language = 2
        name     = 3
        object   = 4
        OTHERS   = 5.

  ELSE.
    CLEAR lv_zfkey.
  ENDIF.

  CASE ok_code.
    WHEN 'APPMETH1'.
      zhrv4000-appmeth1 = lv_zfkey.
      UPDATE zhrt4000 SET appmeth1 = lv_zfkey
                    WHERE werks = zhrv4000-werks
                      AND awart = zhrv4000-awart
                      AND endda = zhrv4000-endda.
    WHEN 'APPMETH2'.
      zhrv4000-appmeth2 = lv_zfkey.
      UPDATE zhrt4000 SET appmeth2 = lv_zfkey
                    WHERE werks = zhrv4000-werks
                      AND awart = zhrv4000-awart
                      AND endda = zhrv4000-endda.
  ENDCASE.
```