@AbapCatalog.sqlViewName: '/HCLPRODS/IBOWH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data model for BOW application landing page'
@VDM.viewType: #BASIC

//******************************************************************************************************************************
// Note: This is a basic view and has been created to build the landing page of fiori application for BOW(On-prem version)
//      and to display the list of BOW IDs created in the system.This has been further used in Consumption view /HCLPRODS/C_Bow
// @UI.identification: {position: 20, importance: #HIGH} = This determines the sequence of fields in Object View floorplan page
//                                                         in general Information section
// @UI.selectionField: [{position: 10 }] = To make the field available as a filter in filter bar
// @UI.lineItem: { position: 10, importance: #HIGH } = To decide the position of column in list and make it default visible
//                                                     in the list at the time of page loading
//******************************************************************************************************************************

define view /HCLPRODS/I_Bow
  as select from /hclprods/bowh as _bowh

{
  key _bowh.bowid,
      _bowh.bowty,
      _bowh.bowtxt,
      _bowh.status,
      _bowh.werks,
      _bowh.ernam,
      _bowh.erdat,
      _bowh.aenam,
      _bowh.aedat,
      _bowh.quote_type,
      _bowh.bow_date,
      _bowh.auart,
      _bowh.vkorg,
      _bowh.vtweg,
      _bowh.spart,
      _bowh.vkbur,
      _bowh.vkgrp,
      _bowh.kunag,
      _bowh.revnr,
      _bowh.iwerk,
      _bowh.qmnum,
      _bowh.vbeln,
      _bowh.contract,
      _bowh.pronr,
      _bowh.aufnr,
      _bowh.matnr,
      _bowh.menge,
      _bowh.meins,
      _bowh.equnr,
      _bowh.tplnr,
      _bowh.no_dup_tl,
      _bowh.skip_tl,
      _bowh.loekz
}
