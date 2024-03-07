












MODULE par_fabm


   IMPLICIT NONE
   
   INTEGER, PUBLIC :: jp_fabm0, jp_fabm1, jp_fabm, &
                      jp_fabm_surface, jp_fabm_bottom, &
                      jp_fabm_m1

   LOGICAL, PUBLIC, ALLOCATABLE, DIMENSION(:) ::   lk_rad_fabm !: FABM negativity correction flag array

   !!---------------------------------------------------------------------
   !!   Default                           No user defined tracers (FABM)
   !!---------------------------------------------------------------------
   LOGICAL, PUBLIC, PARAMETER ::   ln_fabm     = .FALSE.  !: FABM flag 

   !!======================================================================
END MODULE par_fabm
