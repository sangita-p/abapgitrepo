@AbapCatalog.sqlViewName: '/HCLPRODS/BOWREV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bow''s Revision'

define view /HCLPRODS/I_BowLinkedRevision
  as select from /hclprods/bowh as _bowh
  association [0..1] to /HCLPRODS/I_Diwps as _diwps on  _diwps.Revision = _bowh.revnr
                                                    and _diwps.Plant    = _bowh.iwerk
{

  key _bowh.bowid,
      _diwps.Plant,
      _diwps.Revision,
      _diwps.Notification,
      _diwps.TlCounter,
      _diwps.TaskListType,
      _diwps.TaskListGroupKey,
      _diwps.GroupCounter,
      _diwps.OrderNumber,
      _diwps.WorkOrder
}
