# PERFORM ON COMMIT
Subroutine을 호출할 때 ON COMMIT/ROLLBACK 옵션을 사용하면, COMMIT WORK 또는 ROLLBACK WORK 구문을 만날 때 FORM이 실행된다.

- **USING PERFORM ON COMMIT : COMMIT WORK를 만나면 서브루틴 구문을 호출한다.**
- **USING PERFORM ON ROLLBACK : ROLLBACK WORK를 만나면 서브루틴 구문을 호출한다.**

```ABAP
REPORT Z04_15.

DATA : gs_scarr LIKE scarr,
       gv_flg TYPE c.

SELECT SINGLE * FROM scarr INTO gs_scarr
    WHERE carrid = 'AA'.

PERFORM delete_data USING gs_scarr.

PERFORM insert_data ON COMMIT.

IF gv_flg = 'X'.
    COMMIT WORK.
ENDIF.

FORM delete_data USING value(os_scarr) TYPE scarr.

    DELETE scarr FROM ps_scarr.
    IF sy-subrc EQ 0.
        gv_flg = 'X'.
    ENDIF.
ENDFORM.

FORM insert_data.
    INSERT scarr FROM gs_scarr.
ENDFORM.    
```

FORM delete_data가 성공하면 gv_flg = 'X'로 값을 변경하고, COMMIT WORK가 수행될 때 PERFORM insert_data 구문이 수행된다. <br>
디버깅을 걸어서 수행 절차를 확인해본다.