@AbapCatalog.sqlViewName: '/HCLPRODS/CHEAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bow Header'
@VDM.viewType: #CONSUMPTION

//******************************************************************************************************************************
// Note: This is the Consumption view and has been created to fetch the BOW Header details while performing the "Add Event" action
//******************************************************************************************************************************

define view /HCLPRODS/C_BowHeader
  as select from /HCLPRODS/I_BowEventInfo as _event
  association [0..1] to /HCLPRODS/I_BowCommercialInfo as _comm on _comm.Notification = _event.Notification
{
  key _event.Plant,
  key _event.Revision,
//      _event.BowId,
      _event.TlCounter,
      _event.TaskListType,
      _event.TaskListGroupKey,
      _event.GroupCounter,
      _event.Notification,
      _event.Equipment,
      _event.NotificationType,
      _event.NotificationDescription,
      _event.CreatedBy,
      _event.NotificationCreatedOn,
      _event.OrderNumber,
      _event.Material,
      _event.SalesDocument,
      _event.Floc,
      _comm.SalesDocCreatedOn,
      _comm.SalesDocumentType,
      _comm.SalesOrganisation,
      _comm.DistributionChannel,
      _comm.Division,
      _comm.SalesGroup,
      _comm.SalesOffice,
      _comm.Cutomer,
      _comm.ChangedOn,
      _comm.Project
 }
