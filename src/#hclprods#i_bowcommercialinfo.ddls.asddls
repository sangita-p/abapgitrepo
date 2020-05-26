@AbapCatalog.sqlViewName: '/HCLPRODS/ICOMM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bow Header Commercial Info'
@VDM.viewType: #COMPOSITE

//******************************************************************************************************************************
// Note: This is the Composite basic view and has been created to fetch the Sales data based on the Induction Notification
//       and will be consumed in Consumption view /HCLPRODS/C_BowHeader
//******************************************************************************************************************************

define view /HCLPRODS/I_BowCommercialInfo
  as select from viqmel as _qmel
  association [0..1] to vbak as _vbak on _vbak.vbeln = _qmel.vbeln
{
  key   _qmel.qmnum                                as Notification,
        _qmel.vbeln                                as SalesDocument,
        _qmel.amccd                                as AircraftMaintenanceCheckType,
        _vbak.erdat                                as SalesDocCreatedOn,
        _vbak.auart                                as SalesDocumentType,
        _vbak.vkorg                                as SalesOrganisation,
        _vbak.vtweg                                as DistributionChannel,
        _vbak.spart                                as Division,
        _vbak.vkgrp                                as SalesGroup,
        _vbak.vkbur                                as SalesOffice,
        _vbak.kunnr                                as Cutomer,
        _vbak.aedat                                as ChangedOn,
        cast( _vbak.ps_psp_pnr as abap.numc( 8 ) ) as Project,
        _vbak.waerk
}
