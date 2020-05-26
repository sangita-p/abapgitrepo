@AbapCatalog.sqlViewName: '/HCLPRODS/IWPS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Revision: Cross-Reference Notification'
@VDM.viewType:#BASIC

//******************************************************************************************************************************
// Note: This is a basic view to fetch the Revision and cross refernce Notification data from T352R and DIWPS_RV_CR tables
//******************************************************************************************************************************

define view /HCLPRODS/I_Diwps
//    as select from /HCLPRODS/I_Bow as _bowh
//    association [0..1] to t352r       as _t352r on  _t352r.revnr = _bowh.revnr
//                                                and _t352r.iwerk = _bowh.iwerk
//    association [0..*] to diwps_rv_cr as _diwps on  _diwps.iwerk = _bowh.iwerk
//                                                and _diwps.wpid  = _bowh.revnr
//  {
//    key _t352r.iwerk      as Plant,
//    key _t352r.revnr      as Revision,
//        _bowh.bowid       as BowId,
//        _diwps.notifid    as Notification,
//        _diwps.tl_counter as TlCounter,
//        _diwps.plnty      as TaskListType,
//        _diwps.plnnr      as TaskListGroupKey,
//        _diwps.plnal      as GroupCounter,
//        _diwps.order_no   as OrderNumber
//  }
  as select from t352r as _t352r
  association [0..*] to diwps_rv_cr as _diwps on  _diwps.iwerk = _t352r.iwerk
                                              and _diwps.wpid  = _t352r.revnr

{
  key _t352r.iwerk      as Plant,
  key _t352r.revnr      as Revision,
      _t352r.aufnr      as OrderNumber,
      _diwps.notifid    as Notification,
      _diwps.tl_counter as TlCounter,
      _diwps.plnty      as TaskListType,
      _diwps.plnnr      as TaskListGroupKey,
      _diwps.plnal      as GroupCounter,
      _diwps.order_no   as WorkOrder
}
