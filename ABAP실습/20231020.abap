*&---------------------------------------------------------------------*
*& Form get_request_recruit_apply
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ET_LIST1
*&      --> I_WERKS
*&      --> I_APBEG
*&      --> I_APEND
*&      --> I_AUSTY
*&      --> I_ORGEH
*&      <-- ES_RETURN
*&---------------------------------------------------------------------*
FORM get_request_recruit_apply  TABLES   pt_list1 STRUCTURE zhrs1200
                                USING    p_werks
                                         p_apbeg
                                         p_apend
                                         p_austy
                                         p_orgeh
                                CHANGING ps_return TYPE bapiret2.



  DATA : lt_zhrt0800 TYPE TABLE OF zhrt0800 WITH HEADER LINE,
         lt_zhrt0840 TYPE TABLE OF zhrt0840 WITH HEADER LINE,
         lt_zhrt1200 TYPE TABLE OF zhrt1200 WITH HEADER LINE.


  DATA : lt_pa0001  LIKE TABLE OF pa0001 WITH HEADER LINE.
  DATA : lt_rqrcrst LIKE TABLE OF dd07t  WITH HEADER LINE,
         lt_appsttx LIKE TABLE OF dd07t  WITH HEADER LINE.

  DATA : lt_hrp1000 LIKE TABLE OF hrp1000 WITH HEADER LINE.

  RANGES : lr_appno FOR zhrt0800-appno,  " RAGNE변수 선언시에 appno를 가지고 있는 어떤 테이블이 와도 상관없다.
           lr_pernr FOR pa0001-pernr.

  CLEAR : pt_list1, pt_list1[], lt_pa0001, lt_pa0001[],
          lt_rqrcrst, lt_rqrcrst[], lt_appsttx, lt_appsttx[],
          lt_hrp1000, lt_hrp1000[], lr_pernr, lr_pernr[].


*-> Validation Check
  IF p_werks IS INITIAL.
    ps_return-type = zcl_hr_cnst=>msgty-a.
    MESSAGE e068 INTO ps_return-message. " 인사영역이 전송되지 않았습니다.
    EXIT.  " EXIT 또는 RETURN이 필요하다 Exception 터지고 난후에 빠져나가게 해주어야함.
  ENDIF.

  IF p_apbeg IS INITIAL.
    ps_return-type = zcl_hr_cnst=>msgty-a.
    MESSAGE e209 INTO ps_return-message. " 신청시작일이 전송되지 않았습니다.
    EXIT.
  ENDIF.

  IF p_apend IS INITIAL.
    ps_return-type = zcl_hr_cnst=>msgty-a.
    MESSAGE e210 INTO ps_return-message. " 신청종료일이 전송되지 않았습니다.
    EXIT.
  ENDIF.

  IF p_austy EQ 'M' AND p_orgeh IS INITIAL.
    ps_return-type = zcl_hr_cnst=>msgty-a.
    MESSAGE e212 INTO ps_return-message. " 부서가 전송되지 않았습니다.
    EXIT.
  ENDIF.

* 채용상태
  SELECT * FROM dd07t
    WHERE domname = 'ZHRD_RQRCRST'
      AND ddlanguage = @sy-langu
    INTO TABLE @lt_rqrcrst.
  SORT lt_rqrcrst BY domvalue_l.

* 결재상태
  SELECT * FROM dd07t
  WHERE domname = 'ZHRD_APPST'
    AND ddlanguage = @sy-langu
  INTO TABLE @lt_appsttx.
  SORT lt_appsttx BY domvalue_l.

* 부서
  SELECT * FROM hrp1000
    WHERE plvar   = @zcl_hr_cnst=>plvar
      AND istat   = @zcl_hr_cnst=>istat
      AND otype   = @zcl_hr_cnst=>otype-o
      AND  langu  = @sy-langu
      AND  begda <= @p_apbeg
      AND  endda >= @p_apend
    INTO TABLE @lt_hrp1000.
  SORT lt_hrp1000 BY objid begda.

* 신청자 성명
  SELECT SINGLE *
           FROM pa0001
          WHERE pernr IN @lr_pernr
            AND werks  = @p_werks
            AND begda <= @p_apbeg                 " 신청시작일
            AND endda >= @p_apend                 " 신청종료일
           INTO @lt_pa0001.
  SORT lt_pa0001 BY pernr begda.


*-> 1안 zhrt0800 테이블 결재 Header 조회
  CLEAR : lt_zhrt0800, lt_zhrt0800[].
  SELECT * FROM zhrt0800                          " [결재] 결재 Header Table
        WHERE   zreq_date  >= @p_apbeg
          AND   zreq_date  <= @p_apend
          AND   werks       = @p_werks
          AND   zreq_orgeh1 = @p_orgeh
          AND   zreq_form   = 'HR21'              " 채용? 2023-10-16 현재는 이렇게 하드코딩
    INTO TABLE @lt_zhrt0800.
  SORT lt_zhrt0800 BY appno.                       " sort appno 왜? -> 아래에서 BinarySearch 사용하려고.

  CHECK lt_zhrt0800[] IS NOT INITIAL.
  LOOP AT lt_zhrt0800.                            " loop 안에선 select 자제
    set_value lr_appno lt_zhrt0800-appno.         " -> range 변수에 값을 담음.
  ENDLOOP.

  SELECT * FROM zhrt1200                          " [채용] 인원채용요청서 Table
    WHERE werks  = @p_werks
      AND orgeh  = @p_orgeh
      AND appno IN @lr_appno
    INTO TABLE @lt_zhrt1200.

*-> Data 출력
  LOOP AT lt_zhrt1200.
    pt_list1-rqdoctx = lt_zhrt1200-rqdoctx.    " 인원채용요청서 제목
    pt_list1-tocnt   = lt_zhrt1200-tocnt.      " 요청인원

    READ TABLE lt_zhrt0800 WITH KEY appno = lt_zhrt1200-appno. " Read lt_zhrt0800. Appno
    pt_list1-appda   = lt_zhrt0800-zreq_date.    " 신청일
    pt_list1-sgnda   = lt_zhrt0800-zapp_date.    " 결재일
    pt_list1-apppnr  = lt_zhrt0800-zreq_pernr1.  " 신청자 사번
    pt_list1-appst   = lt_zhrt0800-zapp_stat_al. " 결재상태
    pt_list1-rqrcrst = lt_zhrt1200-rqrcrst.      " 채용상태
    pt_list1-appno   = lt_zhrt1200-appno.        " 신청번호

*-> 신청자성명
    CLEAR : lt_pa0001.
    READ TABLE lt_pa0001 WITH KEY pernr = pt_list1-apppnr BINARY SEARCH.
    CHECK sy-subrc EQ 0.
    pt_list1-apppnm = lt_pa0001-ename.

*-> 결재상태명
    CLEAR : lt_appsttx.
    READ TABLE lt_appsttx WITH KEY domvalue_l = pt_list1-appst BINARY SEARCH.
    pt_list1-appsttx = lt_appsttx-ddtext.

*-> 부서
    LOOP AT lt_hrp1000 WHERE objid  = lt_pa0001-orgeh
                         AND begda <= pt_list1-apbeg
                         AND endda >= pt_list1-apbeg.
      pt_list1-orgtx = lt_hrp1000-stext.
      EXIT.
    ENDLOOP.

    CLEAR : lt_hrp1000.
    READ TABLE lt_hrp1000 WITH KEY objid = lt_pa0001-orgeh BINARY SEARCH.
    pt_list1-orgtx = lt_hrp1000-stext.

*-> 채용상태명
    CLEAR : lt_rqrcrst.
    READ TABLE lt_rqrcrst WITH KEY domvalue_l = pt_list1-rqrcrst BINARY SEARCH.
    pt_list1-rqrcrsttx = lt_rqrcrst-ddtext.

    APPEND pt_list1.
    CLEAR  pt_list1.
  ENDLOOP.

  SORT pt_list1 BY appno apbeg.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_request_recruit_apply_d
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ET_LIST1
*&---------------------------------------------------------------------*
FORM get_request_recruit_apply_d USING p_appno
                              CHANGING ps_return TYPE bapiret2.

*-> Validation Check
  IF p_appno IS INITIAL.
    ps_return-type = zcl_hr_cnst=>msgty-a.
    MESSAGE e206 INTO ps_return-message. " 신청번호가 전송되지 않았습니다.
    EXIT.                                " Exception 터진 후 빠져나가도록.
  ENDIF.

*-> 인원채용요청서/인원채용요청서 상세
  DELETE FROM zhrt1200 WHERE appno = p_appno.
  DELETE FROM zhrt1210 WHERE appno = p_appno.

*-> 결재 Header/결재Line
  DELETE FROM zhrt0800 WHERE appno = p_appno.
  DELETE FROM zhrt0810 WHERE appno = p_appno.

  IF sy-subrc NE 0.                      " DELETE 실패시 ROLLBACK.
    ROLLBACK WORK.
    ps_return-type = zcl_hr_cnst=>msgty-e.
    MESSAGE e205 INTO ps_return-message. " 삭제시 오류가 발생하였습니다.
    EXIT.
  ENDIF.

  COMMIT WORK.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_recruitappl
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> IT_LIST1
*&      --> I_PERNR
*&      --> IS_HEADER
*&      <-- ES_RETURN
*&      <-- E_APPNO
*&---------------------------------------------------------------------*
FORM create_recruitappl  TABLES   pt_list1 STRUCTURE zhrs1210
                         USING    ps_header TYPE zhrs1200
                                  p_pernr
                         CHANGING ps_return TYPE bapiret2.

  DATA : lt_zhrt1200 TYPE TABLE OF zhrt1200 WITH HEADER LINE,
         lt_zhrt1210 TYPE TABLE OF zhrt1210 WITH HEADER LINE.

  DATA : ls_log      TYPE zhrs0001,
         ls_zhrs1200 TYPE zhrt1200.

  DATA : lv_appno  TYPE zhre_appno,
*         lv_title  TYPE char40,
         lv_apname TYPE emnam.

  CONSTANTS : lc_nrnr TYPE nrnr VALUE '01',
              lc_form TYPE zhre_req_form VALUE 'HR21'. " 현재는 이렇게 하드코딩

*-> Validation Check
  IF ps_header-werks IS INITIAL.
    ps_return-type = zcl_hr_cnst=>msgty-a.
    MESSAGE e068 INTO ps_return-message.    " 인사영역이 전송되지 않았습니다.
    EXIT.
  ENDIF.

  IF ps_header-orgeh IS INITIAL.
    ps_return-type = zcl_hr_cnst=>msgty-a.
    MESSAGE e212 INTO ps_return-message.    " 부서가 전송되지 않았습니다.
    EXIT.
  ENDIF.

*-> Log
  PERFORM set_log.

*-> 신청번호 채번 Start
  CLEAR lv_appno.
  IF ps_header-appno IS NOT INITIAL.
    lv_appno = ps_header-appno.
  ELSE.
    PERFORM number_get_next IN PROGRAM saplzhr00
                                 USING lc_nrnr
                                       zcl_hr_cnst=>nrobj-appno
                                       sy-datlo+0(4)
                              CHANGING lv_appno.

    IF lv_appno IS INITIAL.
      ps_return-type = zcl_hr_cnst=>msgty-e.
      MESSAGE s207 INTO ps_return-message.        " 신청번호 채번 시 오류가 발생하였습니다.
      EXIT.
    ENDIF.
  ENDIF.

*-> Header
  MOVE-CORRESPONDING ls_log    TO ls_zhrs1200.
  MOVE-CORRESPONDING ps_header TO ls_zhrs1200.
  ls_zhrs1200-rqrcrst = '10'.
  ls_zhrs1200-appno   = lv_appno.               " 신청번호 넣어주는 부분 누락 -> (수정완료)

*-> Body
  CLEAR lt_zhrt1210.
  LOOP AT pt_list1.
    MOVE-CORRESPONDING ls_log   TO lt_zhrt1210.
    MOVE-CORRESPONDING pt_list1 TO lt_zhrt1210.

    lt_zhrt1210-appno = lv_appno.               " pt_list1-appno. (수정완료)

    APPEND lt_zhrt1210.
    CLEAR lt_zhrt1210.
  ENDLOOP.

*-> Save
* 1) Header - zhrt1200.
  DELETE FROM zhrt1200 WHERE appno = ls_zhrs1200-appno.
  MODIFY zhrt1200 FROM ls_zhrs1200.

  IF sy-subrc NE 0.
    ROLLBACK WORK.
    ps_return-type = zcl_hr_cnst=>msgty-e.
    ps_return-message = TEXT-m01.               " 저장시 오류가 발생했습니다.
    EXIT.
  ENDIF.

* 2) Detail - zhrt1210.
  DELETE FROM zhrt1210 WHERE appno = ls_zhrs1200-appno.
  MODIFY zhrt1210 FROM TABLE lt_zhrt1210.

  IF sy-subrc NE 0.
    ROLLBACK WORK.
    ps_return-type = zcl_hr_cnst=>msgty-e.
    ps_return-message = TEXT-m01.               " 저장시 오류가 발생했습니다.
    EXIT.
  ENDIF.

* 3) 결재 Header 저장 - zhrt0800
  PERFORM save_zhrt0800 USING ps_header-prcty
                              lv_appno          " 신청번호 ps_header-appno (수정완료)
                              lc_form           " Form -> zcl_hr_cnst=>req_forms-hr21 로 할 예정.
                              ps_header-rqdoctx
                              p_pernr           " 신청자 사번 ps_header-apppnr (수정완료)
                              ps_header-appst   " 상태
                     CHANGING ps_return.

  IF ps_return-type = zcl_hr_cnst=>msgty-e.
    RETURN.
  ENDIF.

* 4) 결재 Line 저장 - zhrt0810
*  PERFORM save_zhrt0810 USING ps_header-appno
*                              lc_form
*                              ps_header-apppnr
*                              ps_header-appst
*                     CHANGING ps_return.
  COMMIT WORK.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_log
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_log .

  DATA lo_text TYPE REF TO zcl_hr_common.
  DATA ls_log  TYPE zhrs0001.

  CLEAR ls_log.

  CREATE OBJECT lo_text.
  lo_text->set_log( CHANGING es_log = ls_log ).
ENDFORM.
*&---------------------------------------------------------------------*
*& Form save_zhrt0800
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> PS_HEADER_APPNO
*&      --> LC_FORM
*&      --> LV_TITLE
*&      --> PS_HEADER_APPPNR
*&      --> PS_HEADER_APPST
*&      <-- PS_RETURN
*&---------------------------------------------------------------------*
FORM save_zhrt0800  USING    p_actio
                             p_appno
                             p_form
                             p_title
                             p_apppnr
                             p_appst
                    CHANGING ps_return TYPE bapiret2.

  DATA : ls_zhrs0800 TYPE zhrt0800,
         ls_log      TYPE zhrs0001.

  IF p_actio EQ 'S'. " 임시저장
    p_appst = zcl_hr_cnst=>app_stat_al-stat10.
  ELSEIF p_actio EQ 'C'. "신청
    p_appst = zcl_hr_cnst=>app_stat_al-stat20.
  ENDIF.


  SELECT SINGLE FROM pa0001
         FIELDS werks, orgeh
    WHERE pernr  = @p_apppnr
      AND begda <= @sy-datum
      AND endda >= @sy-datum
    INTO (@ls_zhrs0800-werks,
          @ls_zhrs0800-zreq_orgeh1). " 신청자부서

  ls_zhrs0800-appno        = p_appno.  " 신청번호
  ls_zhrs0800-zreq_form    = p_form.   " Form
  ls_zhrs0800-zapp_titl    = p_title.  " 신청제목
  ls_zhrs0800-zreq_pernr1  = p_apppnr. " 신청자
  ls_zhrs0800-zapp_stat_al = p_appst.  " 상태

  zcl_hr_common=>set_log( CHANGING es_log = ls_log ).
  MOVE-CORRESPONDING ls_log TO ls_zhrs0800.

  MODIFY zhrt0800 FROM ls_zhrs0800.
  IF sy-subrc NE 0.
    ROLLBACK WORK.
    ps_return-type = zcl_hr_cnst=>msgty-e.
    ps_return-type = TEXT-m01. " 저장시 오류가 발생하였습니다.
    RETURN.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_recruitappl_body
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ET_LIST
*&      --> I_WERKS
*&      --> I_APPNO
*&      <-- ES_HEADER
*&      <-- ES_RETURN
*&---------------------------------------------------------------------*
FORM display_recruitappl_body   TABLES   pt_list STRUCTURE zhrs1210
                                USING    p_werks
                                         p_appno
                                CHANGING ps_header TYPE zhrs1200
                                         ps_return TYPE bapiret2.

  DATA : lt_zhrt0800 TYPE TABLE OF zhrt0800 WITH HEADER LINE,
         lt_zhrt1200 TYPE TABLE OF zhrt1200 WITH HEADER LINE,
         lt_zhrt1210 TYPE TABLE OF zhrt1210 WITH HEADER LINE,
         lt_zhrt1220 TYPE TABLE OF zhrt1220 WITH HEADER LINE,
         lt_zhrt1230 TYPE TABLE OF zhrt1230 WITH HEADER LINE,
         lt_zhrt1240 TYPE TABLE OF zhrt1240 WITH HEADER LINE,
         lt_zhrt1250 TYPE TABLE OF zhrt1250 WITH HEADER LINE.

  DATA : lt_pa0001 TYPE TABLE OF pa0001 WITH HEADER LINE.

  DATA : lt_rcrnctx TYPE TABLE OF dd07t WITH HEADER LINE,
         lt_threhtx TYPE TABLE OF dd07t WITH HEADER LINE.

  DATA lv_seqnr TYPE seqnr.

  RANGES : lr_pernr FOR pa0001-pernr.

* 결재상태 조회
  SELECT * FROM zhrt0800
          WHERE werks = @p_werks
            AND appno = @p_appno
     INTO TABLE @lt_zhrt0800.

* 포지션 조회
  SELECT SINGLE FROM hrp1000
    FIELDS
    stext
    WHERE plvar =  @zcl_hr_cnst=>plvar
      AND istat =  @zcl_hr_cnst=>otype-s " 포지션은 S로 PP01-> 오브젝트 유형 S가 포지션이다.
      AND langu =  @sy-langu
      AND begda <= @sy-datum
      AND endda >= @sy-datum
    INTO @DATA(lv_stext).

* 합격자 조회
  SELECT * FROM zhrt1250
          WHERE appno = @p_appno
    INTO TABLE @lt_zhrt1250.

  IF lt_zhrt1250[] IS NOT INITIAL.
    LOOP AT lt_zhrt1250.
      set_value lr_pernr lt_zhrt1250-pernr.
    ENDLOOP.

* 합격자 성명 조회
    SELECT SINGLE *
             FROM pa0001
            WHERE pernr IN @lr_pernr
              AND werks  = @p_werks
             INTO @lt_pa0001.
    SORT lt_pa0001 BY pernr begda.
  ENDIF.

****************************************************************************************************************
* zhrt1200 조회
  SELECT SINGLE *
           FROM zhrt1200
          WHERE werks = @p_werks
            AND appno = @p_appno
           INTO @DATA(ls_z1200).

* zhrt1210 조회
  SELECT * FROM zhrt1210
    WHERE appno = @p_appno
    INTO TABLE @lt_zhrt1210.
****************************************************************************************************************

* 채용 직군 조회
  SELECT * FROM zhrt1220
     FOR ALL ENTRIES IN @lt_zhrt1210    " Range 변수가 하는 역할이랑 같다.
    WHERE jbgcd = @lt_zhrt1210-jbgcd    " @pt_list-jbgcd
    INTO TABLE @lt_zhrt1220.

* 지원분야 조회 ( zhrt1210에 담겨있는 직군관리코드를 조건으로 가져와야하는가? ) -> 당연하다.
  SELECT * FROM zhrt1230
    FOR ALL ENTRIES IN @lt_zhrt1210
    WHERE jbgcd = @lt_zhrt1210-jbgcd
      AND fldcd = @lt_zhrt1210-fldcd
    INTO TABLE @lt_zhrt1230.

* 채용 근무지 조회
  SELECT * FROM zhrt1240
    FOR ALL ENTRIES IN @lt_zhrt1210
    WHERE wplcd = @lt_zhrt1210-wplcd
    INTO TABLE @lt_zhrt1240.

* 신입/경력 구분
  SELECT * FROM dd07t
    WHERE domname = 'ZHRD_RCRNC'
      AND ddlanguage = @sy-langu
    INTO TABLE @lt_rcrnctx.
  SORT lt_rcrnctx BY domvalue_l.

* 시작/종료 경력 임계 분류
  SELECT * FROM dd07t
    WHERE domname = 'ZHRD_THREH'
      AND ddlanguage = @sy-langu
    INTO TABLE @lt_threhtx.
  SORT lt_threhtx BY domvalue_l.

* Header에 값 담기.
  MOVE-CORRESPONDING ls_z1200 TO ps_header.
* 요청서 채용 상태명
  ps_header-rqrcrsttx = zcl_hr_common=>get_domain_text( i_domname  = 'ZHRD_RQRCRST'
                                                        i_domvalue = ls_z1200-rqrcrst ).
* 조직단위명
  ps_header-orgtx = zcl_hr_common=>get_objid_text( i_otype = zcl_hr_cnst=>otype-o
                                                   i_langu = sy-langu
                                                   i_objid = ls_z1200-orgeh
                                                   i_datum = sy-datum ).
* 결재상태
*  read 구문 넣어주기 ( Check 완료 )
  READ TABLE lt_zhrt0800 WITH KEY appno = pt_list-appno.
  ps_header-appst   = lt_zhrt0800-zapp_stat_al.

* 결재상태명
  ps_header-appsttx = zcl_hr_common=>get_stattx( i_werks       = lt_zhrt0800-werks
                                                 i_app_stat_al = lt_zhrt0800-zapp_stat_al ).
* 신청자 사번
  ps_header-apppnr  = lt_zhrt0800-zreq_pernr1.

* 신청자 성명
  ps_header-apppnm  = zcl_hr_common=>get_ename( i_pernr = lt_zhrt0800-zreq_pernr1 ).

* 신청일
  ps_header-appda   = lt_zhrt0800-zreq_date.

* Body에 값 담기
  LOOP AT lt_zhrt1210. " zhrt1210 Table Loop Start.
    " seqnr 채번했으면 써야지.

** 합격자 사번이 존재하는지 확인
* 있으면 ZHRT1250 데이터만큼 Record 생성.
    CLEAR lt_zhrt1250.
    READ TABLE lt_zhrt1250 WITH KEY objid = lt_zhrt1210-objid.
    IF sy-subrc = 0.
      LOOP AT lt_zhrt1250 WHERE objid = lt_zhrt1210-objid. " 합격자가 여러명(다수) 이면..
        " 사번이 여러명인 경우 pt_list-ename 넣어주는 방법 예)최한성/이언호 -> 2개의 Row로 처리.

        ADD 1 TO lv_seqnr. " 시퀀스넘버 채번.
        MOVE-CORRESPONDING lt_zhrt1210 TO pt_list.

        pt_list-stext = lv_stext.

** Read table 넣어주기 ( check 완료 )
*        READ TABLE lt_zhrt1250 WITH KEY pernr = lt_zhrt1250-pernr.
        pt_list-pernr = lt_zhrt1250-pernr.        " 합격자 사번
        pt_list-seqnr = lv_seqnr.

        CLEAR : lt_pa0001.
        READ TABLE lt_pa0001 WITH KEY pernr = lt_zhrt1250-pernr BINARY SEARCH.
        CHECK sy-subrc EQ 0.
        pt_list-ename = lt_pa0001-ename.          " 합격자 성명

* Read table 넣어주기 ( Check 완료 )
        READ TABLE lt_zhrt1220 WITH KEY jbgcd = lt_zhrt1210-jbgcd.
        pt_list-jbgtx  = lt_zhrt1220-jbgtx.        " 채용직군 텍스트

        READ TABLE lt_zhrt1230 WITH KEY fldcd = lt_zhrt1210-fldcd.
        pt_list-fldtx  = lt_zhrt1230-fldtx.        " 채용 지원분야 텍스트

        READ TABLE lt_zhrt1240 WITH KEY wplcd = lt_zhrt1210-wplcd.
        pt_list-wpltx  = lt_zhrt1240-wpltx.        " 채용 근무지 텍스트

        CLEAR : lt_rcrnctx.
        READ TABLE lt_rcrnctx WITH KEY domvalue_l = pt_list-rcrnc BINARY SEARCH.  " 신입/경력 구분 텍스트
        pt_list-rcrnctx  = lt_rcrnctx-ddtext.

        CLEAR : lt_threhtx.
        READ TABLE lt_threhtx WITH KEY domvalue_l = pt_list-threh1 BINARY SEARCH. " 시작 경력 임계 텍스트
        pt_list-threhtx1 = lt_threhtx-ddtext.

        CLEAR : lt_threhtx.
        READ TABLE lt_threhtx WITH KEY domvalue_l = pt_list-threh2 BINARY SEARCH. " 종료 경력 임계 텍스트
        pt_list-threhtx2 = lt_threhtx-ddtext.

        APPEND pt_list.
        CLEAR pt_list.

      ENDLOOP.


    ELSE.

      ADD 1 TO lv_seqnr. " 시퀀스넘버 채번.
      MOVE-CORRESPONDING lt_zhrt1210 TO pt_list.

      pt_list-stext = lv_stext.

* Read table 넣어주기 ( check 완료 )
      READ TABLE lt_zhrt1250 WITH KEY pernr = lt_zhrt1250-pernr.
      pt_list-pernr = lt_zhrt1250-pernr.        " 합격자 사번
      pt_list-seqnr = lv_seqnr.

* Read table 넣어주기 ( Check 완료 )
      READ TABLE lt_zhrt1220 WITH KEY jbgcd = lt_zhrt1210-jbgcd.
      pt_list-jbgtx  = lt_zhrt1220-jbgtx.        " 채용직군 텍스트

      READ TABLE lt_zhrt1230 WITH KEY fldcd = lt_zhrt1210-fldcd.
      pt_list-fldtx  = lt_zhrt1230-fldtx.        " 채용 지원분야 텍스트

      READ TABLE lt_zhrt1240 WITH KEY wplcd = lt_zhrt1210-wplcd.
      pt_list-wpltx  = lt_zhrt1240-wpltx.        " 채용 근무지 텍스트

      CLEAR : lt_rcrnctx.
      READ TABLE lt_rcrnctx WITH KEY domvalue_l = pt_list-rcrnc BINARY SEARCH.  " 신입/경력 구분 텍스트
      pt_list-rcrnctx  = lt_rcrnctx-ddtext.

      CLEAR : lt_threhtx.
      READ TABLE lt_threhtx WITH KEY domvalue_l = pt_list-threh1 BINARY SEARCH. " 시작 경력 임계 텍스트
      pt_list-threhtx1 = lt_threhtx-ddtext.

      CLEAR : lt_threhtx.
      READ TABLE lt_threhtx WITH KEY domvalue_l = pt_list-threh2 BINARY SEARCH. " 종료 경력 임계 텍스트
      pt_list-threhtx2 = lt_threhtx-ddtext.

* append & clear 넣어주기 ( Check 완료 )
      APPEND pt_list.
      CLEAR pt_list.

    ENDIF.

  ENDLOOP. " Zhrt1210 Table Loop End.

ENDFORM.