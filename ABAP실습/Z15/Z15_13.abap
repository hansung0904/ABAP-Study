REPORT Z15_13.
TYPE-POOLS: icon.
CLASS lcl_event_receiver DEFINITION.
    PUBLIC SECTION.
        METHODS : handle_toolbar
            FOR EVENT toolbar OF CL_GUI_ALV_GRID
            IMPORTING e_object e_interactive.
ENDCLASS.

CLASS lcl_event_receiver IMPLEMENTATION.
    METHOD handle_toolbar.

        DATA: ls_toolbar TYPE stb_button.

        CLEAR ls_toolbar.
        ls_toolbar-butn_type = 3.
        APPEND ls_toolbar TO e_object->mt_toolbar.

        CLEAR ls_toolbar.
        ls_toolbar-function = 'RESH'.
        ls_toolbar-icon = icon_refresh.
        ls_toolbar-quickinfo = 'Refresh'
        ls_toolbar-text = ' '.
        ls_toolbar-disabled = ' '.
        APPEND ls_toolbar TO e_object->mt_toolbar.

    ENDMETHOD.
ENDCLASS.
----------------> 중 략 <----------------
CREATE OBJECT event_receiver.
SET HANDLER event_receiver->handle_toolbar FOR g_grid.