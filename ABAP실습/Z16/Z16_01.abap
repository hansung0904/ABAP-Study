REPORT Z16_01.

DATA gt_itab TYPE TABLE OF sflight.

SELECT * FROM sflight INTO TABLE gt_itab
UP TO 25 ROWS.

CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
        i_structure_name = 'SFLIGHT'
    TABLES
        t_outtab = gt_itab.    