# 필드 심볼 활용
## 인터널 테이블 LOOP 처리
필드 심볼은 인터널 테이블을 LOOP 수행할 때도 아주 편리하다.<br>
항공사 이름을 가져와서 인터널 테이블을 변경하는 경우에 필드 심볼을 사용하는 예제와 Work Area에 복사해서 <br>
MODIFY 하는 예제 두 개를 비교해보자. <br><br> **물론 두 테이블을 JOIN 하는 것이 훨씬 효율적이다** <br>

```ABAP
REPORT Z10 10.
DATA: BEGIN OF gs_line,
    carrid TYPE sflight-carrid,
    connid TYPE sflight-connid,
carrname TYPE scarr-carrname,
END OF gs_line.

DATA gt_itab LIKE TABLE OF gs_line.
FIELD-SYMBOLS <fs> like gs一line.

SELECT carrid connid
INTO CORRESPONDING FIELDS OF TABLE gt_itab
FROM sflight.

LOOP AT gt_itab ASSIGNING <fs>.

    SELECT SINGLE carrname INTO <fs>-carrname
    FROM scarr WHERE carrid = <fs>-carrid.
ENDLOOP.
```
```ABAP
REPORT Z10_ll.
DATA: BEGIN OF gs_line,
    carrid TYPE sflight-carrid,
    connid TYPE sflight-connid,
    carrname TYPE scarr-carrname,
END OF gs_line.

DATA gt_itab LIKE TABLE OF gs_line.

SELECT carrid connid
INTO CORRESPONDING FIELDS OF TABLE gt_itab
FROM sflight.

LOOP AT gt_itab INTO gs_line.

SELECT SINGLE carrname INTO gs_line-carrname
FROM scarr WHERE carrid = gs_line-carrid.

MODIFY gt_itab FROM gs_line.

ENDLOOP.
```