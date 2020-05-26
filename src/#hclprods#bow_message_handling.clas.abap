CLASS /hclprods/bow_message_handling DEFINITION
  PUBLIC
  INHERITING FROM cl_abap_behv
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES tt_bow_failed TYPE TABLE FOR FAILED /hclprods/c_bow.
    TYPES tt_bow_mapped TYPE TABLE FOR MAPPED /hclprods/c_bow.
    TYPES tt_bow_reported TYPE TABLE FOR REPORTED /hclprods/c_bow.

    CLASS-METHODS handle_bow_messages
      IMPORTING
        iv_cid      TYPE string OPTIONAL
        iv_bowid    TYPE /hclprods/bowid OPTIONAL
        it_messages TYPE stty_message
      CHANGING
        failed      TYPE tt_bow_failed OPTIONAL
        mapped      TYPE tt_bow_mapped OPTIONAL
        reported    TYPE tt_bow_reported OPTIONAL.


  PROTECTED SECTION.

  PRIVATE SECTION.
    CLASS-DATA obj TYPE REF TO /hclprods/bow_message_handling.
    CLASS-METHODS get_message_object
      RETURNING VALUE(r_result) TYPE REF TO /hclprods/bow_message_handling.

ENDCLASS.



CLASS /hclprods/bow_message_handling IMPLEMENTATION.

  METHOD handle_bow_messages.

    LOOP AT it_messages INTO DATA(ls_message).
      IF ls_message-type = 'S'.
        APPEND VALUE #( %cid = iv_cid bowid = iv_bowid ) TO mapped .

        APPEND VALUE #( %msg = get_message_object( )->new_message( id = ls_message-id
        number = ls_message-number
        severity = if_abap_behv_message=>severity-success
        v1 = ls_message-MESSAGE_v1
        v2 = ls_message-MESSAGE_v2
        v3 = ls_message-MESSAGE_v3
        v4 = ls_message-MESSAGE_v4 )

          %key-bowid = iv_bowid
          %cid = iv_cid
          bowid = iv_bowid ) TO reported.

      ELSEIF ls_message-type = 'E'.
        APPEND VALUE #( %cid = iv_cid bowid = iv_bowid ) TO failed .

        APPEND VALUE #( %msg = get_message_object( )->new_message( id = ls_message-id
        number = ls_message-number
        severity = if_abap_behv_message=>severity-error
        v1 = ls_message-MESSAGE_v1
        v2 = ls_message-MESSAGE_v2
        v3 = ls_message-MESSAGE_v3
        v4 = ls_message-MESSAGE_v4 )

          %key-bowid = iv_bowid
          %cid = iv_cid
          bowid = iv_bowid ) TO reported.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_message_object.
    IF obj IS INITIAL.
      CREATE OBJECT obj.
    ENDIF.
    r_result = obj.
  ENDMETHOD.
ENDCLASS.
