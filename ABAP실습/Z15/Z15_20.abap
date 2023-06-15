REPORT Z15_20.
-----> 중 략 <-----

DATA : BEGIN OF gt_sflight OCCURS 0.
    INCLUDE STRUCTRUE sflight.

DATA : light TYPE c.
DATA : END OF gt_sflgiht.

-----> 중 략 <-----
LOOP AT gt_sflight.

    IF gt_sflight-seatsocc <= 0.
        gt_sflight-light = '1'.
    ELSEIF gt_sflight-seatsocc <= 50.
        gt_sflight-light = '2'.
    ELSE.
        gt_sflight-light = '3'.
    ENDIF.        

    MODIFY gt_sflight.

ENDLOOP.

-----> 중 략 <-----

FORM setting_layout CHANGING p_layout TYPE lvc_s_layo.
    p_layout-excp_fname = 'LIGHT'.
ENDFORM.