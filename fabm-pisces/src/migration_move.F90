#include "fabm_driver.h"

module pisces_migration_move

use fabm_types
use fabm_expressions
use pisces_shared ! ecosmo_shared

private 

type, extends(type_base_model), public :: type_pisces_migration_move
    type (type_dependency_id)          :: id_random_weights
    type (type_dependency_id)          :: id_thickness
    type (type_state_variable_id)      :: id_target
    type (type_bottom_dependency_id)   :: id_integral
    type (type_bottom_dependency_id)   :: id_integral_random_weights
    type (type_diagnostic_variable_id)        :: id_distributed,id_mortality_switch, id_local_loss, id_local, id_term1, id_term2, id_diag_thickness, id_par_diag
    type (type_dependency_id)          :: id_par
    real(rk) :: tstep, m
    contains
        procedure :: initialize => move_initialize
        procedure :: do  => move_do
end type

contains

subroutine move_initialize(self, configunit)

    class (type_pisces_migration_move), intent(inout), target :: self
    integer,         intent(in)            :: configunit

    call self%register_state_dependency(self%id_target, 'target', '', 'variable to apply sources and sinks to')
    call self%register_dependency(self%id_random_weights,'migrator_random_weights','-','migrators distribution random weights')
    call self%register_dependency(self%id_integral,'integral','','depth-integrated target variable')
    call self%register_dependency(self%id_integral_random_weights,'migrator_integral_random_weights','','migrators distribution integral random weights')
    call self%register_diagnostic_variable(self%id_distributed,'migrator_distributed_weights','-','migrators distribution random weights', missing_value=0.0_rk, source=source_do)
    call self%register_diagnostic_variable(self%id_mortality_switch,'mortality_switch','-','mortality switch')
    call self%register_diagnostic_variable(self%id_local, 'local','-','the state variable to be updates')
    call self%register_diagnostic_variable(self%id_local_loss, 'local_loss','target_unit','loss in the state variable')
    call self%register_dependency(self%id_thickness, standard_variables%cell_thickness)
    call self%get_parameter( self%tstep,  'tstep',    'sec',      'time-step in seconds', default=300.0_rk)
    call self%register_dependency(self%id_par, standard_variables%downwelling_photosynthetic_radiative_flux)
    call self%get_parameter( self%m, 'm', '1/day', 'migrator mortality rate', default=0.10_rk) !,  scale_factor=1.0_rk/sedy0)

    call self%register_diagnostic_variable(self%id_term1, 'term1','-','term1 of sms')
    call self%register_diagnostic_variable(self%id_term2, 'term2','-','term2 of sms')
    call self%register_diagnostic_variable(self%id_diag_thickness, 'thickness','m','vertical resolution')
    call self%register_diagnostic_variable(self%id_par_diag,'par','W m-2','Photosynthetically available radiation')
    
end subroutine move_initialize

subroutine move_do(self, _ARGUMENTS_DO_)
    class (type_pisces_migration_move), intent(in) :: self
    _DECLARE_ARGUMENTS_DO_

    real(rk) :: integral, integral_random_weights, random_weights
    real(rk) :: local, distributed, thickness
    real(rk) :: par
    real(rk) :: mortality_switch, local_loss, term1, term2

    !_GET_BOTTOM_(self%id_integral,integral)
    !_GET_BOTTOM_(self%id_integral_random_weights,integral_random_weights)
    

    !write(*,*)integral
    _LOOP_BEGIN_
       
        _GET_BOTTOM_(self%id_integral,integral) ! Mokrane: moved from outside of this loop
        _GET_BOTTOM_(self%id_integral_random_weights,integral_random_weights) ! Mokrane: moved from outside of this loop

       _GET_(self%id_par,par)
       _GET_(self%id_target,local)
       _GET_(self%id_random_weights,random_weights)
       _GET_(self%id_thickness,thickness)

       _SET_DIAGNOSTIC_(self%id_local,local)

       distributed = random_weights / integral_random_weights ! this ensures that total weight distribution is 1, so mass conserved
      ! write(*,*)'integral = ', integral
       !write(*,*)'local  = ', local
       !write(*,*)'thickness  = ', thickness
       _SET_DIAGNOSTIC_(self%id_distributed,distributed)
       mortality_switch   = max(sign(-1.0_rk,par-1.0_rk),0.0_rk)
       _SET_DIAGNOSTIC_(self%id_mortality_switch,mortality_switch)
       !mortality_switch = max(0.0_rk, min(1.0_rk, par-1.0_rk) )
       local_loss   = max(sign(-1.0_rk,local-0.05_rk),0.0_rk) ! ECOSMO specific term, remove for other models
       _SET_DIAGNOSTIC_(self%id_local_loss, local_loss)
       !write(*,*)par,mortality_switch,local_loss,local
    
        term1 =  (-local  +  distributed * integral/thickness ) * xstep !-local
        term2 =  -local * xstep !local * (1.0_rk - mortality_switch) * local_loss * self%m *xstep

        _SET_DIAGNOSTIC_(self%id_term1, term1)
       _SET_DIAGNOSTIC_(self%id_term2, term2)


       !_ADD_SOURCE_(self%id_target, (distributed * integral/thickness - local )/self%tstep + local * (1.0_rk - mortality_switch) * local_loss * self%m * xstep)
       
       !write(*,*)'term1 = ', term1
       _ADD_SOURCE_(self%id_target, term1)

       !write(*,*)self%dt

        _SET_DIAGNOSTIC_(self%id_diag_thickness, thickness)

        _SET_DIAGNOSTIC_(self%id_par_diag , par)


    _LOOP_END_
 end subroutine move_do

end module
