# SALV 기본 기능 구현
SALV에서 기본적으로 제공하는 기능(데이터 정렬, 필터링 설정 등)을 프로 그램에서 구현해보도록 한다.

## 데이터 정렬
데이터 정렬은 CL_SALV_SORTS 클래스를 참고하는 객체 참조 변수를 이용해서 구현한다. <BR>
GR_TABLE의 GET_SORT 메서드를 이용해서 정렬을 담당하는 ALV Object와 연결하고, <BR>
ADD_SORT 메서드를 통해서 정렬할 필드를 추가하게 된다.

## Aggregation 설정
CL_SALV_AGGREGATIONS 클래스를 이용해서 Numeric 타입의 칼럼 데이터를 합산할 수 있다. <br>
단순히 칼럼 레벨에서 합산하려면 데이터를 정렬할 필요가 없지만, <br>
Key 값의 코드에 따라서 부분합을 수행하려면 데이터가 먼저 정렬되어야 한다.

```abap
REPORT Z17_15.

DATA gt_itab    TYPE TABLE OF sflight.
DATA gr_table   TYPE REF TO cl_salv_table.
DATA gr_sorts   TYPE REF TO cl_salv_sors.
DATA gr_agg     TYPE REF TO cl_salv_aggregations.

SELECT * FROM sflight INTO CORRESPONDING FIEDLS OF TABLE gt_itab UP TO 25 ROWS.

cl_salv_table=>factory(
    IMPORTING
        r_salv_table = gr_table
    CHANGING
        t_table = gt_itab
).
gr_sourts = gr_table->get_sorts().
gr_sorts->add_sort(columnname = 'CONNID' subtotla = 'X').
gr_agg = gr_table->get_aggregations().
gr_agg->add_aggregation ('PRICE').

gr_table->display().
```

## 필터링 설정
필터링은 ALV 리스트에 조회되는 데이터 레코드를 제한한다. CL_SALV_FILTERS 클래스를 이용해서 <BR>
GR_TABLE의 GET_FILTERS 메서드로 설정한다. <BR>
ADD_FILTER 메서드를 통해서 필터링 설정 조건 및 칼럼을 추가하게 된다. <BR>
운항 연결 ID가 64번인 데이터만 조회되도록 필터링을 설정해보자.


```ABAP
REPORT Z17_06.

DATA gt_itab TYPE TABLE OF sflight.
DATA gr_table TYPE REF TO cl_salv_table.
DATA gr_filter TYPE REF TO cl_salv_filters.

SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_itab UP TO 25 ROWS.

cl_salv_table=>factory (
    IMPORTING
        r_salv_table = gr_table
    CHANGING
        t_table = gt_itab        
).

gs_filter = gr_table->get_filters().
gr_filter->add_filter(columname = 'CONNID'
    sign = 'I'
    option = 'EQ'
    low = '64'
).
gr_table->display().   
```