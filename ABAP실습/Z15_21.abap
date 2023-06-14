REPORT Z15_21.
--------------> 중략 <--------------
DATA : BEGIN OF gt_sflight OCCURS 0.
        INCLUDE STRUCTURE sflight.
    DATA : linecolor(4) TYPE c.
DATA : END OF gt_sflight.        
--------------> 중략 <--------------
    LOOP AT gt_sflight.
        CASE gt_sflight-carrid.
            WHEN 'AA'.
                gt_sflight-linecolor = 'C100'.
            WHEN 'AZ'.
                gt_sflight-linecolor = 'C300'.
            WHEN 'DL'
                gt_sflight-linecolor = 'C500'.
        ENDCASE.    
    MODIFY gt_sflight.
    ENDLOOP.    
--------------> 중략 <--------------
FORM setting_layout CHANGING p_layout TYPE lvc_s_layo.
--------------> 중략 <--------------
* coloring row
p_layout-INFO_FNAME = 'LINECOLOR'.
ENDFORM.