@AbapCatalog.sqlViewName: '/HCLPRODS/CWL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Work List'
@VDM.viewType: #CONSUMPTION

define view /HCLPRODS/C_WorkList
  as select from /HCLPRODS/I_WorkListEvent as _event
  association [0..1] to /HCLPRODS/I_BowCommercialInfo as _comm on _comm.Notification = _event.Notification
  //  association        to parent /HCLPRODS/C_Bow        as _bowh on _bowh.bowid = $projection.bowid
{
         @UI.hidden: true
  key    _event.bowid,
         @UI.hidden: true
         _event.Plant,
         @UI.hidden: true
         _event.Revision,
         _event.TlCounter,
         _event.TaskListType,
         _event.TaskListGroupKey,
         _event.GroupCounter,
         _event.Notification,
         _event.Equipment,
         _event.NotificationType,
         @EndUserText.label: 'Notification Description'
         _event.NotificationDescription,
         _event.CreatedBy,
         _event.NotificationCreatedOn,
         _event.WorkOrder,
         _event.Material,
         _event.SalesDocument,
         _event.Floc,
         _event.DocumentNumber,
         _event.DocumentPart,
         _event.DocumentType,
         _event.DocumentVersion,
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
         //         _bowh

}
