@AbapCatalog.sqlViewName: '/HCLPRODS/DOMVAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data model to provide domain fixed value help'
@Search.searchable: true
@VDM.viewType: #BASIC

//******************************************************************************************************************************
// Note: This is a basic view to fetch the FIXED Values on domain level for any domain. This has been further consumed in Value Help
//       Consumption Views /HCLPRODS/C_BOWSTATUSVH and /HCLPRODS/C_BOWTYPEVH 
//******************************************************************************************************************************

define view /HCLPRODS/I_DomainValues
  as select from    dd07l as FixedValue
    left outer join dd07t as ValueText on  FixedValue.domname    = ValueText.domname
                                       and FixedValue.domvalue_l = ValueText.domvalue_l
                                       and FixedValue.as4local   = ValueText.as4local

{
      @UI.hidden
  key FixedValue.domname    as DomainName,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key FixedValue.domvalue_l as Low,

      @UI.hidden
      FixedValue.as4local   as Status,

      @Semantics.text: true -- identifies the text field
      @Search.ranking: #HIGH
      ValueText.ddtext      as Text
}

where
      FixedValue.as4local  = 'A' --Active
  and ValueText.ddlanguage = $session.system_language
