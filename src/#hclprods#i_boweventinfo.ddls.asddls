@AbapCatalog.sqlViewName: '/HCLPRODS/IEVNT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bow Header Event Info'
@VDM.viewType: #COMPOSITE

//******************************************************************************************************************************
// Note: This is a Composite Basic view and is created to fetch the Notification list for a Revision and will be consumed in
//       Consumption view /HCLPRODS/C_BowHeader
//******************************************************************************************************************************

define view /HCLPRODS/I_BowEventInfo
  as select from /HCLPRODS/I_Diwps as _diwps
  association [0..1] to viqmel as _qmel on _qmel.qmnum = _diwps.Notification
 
{
  key  _diwps.Plant,
  key  _diwps.Revision,
       _diwps.TlCounter,
       _diwps.TaskListType,
       _diwps.TaskListGroupKey,
       _diwps.GroupCounter,
       _diwps.OrderNumber,
       _qmel.qmnum                            as Notification,
       _qmel.equnr                            as Equipment,
       _qmel.qmart                            as NotificationType,
       _qmel.qmtxt                            as NotificationDescription,
       _qmel.ernam                            as CreatedBy,
       _qmel.erdat                            as NotificationCreatedOn,
       _qmel.matnr                            as Material,
       _qmel.vbeln                            as SalesDocument,
       cast( _qmel.tplnr as abap.char( 30 ) ) as Floc
}
