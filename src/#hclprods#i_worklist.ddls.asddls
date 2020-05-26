@AbapCatalog.sqlViewName: '/HCLPRODS/IWL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Work List'
@VDM.viewType: #CONSUMPTION

define view /HCLPRODS/I_WorkList
  as select from /HCLPRODS/I_WorkListEvent as _event
  association [0..1] to /HCLPRODS/I_BowCommercialInfo as _comm on _comm.Notification = _event.Notification
  association        to parent /HCLPRODS/C_Bow        as _bow  on _bow.bowid = $projection.bowid
{

  key     _event.bowid,
          @UI.lineItem: [ { position: 10, importance: #HIGH } ]
  key     _event.Notification,
          @UI.hidden: true
          _event.Plant,
          @UI.hidden: true
          _event.Revision,
          _event.TlCounter,
          @UI.lineItem: [ { position: 20, importance: #HIGH } ]
          @EndUserText.label: 'Task List Type'
          _event.TaskListType,
          @UI.lineItem: [ { position: 30, importance: #HIGH } ]
          @EndUserText.label: 'Task List Group'
          _event.TaskListGroupKey,
          @UI.lineItem: [ { position: 40, importance: #HIGH } ]
          @EndUserText.label: 'Group Counter'
          _event.GroupCounter,
         _event.Equipment,
          _event.NotificationType,
          @EndUserText.label: 'Notification Description'
          _event.NotificationDescription,
          _event.CreatedBy,
//          _event.NotificationCreatedOn,
          @EndUserText.label: 'Service Order'
          _event.WorkOrder,
          _event.Material,
          _event.SalesDocument,
          _event.Floc,
          @UI.lineItem: [ { position: 50, importance: #HIGH } ]
          _event.DocumentNumber,
          @UI.lineItem: [ { position: 60, importance: #HIGH } ]
          _event.DocumentPart,
          @UI.lineItem: [ { position: 70, importance: #HIGH } ]
          _event.DocumentType,
          @UI.lineItem: [ { position: 80, importance: #HIGH } ]
          _event.DocumentVersion,
//          _comm.SalesDocCreatedOn,
          _comm.SalesDocumentType,
          _comm.SalesOrganisation,
          _comm.DistributionChannel,
          _comm.Division,
          _comm.SalesGroup,
          _comm.SalesOffice,
          @EndUserText.label: 'Sold to Party'
          _comm.Cutomer,
          _comm.ChangedOn,
          _comm.Project,
          @EndUserText.label: 'Currency'
          _comm.waerk,
           @EndUserText.label: 'Aircraft Maintenance Check Type'
          _comm.AircraftMaintenanceCheckType,
          _bow

}
