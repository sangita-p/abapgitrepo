@AbapCatalog.sqlViewName: '/HCLPRODS/BOWVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOW ID Value Help'
@Search.searchable: true
@VDM.viewType: #BASIC

//******************************************************************************************************************************
// Note: This is a consumption Value Help view for BOW ID field. it is a custom field and belongs to table /hclprods/bowh, 
//       so this value help has been built upon the DB table /hclprods/bowh and used for the field BOWID in Consumption view
//       /HCLPRODS/C_BOW
//******************************************************************************************************************************

define view /HCLPRODS/C_BowIdVH
  as select from /hclprods/bowh

{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'BOW ID'
      @Search.ranking: #HIGH
  key bowid,

      @EndUserText.label: 'Description'
      @Search.ranking: #HIGH
      bowtxt,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'BOW Type'
      @UI.hidden: true
      bowty,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'BOW Status'
      @UI.hidden: true
      status
}
