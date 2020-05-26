@AbapCatalog.sqlViewName: '/HCLPRODS/WGVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Work Group Value Help'
@Search.searchable: true
@VDM.viewType: #BASIC

//******************************************************************************************************************************
// Note: This is a consumption Value Help view for Work Group field value help. it is a custom field and belongs to table /hclprods/wghdr, 
//       so this value help has been built upon the DB table /hclprods/wghdr and used for the field WORKGROUP in Consumption view
//       /HCLPRODS/C_WG
//******************************************************************************************************************************

define view /HCLPRODS/C_WGVH as select from /hclprods/wghdr {
    
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Work Group'
      @Search.ranking: #HIGH
  key workgroup,

      @EndUserText.label: 'Description'
      @Search.ranking: #HIGH
      description

}
