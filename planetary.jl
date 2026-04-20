using DifferentialEquations
using OrdinaryDiffEq

include("constants.jl")
include("dynamics.jl")
include("plotting.jl")	

# RK4: use flat first-order ODEProblem
u0, t_span = get_initial_state()
prob_rk = ODEProblem(f!, u0, t_span)
sol_RK = solve(prob_rk,
               RK4(),
               dt = days_to_seconds(1))

# Symplectic: use DynamicalODEProblem with (f_vel, f_pos, v0, x0, tspan)
x0, v0, t_span = get_initial_state_split()
prob_lf = DynamicalODEProblem(f_vel!, f_pos!, v0, x0, t_span)
sol_LF = solve(prob_lf,
               VerletLeapfrog(),
               dt = days_to_seconds(1))

show_windows(plot_orbit(sol_RK),
             plot_energy(sol_RK),
             plot_orbit(sol_LF),
             plot_energy(sol_LF))

show_windows(plot_orbit(sol_RK), 
             plot_energy(sol_RK),
             plot_orbit(sol_LF),
             plot_energy(sol_LF))       