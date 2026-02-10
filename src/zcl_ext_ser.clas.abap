CLASS zcl_ext_ser DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ext_ser IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " 1.
    TRY.
        DATA(lo_dest) = cl_http_destination_provider=>create_by_url(
            i_url = 'https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata4/sap/api_producttype/srvd_a2x/sap/producttype/0001/ProductType?$top=50' ).
      CATCH cx_http_dest_provider_error.
        " handle exception
    ENDTRY.

    " 2.
    TRY.
        DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_dest ).
      CATCH cx_web_http_client_error.
        " handle exception
    ENDTRY.

    " 3.
    DATA(lo_req) = lo_client->get_http_request( ).

    " 4.
    TRY.
        lo_req->set_header_fields( i_fields = VALUE #( (  name = 'APIKey' value = 'rnvBFmeNMR8sjrTYQGENKXD6YZlz8UZ2' )
                                                       (  name = 'DataServiceVersion' value = '2.0' )
                                                       (  name = 'Accept' value = 'application/json' ) ) ).
      CATCH cx_web_message_error.
        " handle exception
    ENDTRY.

    " 5.
    TRY.
        DATA(lo_res) = lo_client->execute( i_method = if_web_http_client=>get ).
      CATCH cx_web_http_client_error.
        " handle exception
    ENDTRY.

    " 6.
    TRY.
        DATA(lv_status) = lo_res->get_status( ).
      CATCH cx_web_message_error.
        " handle exception
    ENDTRY.

    " 7.
    IF lv_status-code = 200.
      TRY.
          DATA(lv_text) = lo_res->get_text( ).
        CATCH cx_web_message_error.
          " handle exception
      ENDTRY.
    ENDIF.

    " 8.
    out->write( data = lv_text ).
  ENDMETHOD.
ENDCLASS.
