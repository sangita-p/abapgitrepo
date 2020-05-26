//GENERATED:004:ZDpK08xG7jU}eBgLtOZvI0
@AbapCatalog.sqlViewName: '/HCLPRODS/FLOCVH'
@AbapCatalog.compiler.compareFilter: true

@VDM.viewType: #COMPOSITE

@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'FunctionalLocation'

@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L

@AccessControl.authorizationCheck: #CHECK
@AccessControl.privilegedAssociations: ['_FunctionalLocationText']

@ClientHandling.algorithm: #SESSION_VARIABLE

@Metadata.ignorePropagatedAnnotations: true

@EndUserText.label: 'Functional Location Value Help'

//******************************************************************************************************************************
// Note: This is a consumption Value Help view for Functional Location written on top of /HCLPRODS/I_FunctionalLocVH 
// Important Information: Functional Location is a standard field and there is already a SAP delivered CDS view for FLOC value help
//                        but that can not be used here becausehere RAP model has been used for the CRUD operations and RAP does not
//                        allow a field which has Conversion Exit maintained. It gives error during the service binding.
//                        Field TPLNR in table IFLOT has a conversion exit maintained.
//******************************************************************************************************************************

define view /HCLPRODS/C_FunctionalLocVH
  as select from /HCLPRODS/I_FunctionalLocVH as _floc
{
       @EndUserText.label: 'Functional Location'
  key  _floc.FunctionalLocation,
       @EndUserText.label: 'Description'
       _floc.pltxt

}
