












MODULE trcwri_fabm
   !!======================================================================
   !!                       *** MODULE trcwri_fabm ***
   !!    fabm :   Output of FABM tracers
   !!======================================================================
   !! History :   1.0  !  2009-05 (C. Ethe)  Original code
   !!----------------------------------------------------------------------
   !!----------------------------------------------------------------------
   !!  Dummy module :                                     No passive tracer
   !!----------------------------------------------------------------------
   INTERFACE trc_wri_fabm
       MODULE PROCEDURE wri_fabm,wri_fabm_fl
   END INTERFACE trc_wri_fabm

   PUBLIC trc_wri_fabm

   CONTAINS

   SUBROUTINE wri_fabm_fl (kt, fl)
      INTEGER, INTENT( in )               :: fl
      INTEGER, INTENT( in )               :: kt
   END SUBROUTINE wri_fabm_fl

   SUBROUTINE wri_fabm (kt)                 ! Empty routine  
      INTEGER, INTENT( in )               :: kt
   END SUBROUTINE wri_fabm

   !!----------------------------------------------------------------------
   !! NEMO/TOP 4.0 , NEMO Consortium (2018)
   !! $Id: trcwri_fabm.F90 3160 2011-11-20 14:27:18Z cetlod $ 
   !! Software governed by the CeCILL licence (see ./LICENSE)
   !!======================================================================
END MODULE trcwri_fabm
