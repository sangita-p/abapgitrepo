CLASS /hclprods/wg_message_handling DEFINITION
  PUBLIC
  INHERITING FROM cl_abap_behv
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES tt_WG_failed TYPE TABLE FOR FAILED /hclprods/c_WorkGroup.
    TYPES tt_WG_mapped TYPE TABLE FOR MAPPED /hclprods/c_WorkGroup.
    TYPES tt_WG_reported TYPE TABLE FOR REPORTED /hclprods/c_WorkGroup.

    CLASS-METHODS handle_WG_messages
      IMPORTING
        iv_cid      TYPE string OPTIONAL
        iv_WGid     TYPE /hclprods/Workgroup OPTIONAL
        it_messages TYPE stty_message
      CHANGING
        failed      TYPE tt_WG_failed OPTIONAL
        mapped      TYPE tt_WG_mapped OPTIONAL
        reported    TYPE tt_WG_reported OPTIONAL.


  PROTECTED SECTION.

  PRIVATE SECTION.
    CLASS-DATA obj TYPE REF TO /hclprods/wg_message_handling.
    CLASS-METHODS get_message_object
      RETURNING VALUE(r_result) TYPE REF TO /hclprods/wg_message_handling.

ENDCLASS.



CLASS /hclprods/wg_message_handling IMPLEMENTATION.

  METHOD handle_WG_messages.

    LOOP AT it_messages INTO DATA(ls_message).
      IF ls_message-type = 'S'.
        APPEND VALUE #( %cid = iv_cid workgroup = iv_wgid ) TO mapped .

        APPEND VALUE #( %msg = get_message_object( )->new_message( id = ls_message-id
        number = ls_message-number
        severity = if_abap_behv_message=>severity-success
        v1 = ls_message-MESSAGE_v1
        v2 = ls_message-MESSAGE_v2
        v3 = ls_message-MESSAGE_v3
        v4 = ls_message-MESSAGE_v4 )

          %key-workgroup = iv_WGid
          %cid = iv_cid
          workgroup = iv_WGid ) TO reported.

      ELSEIF ls_message-type = 'E'.
        APPEND VALUE #( %cid = iv_cid workgroup = iv_WGid ) TO failed .

        APPEND VALUE #( %msg = get_message_object( )->new_message( id = ls_message-id
        number = ls_message-number
        severity = if_abap_behv_message=>severity-error
        v1 = ls_message-MESSAGE_v1
        v2 = ls_message-MESSAGE_v2
        v3 = ls_message-MESSAGE_v3
        v4 = ls_message-MESSAGE_v4 )

          %key-Workgroup = iv_WGid
          %cid = iv_cid
          workgroup = iv_WGid ) TO reported.
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
