@AbapCatalog.sqlViewName: '/HCLPRODS/CWG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true

@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Work Group'                                               //Label
@VDM.viewType: #CONSUMPTION                                                    //To define the type in View Browser
@UI.headerInfo: { typeNamePlural: 'Work Groups' }                          //For Table Title in List report
//@Search.searchable: true
@UI.presentationVariant: [{ sortOrder: [{by: 'workgroup'}] }]                  //For Sorting

//******************************************************************************************************************************
// Note: This is the Consumption view and has been created to build the landing page of fiori application for Work Group (On-prem version)
//       and to display the list of Work group created in the system. This is using the Composite view /HCLPRODS/I_WorkGroup
//******************************************************************************************************************************


define root view /HCLPRODS/C_WorkGroup
  as select from /HCLPRODS/I_WorkGroup as _WG

{

      @UI: {         
                     lineItem: [ { position: 10, importance: #HIGH } ],
                     selectionField: [{position: 10 }],
                     identification: [{position: 10 }]
                     
                     }
      @Consumption.valueHelpDefinition: [{ entity: { name: '/HCLPRODS/C_WGVH', element: 'workgroup' }}]  
      //@Consumption.filter.selectionType: #RANGE  
                             
      @EndUserText.label: 'Work Group'
      
      key _WG.workgroup,

      @UI: {
                      lineItem: [ { position: 20, importance: #HIGH } ],
                      selectionField: [{position: 20 }],
                      identification: [{position: 20 }]
                      }
      @EndUserText.label: 'Description'
      _WG.description,

      @UI: {
                      lineItem: [ { position: 50, importance: #HIGH } ],
                      selectionField: [{position: 50 }],
                      identification: [{position: 50 }]
                      }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_MaterialVH', element: 'Material' }}]                      
      @EndUserText.label: 'Material'
      _WG.matnr,
      @UI: {
                      lineItem: [ { position: 60, importance: #HIGH } ],
                      selectionField: [{position: 60 }],
                      identification: [{position: 60 }]
                      }
      @Consumption.valueHelpDefinition: [{ entity: { name: '/HCLPRODS/C_BillingMethodVH', element: 'bill_method' }}]                       
      @EndUserText.label: 'Billing Method'
      _WG.bill_method
      
//      @UI: {
//                      hidden: true
            //          lineItem: [ { position: 70, hidden: true,  importance: #HIGH } ],
            //          selectionField: [{position: 70 }]

//                      }
                            
//      @EndUserText.label: 'Long Text'
//      _WG.ltext
//      @UI: {
//                      lineItem: [ { position: 120, importance: #HIGH } ],
//                      selectionField: [{position: 120 }]
//                      }//      @EndUserText.label: 'Sold To Party'
//      _WG.kunnr,
//      @UI: {
//                      lineItem: [ { position: 130, importance: #HIGH } ],
//                      selectionField: [{position: 130 }]
//                      }
//      @EndUserText.label: 'Plant'
//      _WG.werks

}
