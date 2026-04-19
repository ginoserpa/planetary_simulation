using DifferentialEquations

include("constants.jl")
include("dynamics.jl")
include("plotting.jl")	

# Define initial state and solve the ODE
u0, t_span = get_initial_state()
prob = ODEProblem(f!, u0, t_span)
sol  = solve(prob, RK4(), dt = days_to_seconds(1))


time_years = sol.t ./ (60*60*24*365)
ke = [u[3]^2 + u[4]^2 for u in sol.u] .* (m_earth/2)
ke ./= ke[1]

show_windows(plot_orbit(sol), 
             plot_energy(sol))

