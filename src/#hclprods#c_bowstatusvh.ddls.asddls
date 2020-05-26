@AbapCatalog.sqlViewName: '/HCLPRODS/STTSVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.resultSet.sizeCategory: #XS
@EndUserText.label: 'BOW Status Value Help'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION

//******************************************************************************************************************************
// Note: This is a consumption Value Help view for BOW Status field. it is a custom field and its possible values have been defined
//       at domain level. So this has been built upon the Basic view /HCLPRODS/I_DomainValues which fetches the domain level fixed
//       values
//******************************************************************************************************************************

define view /HCLPRODS/C_BowStatusVH
  as select from /HCLPRODS/I_DomainValues as _status
{
       //       @UI.hidden
       //  key  _status.DomainName,

       @EndUserText.label: 'Status'     -- Custom label text
       @ObjectModel.text.element: ['Text']
       @Search.ranking: #HIGH
  key  _status.Low,

       @Semantics.text: true            -- identifies the text field
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
       @Search.ranking: #HIGH
       _status.Text
}

where
  _status.DomainName = '/HCLPRODS/BOW_STAT'
