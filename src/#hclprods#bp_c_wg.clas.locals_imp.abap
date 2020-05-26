*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhc_C_WG DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /HCLPRODS/C_WorkGroup.

"    METHODS delete FOR MODIFY
 "     IMPORTING keys FOR DELETE /HCLPRODS/C_WORKGROUP.

  "  METHODS update FOR MODIFY
   "   IMPORTING entities FOR UPDATE /HCLPRODS/C_WORKGROUP.

*    METHODS read FOR READ
*      IMPORTING keys FOR READ /HCLPRODS/C_WG RESULT result.


ENDCLASS.

CLASS lhc_C_WG IMPLEMENTATION.

  METHOD create.
    DATA: lwa_wghdr     TYPE /hclprods/wghdr,
          lt_messages TYPE stty_message,
          ls_messages TYPE sstr_message,
          lt_failed   TYPE TABLE FOR FAILED /HCLPRODS/C_WorkGroup,
          lt_reported TYPE TABLE FOR REPORTED /HCLPRODS/C_WorkGroup,
          lv_msgv1    TYPE symsgv.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entities>).

      CLEAR: lwa_wghdr.
* Map All fields from UI to Backend
      lwa_wghdr = CORRESPONDING #( <fs_entities> MAPPING FROM ENTITY USING CONTROL ).

       "IF sy-subrc IS INITIAL.
          select SINGLE workgroup from /hclprods/wghdr where workgroup = @lwa_wghdr-workgroup
                  INTO @DATA(lv_workgroup).
          if sy-subrc <> 0.

          MODIFY /hclprods/wghdr FROM lwa_wghdr.


          IF sy-subrc IS INITIAL.

            ls_messages-type     = 'S'.
            ls_messages-id       = '/HCLPRODS/WG_MSG'.
            ls_messages-number     = '000'.                      "Work Group &1 created
            ls_messages-message_v1     = lwa_wghdr-workgroup.
            APPEND ls_messages TO lt_messages.
            CLEAR ls_messages.

            /hclprods/wg_message_handling=>handle_wg_messages(
                 EXPORTING
                  iv_cid = <fs_entities>-%cid
                  iv_wgid = lwa_wghdr-workgroup
                  it_messages = lt_messages
                CHANGING
                mapped = mapped-/HCLPRODS/C_workgroup
                reported = reported-/HCLPRODS/C_workgroup
                  ).
          ENDIF.
        else.
            ls_messages-type     = 'E'.
            ls_messages-id       = '/HCLPRODS/WG_MSG'.
            ls_messages-number     = '007'.                      "Work Group &1 Already created
            ls_messages-message_v1     = lwa_wghdr-workgroup.
            APPEND ls_messages TO lt_messages.
            CLEAR ls_messages.

            /hclprods/wg_message_handling=>handle_wg_messages(
                 EXPORTING
                  iv_cid = <fs_entities>-%cid
                  iv_wgid = lwa_wghdr-workgroup
                  it_messages = lt_messages
                CHANGING
                mapped = mapped-/HCLPRODS/C_workgroup
                reported = reported-/HCLPRODS/C_workgroup
                  ).
        endif.

     " ENDIF.

      CLEAR: lwa_wghdr, lv_msgv1.
    ENDLOOP.
  ENDMETHOD.

 " METHOD delete.
  "  DATA: lv_workgroup TYPE /hclprods/workgroup,
   "       lwa_wghdr  TYPE /hclprods/wghdr.

    "LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_keys>).
     " CLEAR: lv_workgroup.
      "lv_workgroup = <fs_keys>-workgroup.

      "SELECT SINGLE * FROM /hclprods/wghdr INTO lwa_wghdr WHERE workgroup = lv_workgroup.

      "IF sy-subrc IS INITIAL.

"          delete /hclprods/wghdr FROM lwa_wghdr.
      "ENDIF.

   " ENDLOOP.

  "ENDMETHOD.

  "METHOD update.

  "ENDMETHOD.


ENDCLASS.


CLASS lsc_C_WG DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.

ENDCLASS.

CLASS lsc_C_WG IMPLEMENTATION.

  METHOD check_before_save.

  ENDMETHOD.

  METHOD finalize.

  ENDMETHOD.

  METHOD save.

  ENDMETHOD.

ENDCLASS.
