CLASS lhc_C_Bow DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /HCLPRODS/C_Bow.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /HCLPRODS/C_Bow.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /HCLPRODS/C_Bow.

    METHODS read FOR READ
      IMPORTING keys FOR READ /HCLPRODS/C_Bow RESULT result.

    METHODS   get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR /HCLPRODS/C_Bow RESULT result.

ENDCLASS.

CLASS lhc_C_Bow IMPLEMENTATION.

  METHOD create.
    DATA: lw_bowh     TYPE /hclprods/bowh,
          lt_messages TYPE stty_message,
          ls_messages TYPE sstr_message,
          lt_failed   TYPE TABLE FOR FAILED /hclprods/c_bow,
          lt_reported TYPE TABLE FOR REPORTED /hclprods/c_bow,
          lv_nr_range TYPE nrobj,    "RVARI_VAL_255.
          lv_msgv1    TYPE symsgv.

    CLEAR: lv_nr_range.
    SELECT SINGLE low FROM tvarvc INTO lv_nr_range WHERE name = '/HCLPRODS/BOW'.  "Constant Table

    IF sy-subrc IS NOT INITIAL.
      ls_messages-type     = 'E'.
      ls_messages-id       = '/HCLPRODS/BOW_MSG'.
      ls_messages-number     = '001'.                "Number Range is not maintained for object &1
      ls_messages-message_v1     = '/HCLPRODS/BOW'.  "Object Name in TVARVC table
      APPEND ls_messages TO lt_messages.
      CLEAR ls_messages.

      /hclprods/bow_message_handling=>handle_bow_messages(
            EXPORTING
              it_messages = lt_messages
            CHANGING
              failed = failed-/hclprods/c_bow
              reported = reported-/hclprods/c_bow ).
    ENDIF.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entities>).

      CLEAR: lw_bowh.
      lw_bowh = CORRESPONDING #( <fs_entities> MAPPING FROM ENTITY USING CONTROL ).

      IF lw_bowh-bowty IS NOT INITIAL AND lw_bowh-bowtxt IS NOT INITIAL. "Mandatory Input fields entered at the UI popup

        CALL FUNCTION 'NUMBER_GET_NEXT'
          EXPORTING
            nr_range_nr             = '01'
            object                  = lv_nr_range
            quantity                = '1'
          IMPORTING
            number                  = lw_bowh-bowid
          EXCEPTIONS
            interval_not_found      = 1
            number_range_not_intern = 2
            object_not_found        = 3
            quantity_is_0           = 4
            quantity_is_not_1       = 5
            interval_overflow       = 6
            buffer_overflow         = 7.

        IF sy-subrc IS INITIAL.

          lw_bowh-ernam = sy-uname.               "Default Value of UserName
          lw_bowh-erdat = sy-datum.               "Default Value of Date
          lw_bowh-status = 'Inactive'.            "Default value until an event is attached to BOW

          MODIFY /hclprods/bowh FROM lw_bowh.

          IF sy-subrc IS INITIAL.

            ls_messages-type     = 'S'.
            ls_messages-id       = '/HCLPRODS/BOW_MSG'.
            ls_messages-number     = '000'.                      "BOW id &1 created
            ls_messages-message_v1     = lw_bowh-bowid.
            APPEND ls_messages TO lt_messages.
            CLEAR ls_messages.

            /hclprods/bow_message_handling=>handle_bow_messages(
                  EXPORTING
                iv_cid = <fs_entities>-%cid
                  iv_bowid = lw_bowh-bowid
                  it_messages = lt_messages
                CHANGING
                mapped = mapped-/hclprods/c_bow
                reported = reported-/hclprods/c_bow
                  ).
          ENDIF.

        ELSE.
          CASE sy-subrc.
            WHEN 1.
              lv_msgv1 = 'interval_not_found'.
            WHEN 2.
              lv_msgv1 = 'number_range_not_intern'.
            WHEN 3.
              lv_msgv1 = 'object_not_found'.
            WHEN 4.
              lv_msgv1 = 'quantity_is_0'.
            WHEN 5.
              lv_msgv1 = 'quantity_is_not_1'.
            WHEN 6.
              lv_msgv1 = 'interval_overflow'.
            WHEN 7.
              lv_msgv1 = 'buffer_overflow'.
          ENDCASE.

          ls_messages-type     = 'E'.
          ls_messages-id       = '/HCLPRODS/BOW_MSG'.
          ls_messages-number     = '002'.                "Internal Error(&1)
          ls_messages-message_v1     = lv_msgv1.
          APPEND ls_messages TO lt_messages.
          CLEAR ls_messages.

          /hclprods/bow_message_handling=>handle_bow_messages(
                EXPORTING
*                iv_cid = <fs_entities>-%cid
*                iv_bowid = lw_bowh-bowid
                it_messages = lt_messages
              CHANGING
              failed = failed-/hclprods/c_bow
              reported = reported-/hclprods/c_bow
                ).
        ENDIF.
      ENDIF.
      CLEAR: lw_bowh, lv_msgv1.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
*    DATA: lv_bowid TYPE /hclprods/bowid,
*          lw_bowh  TYPE /hclprods/bowh.
*
*    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_keys>).
*      CLEAR: lv_bowid.
*      lv_bowid = <fs_keys>-bowid.
*
*      SELECT SINGLE * FROM /hclprods/bowh INTO lw_bowh WHERE bowid = lv_bowid.
*
*      IF sy-subrc IS INITIAL.
*
*        IF lw_bowh-status = 'I'.
*          lw_bowh-status = 'D'.
*          MODIFY /hclprods/bowh FROM lw_bowh.
*        ENDIF.
*      ENDIF.
*
*    ENDLOOP.

  ENDMETHOD.

  METHOD update.
    DATA: lw_bowh     TYPE /hclprods/bowh,
          ls_update   TYPE /hclprods/bowh,
          lt_messages TYPE stty_message,
          ls_messages TYPE sstr_message,
          lt_failed   TYPE TABLE FOR FAILED /hclprods/c_bow,
          lt_reported TYPE TABLE FOR REPORTED /hclprods/c_bow,
          lv_msgv1    TYPE symsgv,
          lv_msgv2    TYPE symsgv,
          lv_revnr    TYPE revni,
          lv_plant    TYPE iwerk,
          ls_result   TYPE /HCLPRODS/C_BowHeader,
          lv_pronr    TYPE ps_psp_pro.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entities>).
      CLEAR: lw_bowh.
      lw_bowh = CORRESPONDING #( <fs_entities> MAPPING FROM ENTITY ).

      IF lw_bowh-bowid IS NOT INITIAL.
        CLEAR: ls_update.
        SELECT SINGLE * FROM /hclprods/bowh INTO ls_update WHERE bowid = lw_bowh-bowid.
        IF sy-subrc IS NOT INITIAL.
          CLEAR: ls_update.
        ENDIF.
      ENDIF.

      IF lw_bowh-revnr IS NOT INITIAL AND lw_bowh-iwerk IS NOT INITIAL.

        CLEAR: lv_revnr, lv_plant.

        lv_revnr = lw_bowh-revnr.
        lv_plant = lw_bowh-iwerk.

        SELECT DISTINCT * FROM /HCLPRODS/C_BowHeader
        INTO TABLE @DATA(lt_result)
          WHERE Revision = @lv_revnr
          AND   Plant = @lv_plant
          AND   ( NotificationType = 'R1'
          OR    NotificationType = 'R2'
          OR    NotificationType = 'R3'
          OR    NotificationType = 'R4' ).

        IF sy-subrc IS INITIAL.

          READ TABLE lt_result INTO ls_result INDEX 1.

          IF sy-subrc IS INITIAL.

            SELECT SINGLE pronr FROM afko INTO lv_pronr WHERE aufnr = ls_result-OrderNumber.
            IF sy-subrc IS INITIAL.

              CALL FUNCTION 'CONVERSION_EXIT_KONPD_OUTPUT'
                EXPORTING
                  input  = lv_pronr
                IMPORTING
                  output = lv_pronr.

            ENDIF.

            ls_update-bowid   = lw_bowh-bowid.
*            ls_update-bowty   =                                "already updated at the time of BOW creation
*            ls_update-bowtxt   =                               "already updated at the time of BOW creation
            ls_update-status   = 'A'.
            ls_update-werks   = lv_plant.
*            ls_update-ernam   =                                 "already updated at the time of BOW creation
*            ls_update-erdat   =                                 "already updated at the time of BOW creation
            ls_update-aenam   = sy-uname.
            ls_update-aedat   = sy-datum.
*            ls_update-quote_type   =                            "already updated at the time of BOW creation
            ls_update-bow_date   = sy-datum.                     "Date on which an event has been linked to BOW Id
*            ls_update-auart   = ls_result-                      "it will be fetched from config
            ls_update-vkorg   = ls_result-SalesOrganisation.
            ls_update-vtweg   = ls_result-DistributionChannel.
            ls_update-spart   = ls_result-Division.
            ls_update-vkbur   = ls_result-SalesOffice.
            ls_update-vkgrp   = ls_result-SalesGroup.
            ls_update-kunag   = ls_result-Cutomer.
            ls_update-revnr   = lv_revnr.
            ls_update-iwerk   = lv_plant.
            ls_update-qmnum  = ls_result-Notification.
            ls_update-vbeln   = ls_result-SalesDocument.
*            ls_update-contract   = ls_result-                       "not required for the time
            ls_update-pronr   = lv_pronr.
*            ls_update-aufnr   = ls_result-OrderNumber.
            ls_update-matnr   = ls_result-material.
*            ls_update-menge   = ls_result-
*            ls_update-meins   = ls_result-
            ls_update-equnr   = ls_result-Equipment.
            ls_update-tplnr   = ls_result-Floc.
            ls_update-no_dup_tl   = abap_true.
            ls_update-skip_tl   = ' '.
*            ls_update-loekz   = ls_result-                           "not required

            MODIFY /hclprods/bowh FROM ls_update.

            IF sy-subrc IS INITIAL.
              ls_messages-type     = 'S'.
              ls_messages-id       = '/HCLPRODS/BOW_MSG'.
              ls_messages-number     = '004'.                      "Revision & is attached to BOW Id &
              ls_messages-message_v1     = lv_revnr.
              ls_messages-message_v2     = lw_bowh-bowid.
              APPEND ls_messages TO lt_messages.
              CLEAR ls_messages.

              /hclprods/bow_message_handling=>handle_bow_messages(
                    EXPORTING
*                iv_cid = <fs_entities>-%cid
*                  iv_bowid = lw_bowh-bowid
                    it_messages = lt_messages
                  CHANGING
                  mapped = mapped-/hclprods/c_bow
                  reported = reported-/hclprods/c_bow
                    ).
            ENDIF.
          ENDIF.

        ELSE.
          ls_messages-type     = 'E'.
          ls_messages-id       = '/HCLPRODS/BOW_MSG'.
          ls_messages-number     = '003'.                "No data exist for Revision & and Plant &
          ls_messages-message_v1     = lv_revnr.
          ls_messages-message_v2     = lv_plant.
          APPEND ls_messages TO lt_messages.
          CLEAR ls_messages.

          /hclprods/bow_message_handling=>handle_bow_messages(
                EXPORTING
*                iv_cid = <fs_entities>-%cid
*                iv_bowid = lw_bowh-bowid
                it_messages = lt_messages
              CHANGING
              failed = failed-/hclprods/c_bow
              reported = reported-/hclprods/c_bow
                ).

        ENDIF.
      ENDIF.
      CLEAR: ls_messages, lv_msgv1, lv_msgv2, lv_pronr.
    ENDLOOP.

  ENDMETHOD.

  METHOD read.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_keys>).
    ENDLOOP.

  ENDMETHOD.

  METHOD get_features.

    " Read data required
    READ ENTITY /hclprods/c_bow
*    FIELDS ( status )
    FROM VALUE #( FOR keyval IN keys ( %key = keyval-%key ) ) RESULT DATA(lt_result).
    " Return feature control information
    result = VALUE #( FOR ls_variable IN lt_result ( %key = ls_variable-%key

" Operation (example: update) control information
               %features-%delete             = COND #( WHEN ls_variable-status = 'A'
                                                       THEN if_abap_behv=>fc-o-disabled
                                                      ELSE if_abap_behv=>fc-o-enabled   )

   ) ).

  ENDMETHOD.
ENDCLASS.

CLASS lsc_C_Bow DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.

ENDCLASS.

CLASS lsc_C_Bow IMPLEMENTATION.

  METHOD check_before_save.

  ENDMETHOD.

  METHOD finalize.

  ENDMETHOD.

  METHOD save.

  ENDMETHOD.

ENDCLASS.
