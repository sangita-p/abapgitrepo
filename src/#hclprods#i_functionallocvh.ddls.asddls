@AbapCatalog.sqlViewName: '/HCLPRODS/IFLOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Functional Location'

//******************************************************************************************************************************
// Note: This is a basic Value Help view for Functional Location written to be consumed in /HCLPRODS/C_FunctionalLocVH
// Important Information: Functional Location is a standard field and there is already a SAP delivered CDS view for FLOC value help
//                        but that can not be used here becausehere RAP model has been used for the CRUD operations and RAP does not
//                        allow a field which has Conversion Exit maintained. It gives error during the service binding.
//                        Field TPLNR in table IFLOT has a conversion exit maintained.
//******************************************************************************************************************************

define view /HCLPRODS/I_FunctionalLocVH
  as select from iflot
  association [0..1] to iflotx on  iflotx.tplnr = iflot.tplnr
                               and iflotx.spras = $session.system_language


{
  key cast( iflot.tplnr as abap.char( 30 ) ) as FunctionalLocation,
      iflotx.pltxt
}
