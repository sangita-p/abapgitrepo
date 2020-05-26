@AbapCatalog.sqlViewName: '/HCLPRODS/WLEVNT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Work List Event Info'

define view /HCLPRODS/I_WorkListEvent
  as select from /HCLPRODS/I_BowLinkedRevision as _diwps
  association [0..1] to viqmel as _qmel on _qmel.qmnum = _diwps.Notification
  association [0..1] to drad   as _drad on _drad.objky = _diwps.Notification
{
  key  _diwps.bowid,
       _diwps.Plant,
       _diwps.Revision,
       _diwps.TlCounter,
       _diwps.TaskListType,
       _diwps.TaskListGroupKey,
       _diwps.GroupCounter,
       _diwps.WorkOrder                       as WorkOrder,
       _qmel.qmnum                            as Notification,
       _qmel.equnr                            as Equipment,
       _qmel.qmart                            as NotificationType,
       _qmel.qmtxt                            as NotificationDescription,
       _qmel.ernam                            as CreatedBy,
       _qmel.erdat                            as NotificationCreatedOn,
       _qmel.matnr                            as Material,
       _qmel.vbeln                            as SalesDocument,
       cast( _qmel.tplnr as abap.char( 30 ) ) as Floc,
       _drad.dokar                            as DocumentType,
       _drad.doknr                            as DocumentNumber,
       _drad.doktl                            as DocumentPart,
       _drad.dokvr                            as DocumentVersion
}
