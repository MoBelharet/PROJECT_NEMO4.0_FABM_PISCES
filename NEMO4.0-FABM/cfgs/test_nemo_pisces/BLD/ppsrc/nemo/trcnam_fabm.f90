












MODULE trcnam_fabm
   !!======================================================================
   !!                      ***  MODULE trcnam_fabm  ***
   !! TOP :   initialisation of some run parameters for FABM bio-model
   !!======================================================================
   !! History :   2.0  !  2007-12  (C. Ethe, G. Madec) Original code
   !!----------------------------------------------------------------------
   USE trc             ! TOP variables
   !!----------------------------------------------------------------------
   !!  Dummy module :                                             No FABM
   !!----------------------------------------------------------------------
CONTAINS
   SUBROUTINE trc_nam_fabm                      ! Empty routine
   END  SUBROUTINE  trc_nam_fabm

   SUBROUTINE trc_nam_fabm_override(dummy)
       TYPE(PTRACER), DIMENSION(jpmaxtrc), INTENT(INOUT), optional :: dummy   
   END SUBROUTINE trc_nam_fabm_override

   !!======================================================================
END MODULE trcnam_fabm
