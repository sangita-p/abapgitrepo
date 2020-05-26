@AbapCatalog.sqlViewName: '/HCLPRODS/IWG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Work Group'
@VDM.viewType: #BASIC

//**********************************************************************************
// Note: This is a Basic view and is created to fetch the Work Group List
//**********************************************************************************

define view /HCLPRODS/I_WorkGroup as select from /hclprods/wghdr as _wghdr
//  association [0..*] to /hclprods/wgcust as _wgcust on $projection.workgroup = _wgcust.workgroup
//  association [0..*] to /hclprods/wgplnt as _wgplnt on $projection.workgroup = _wgplnt.workgroup
{
 
  key _wghdr.workgroup, 
      _wghdr.description, 
      _wghdr.matnr, 
      _wghdr.bill_method
//      _wghdr.ltext
//      _wgcust.kunnr,
//      _wgplnt.werks

}
