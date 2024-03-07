












MODULE trcrst_fabm
   !!======================================================================
   !!                      ***  MODULE trcrst_fabm  ***
   !! Read and write additional restart fields used by FABM
   !!======================================================================
   !! History :
   !!----------------------------------------------------------------------
   !!----------------------------------------------------------------------
   !!  Dummy module :                                             No FABM
   !!----------------------------------------------------------------------
CONTAINS
   SUBROUTINE trc_rst_read_fabm
   END  SUBROUTINE trc_rst_read_fabm

   SUBROUTINE trc_rst_wri_fabm(kt)
      INTEGER, INTENT( in ) ::   kt    ! ocean time-step index
   END SUBROUTINE trc_rst_wri_fabm

   !!======================================================================
END MODULE trcrst_fabm
