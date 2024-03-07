#include "fabm_driver.h"

module pisces_migration_vertical_distribution

use fabm_types
use fabm_expressions
use pisces_shared ! ecosmo_shared

private 

type, extends(type_base_model), public :: type_pisces_migration_vertical_distribution
    type (type_diagnostic_variable_id) :: id_present    , id_diag_parmean
    type (type_dependency_id)          :: id_par, id_parmean
    type (type_horizontal_dependency_id) :: id_par0, id_parmean0 
    type (type_surface_diagnostic_variable_id) :: id_par0_diag
    real(rk) :: par_ez_percent
    real(rk) :: par_upper_bottom_percent
    real(rk) :: par_lower_bottom_percent
    contains
        procedure :: initialize 
        procedure :: do     
end type

contains

   subroutine initialize(self, configunit)
      class (type_pisces_migration_vertical_distribution), intent(inout), target :: self
      integer,                            intent(in)            :: configunit
      real(rk) :: par, par0, parmean, parmean0,weights

      call self%get_parameter(self%par_ez_percent,'par_ez_percent','%','% of surface light at the bottom of ez', default=0.5_rk, scale_factor=0.01_rk)
      call self%get_parameter(self%par_upper_bottom_percent,'par_upper_bottom_percent','%','% of surface light where migrators swim for avoiding predation, upper limit', default=0.05_rk, scale_factor=0.01_rk)
      call self%get_parameter(self%par_lower_bottom_percent,'par_lower_bottom_percent','%','% of surface light where migrators swim for avoiding predation, lower limit', default=0.00001_rk, scale_factor=0.01_rk)

      call self%register_diagnostic_variable(self%id_present,'migrator_presence','-','migrators are present here')
      call self%register_dependency(self%id_par, standard_variables%downwelling_photosynthetic_radiative_flux)
      call self%register_dependency(self%id_par0, standard_variables%surface_downwelling_photosynthetic_radiative_flux)
      !call self%register_dependency(self%id_par0, 'par0', 'W m-2', 'instantaneous surface PAR ')
      call self%register_dependency(self%id_parmean0,temporal_mean(self%id_par0,period=86400._rk,resolution=3600._rk))
      call self%register_dependency(self%id_parmean,temporal_mean(self%id_par,period=86400._rk,resolution=3600._rk))
      !call self%register_dependency(self%id_depth,standard_variables%depth)
      !call self%register_diagnostic_variable(self%id_par0_diag,'par0_diag','-','par0 variable for diagnostic')

      call self%register_diagnostic_variable(self%id_diag_parmean, 'parmean', 'W m-2', 'temporal mean of PAR')

   end subroutine initialize

   subroutine do(self, _ARGUMENTS_DO_)
    class (type_pisces_migration_vertical_distribution), intent(in) :: self
    _DECLARE_ARGUMENTS_DO_

    real(rk) :: par, par0, parmean, parmean0, ratio
    real(rk) :: weights
    real(rk) :: upper, lower, percent_upper_random, percent_lower_random

    call random_seed()

   _LOOP_BEGIN_

    !call random_seed()

    !_GET_SURFACE_(self%id_parmean0,parmean0)
    !_GET_SURFACE_(self%id_par0,par0)
    _GET_HORIZONTAL_(self%id_par0,par0)
    _GET_HORIZONTAL_(self%id_parmean0,parmean0)
     

    !_SET_SURFACE_DIAGNOSTIC_(self%id_par0_diag, toto)


    if (par0 < 1E-4_rk) then
        ratio = 1.0_rk 
        upper = (1.0_rk - self%par_upper_bottom_percent) * ratio + self%par_upper_bottom_percent
        lower = (self%par_ez_percent - self%par_lower_bottom_percent) * ratio + self%par_lower_bottom_percent
        !write(*,*)'par0 <1e-4 , parmean0 ',par0,parmean0
    else 
        ratio = min( par0/parmean0, 1.0_rk )
        !write(*,*)'par0  , parmean0 ',par0,parmean0
        upper = (1.0_rk - self%par_upper_bottom_percent) * (1.0_rk - ratio)**4.0_rk + self%par_upper_bottom_percent
        lower = (self%par_ez_percent - self%par_lower_bottom_percent) * (1.0_rk - ratio/(ratio+0.35_rk))**8.0_rk + self%par_lower_bottom_percent
    end if     

    call random_number(percent_upper_random)
    percent_upper_random = -0.75 + (0.75 - (-0.75)) * percent_upper_random
    upper = upper + percent_upper_random * upper
    call random_number(percent_lower_random)
    percent_lower_random = -0.75 + (0.75 - (-0.75)) * percent_lower_random
    lower = lower + percent_lower_random * lower   



  !  _LOOP_BEGIN_
        _GET_(self%id_par,par)
        _GET_(self%id_parmean,parmean)
       !write(*,*)'par0 = ' , par0 

        if (par0 < 1.E-4_rk) then
            if (parmean <= upper * parmean0 .and. parmean >= lower * parmean0) then
                _SET_DIAGNOSTIC_(self%id_present,1.0_rk)
            else
                _SET_DIAGNOSTIC_(self%id_present,0.0_rk)
            end if
        else
            if (par <= upper * par0 .and. par >= lower * par0) then
                _SET_DIAGNOSTIC_(self%id_present,1.0_rk)
            else
                _SET_DIAGNOSTIC_(self%id_present,0.0_rk)
            end if
        end if

      _SET_DIAGNOSTIC_(self%id_diag_parmean,parmean)

    _LOOP_END_

   
    end subroutine do

end module
