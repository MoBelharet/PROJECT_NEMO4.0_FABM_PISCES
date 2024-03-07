












MODULE trcsms_fabm
   !!======================================================================
   !!                         ***  MODULE trcsms_fabm  ***
   !! TOP :   Main module of the FABM tracers
   !!======================================================================
   !! History :   1.0  !  2015-04  (PML) Original code
   !!----------------------------------------------------------------------
   !!----------------------------------------------------------------------
   !!   Dummy module                                        No FABM model
   !!----------------------------------------------------------------------
CONTAINS
   SUBROUTINE trc_sms_fabm( kt )             ! Empty routine
      INTEGER, INTENT( in ) ::   kt
      WRITE(*,*) 'trc_sms_fabm: You should not have seen this print! error?', kt
   END SUBROUTINE trc_sms_fabm

   !!======================================================================
END MODULE trcsms_fabm
