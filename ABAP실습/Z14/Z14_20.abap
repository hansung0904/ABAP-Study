REPORT Z14_20.

DATA : go_obj TYPE REF TO zsflight.

START-OF-SELECTION.
CREATE OBJECT: go_obj.

SET HANDLER go_obj->no_data FOR: go_obj.

CALL METHOD go_obj->get_data.