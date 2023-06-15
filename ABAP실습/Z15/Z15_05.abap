REPORT Z15_05.

DATA : con1_ref TYPE REF TO cl_gui_custom_container.

DATA : g_grid TYPE REF TO cl_gui_alv_grid.
       gs_variant LIKE idsvariant,
       gs_cs_variant LIKE disvariant,
       gt_sflight TYPE TABLE OF sflight.

PARAMETERS: p_vari LIKE disvariant-variant.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_vari.
    gs_variant-report = sy-repid.
    CALL FUNCTION 'REUSE_ALV_VARIANT_F4'
        EXPORTING
            is_variant = gs_variant
            is_save = 'A'
        IMPORTING    
            es_variant = gs_variant
        EXCEPTIONS
            not_found = 1
            program_error = 2
            OTHERS = 3.

    IF sy-subrc EQ 0.            
        p_vari = gs_variant-variant.
    ENDIF.

    START-OF-SELECTION.