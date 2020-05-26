@AbapCatalog.sqlViewName: '/HCLPRODS/CBMVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing Method Value Help CDS'
@Search.searchable: true
@VDM.viewType: #BASIC


//******************************************************************************************************************************
// Note: This is a consumption Value Help view for Billing Method field value help. it is a custom field and belongs to table /axonblm/biltxt, 
//       so this value help has been built upon the DB table /hclprods/wghdr and used for the field BILL_METHOD in Consumption view
//       /HCLPRODS/C_WG
//******************************************************************************************************************************


define view /HCLPRODS/C_BillingMethodVH as select from /axonblm/biltxt {
 
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Billing Method'
      @Search.ranking: #HIGH
  key bill_method,
  
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Language'
      @Search.ranking: #HIGH
  key spras,
    
      @EndUserText.label: 'Description'
      @Search.ranking: #HIGH
      bezei
      
}
