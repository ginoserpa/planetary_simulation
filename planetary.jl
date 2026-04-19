using DifferentialEquations
using OrdinaryDiffEq

include("constants.jl")
include("dynamics.jl")
include("plotting.jl")	

# Define initial state and solve the ODE
u0, t_span = get_initial_state()
prob = ODEProblem(f!, u0, t_span)
sol_RK = solve(prob, 
               RK4(), 
               dt = days_to_seconds(1))
sol_LF = solve(prob, 
               VerletLeapfrog(), 
               dt = days_to_seconds(1))

show_windows(plot_orbit(sol_RK), 
             plot_energy(sol_RK),
             plot_orbit(sol_LF),
             plot_energy(sol_LF))       