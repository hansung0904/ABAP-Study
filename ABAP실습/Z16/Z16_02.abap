REPORT Z16_02.

DATA gt_itab TYPE TABLE OF sflight.

SELECT * FROM sflight INTO TABLE gt_itab
UP TO 25 ROWS.

CALL FUNCTION 'REUSE_AVL_GRID_DISPLAY'
    EXPORTING
        i_structure_name = 'SFLIGHT'
    TABLES
        t_outtab         = gt_itab.            