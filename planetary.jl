using DifferentialEquations

include("constants.jl")
include("dynamics.jl")
include("plotting.jl")	


v = circular_speed(r_earth)
u0 = initial_state(r_earth, v)
t_span = (0.0, 60*60*24*365*10)


prob = ODEProblem(f!, u0, t_span)
sol  = solve(prob, RK4(), dt = 60*60*24)

x = [u[1]/AU for u in sol.u]
y = [u[2]/AU for u in sol.u]

time_years = sol.t ./ (60*60*24*365)
ke = [u[3]^2 + u[4]^2 for u in sol.u] .* (m_earth/2)
ke ./= ke[1]


show_windows(plot_orbit(x, y), 
             plot_energy(time_years, ke))




