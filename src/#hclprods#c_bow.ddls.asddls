@AbapCatalog.sqlViewName: '/HCLPRODS/CBOWH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bill of Work'                                               //Label
@VDM.viewType: #CONSUMPTION                                                      //To define the type in View Browser
@UI.headerInfo: { typeNamePlural: 'Bills of Work' }                              //For Table Title in List report
@Search.searchable: true
//@UI.presentationVariant: [{ sortOrder: [{by: 'bowid', direction: #DESC }] }]     //For Sorting

//******************************************************************************************************************************
// Note: This is the Consumption view and has been created to build the landing page of fiori application for BOW(On-prem version)
//      and to display the list of BOW IDs created in the system.This is using the basic view /HCLPRODS/I_Bow
//******************************************************************************************************************************

define root view /HCLPRODS/C_Bow
  as select from /HCLPRODS/I_Bow as _bowh
  association [0..1] to /HCLPRODS/C_BowStatusVH as _status_text on _status_text.Low = _bowh.status
  association [0..1] to /HCLPRODS/C_BowTypeVH   as _type_text   on _type_text.Low = _bowh.bowty
  composition [0..*] of /HCLPRODS/I_WorkList    as _wl
{
        @UI: {
                lineItem: [ { position: 10, importance: #HIGH } ],
                selectionField: [{position: 10 }]
                }
        @Consumption.valueHelpDefinition: [{ entity: { name: '/HCLPRODS/C_BowIdVH', element: 'bowid'}}]
        @EndUserText.label: 'Bill of Work'
  key   _bowh.bowid,

        //      @UI.selectionField: [{position: 50 }]
        @Consumption.valueHelpDefinition: [{ entity: { name: '/HCLPRODS/C_BowTypeVH', element: 'Low'}}]
        @EndUserText.label: 'Type'
        @ObjectModel.text.element: ['Type_Text']
        @UI.identification: [{position: 30 }]
        @ObjectModel.readOnly: true

        _bowh.bowty,
        @UI: {
        lineItem: [ { position: 20, importance: #HIGH } ],
        selectionField: [{position: 20 }]
        }
        @EndUserText.label: 'Description'
        @Search.ranking: #HIGH
        @UI.identification: [{position: 20 }]
        _bowh.bowtxt,

        @UI: {
        lineItem: [ { position: 60, importance: #HIGH, criticality:'Criticality'} ],
        selectionField: [{position: 40 }]
        }
        @Consumption.valueHelpDefinition: [{ entity: { name: '/HCLPRODS/C_BowStatusVH', element: 'Low'}}]
        @EndUserText.label: 'Status'
        @ObjectModel.text.element: ['Status_Text']
        //         @UI.fieldGroup: [ { qualifier: 'fgLastChanged', position: 10 } ]
        @UI.identification: [{position: 40 }]
        _bowh.status,
        //  ******************To assigna color to Status field************************
        case _bowh.status
        when 'A' then 3    //Green
        when 'I' then 2    //Yellow
        when 'D' then 1    //Red
        else 0             //Grey
        end                                    as Criticality,
        //  **************************************************************************
        _bowh.werks,

        @UI: {
        lineItem: [ { position: 70, importance: #HIGH } ],
        selectionField: [{position: 30 }]
        }
        @EndUserText.label: 'Created By'
        @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ChangeDocUser', element: 'UserName'}}]
        @UI.identification: [{position: 50 }]
        _bowh.ernam,

        @EndUserText.label: 'Created On'
        @UI.identification: [{position: 60 }]
        _bowh.erdat,

        @EndUserText.label: 'Changed By'
        @UI.identification: [{position: 70 }]
        _bowh.aenam,

        @EndUserText.label: 'Changed On'
        @UI.identification: [{position: 80 }]
        _bowh.aedat,

        @EndUserText.label: 'Quotation Type'
        //      @UI.identification: {position: 20}
        @ObjectModel.readOnly: true
        @UI.identification: [{position: 90 }]
        _bowh.quote_type,

        @UI.identification: [{position: 110 }]
        _bowh.bow_date,

        @UI.identification: [{position: 120 }]
        _bowh.auart,

        @UI.identification: [{position: 130 }]
        _bowh.vkorg,

        @UI.identification: [{position: 140 }]
        _bowh.vtweg,

        @UI.identification: [{position: 150 }]
        _bowh.spart,

        @EndUserText.label: 'Sales Office'
        @UI.identification: [{position: 160 }]
        _bowh.vkbur,

        @EndUserText.label: 'Sales Group'
        @UI.identification: [{position: 170 }]
        _bowh.vkgrp,
        @UI: {
        lineItem:{ position: 40, importance: #HIGH } }
        @UI.selectionField: [{position: 70 }]
        @Consumption.valueHelpDefinition: [{ entity: { name: 'C_PurOrdMaintainCustValHelp', element: 'Customer'}}]
        @UI.identification: [{position: 180 }]
        _bowh.kunag,

        @UI: {
        lineItem: [ { position: 30, importance: #HIGH } ],
        selectionField: [{position: 60 }]
        }
        @Consumption.valueHelpDefinition: [{ entity: { name: 'I_MaintenanceRevisionStdVH', element: 'MaintenanceRevision'}}]
        @UI.identification: [{position: 190 }]
        _bowh.revnr,

        @EndUserText.label: 'Plant for Revision'
        @UI.identification: [{position: 200 }]
        _bowh.iwerk,

        @UI.identification: [{position: 210 }]
        _bowh.qmnum,

        @EndUserText.label: 'Sales Document'
        @UI.identification: [{position: 220 }]
        _bowh.vbeln,

        @UI.identification: [{position: 230 }]
        _bowh.contract,

        @EndUserText.label: 'Project'
        @UI.identification: [{position: 240 }]
        cast( _bowh.pronr as abap.numc( 8 ))  as project,

        @UI.identification: [{position: 250 }]
        _bowh.aufnr,

        @UI.identification: [{position: 260 }]
        _bowh.matnr,

        @UI.identification: [{position: 270 }]
        _bowh.menge,

        @EndUserText.label: 'UoM'
        @UI.identification: [{position: 280 }]
        _bowh.meins,

        @UI.identification: [{position: 290 }]
        _bowh.equnr,
        @UI: {
        lineItem:{ position: 50, importance: #HIGH } }
        @UI.selectionField: [{position: 50 }]
        @EndUserText.label: 'Functional Location'
        @Consumption.valueHelpDefinition: [{ entity: { name: '/HCLPRODS/C_FunctionalLocVH', element: 'FunctionalLocation'}}]
        @UI.identification: [{position: 300 }]
        cast( _bowh.tplnr as abap.char( 30 ) ) as Floc,

        @EndUserText.label: 'Eliminate Duplicate Task List'
        _bowh.no_dup_tl,
        _bowh.skip_tl,

        @UI.hidden: true
        _bowh.loekz,

        @UI.hidden: true
        _status_text.Text                      as Status_Text,
        @UI.hidden: true
        _type_text.Text                        as Type_Text,
        //Associations
        _wl
}
