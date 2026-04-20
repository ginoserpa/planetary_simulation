using DifferentialEquations
using OrdinaryDiffEq

include("constants.jl")
include("dynamics.jl")

# ---- RK4 on flat state -----------------------------------------------------
u0, t_span = get_initial_state()
prob_rk = ODEProblem(f!, u0, t_span)
sol_RK = solve(prob_rk, RK4(), dt = days_to_seconds(1))

# ---- Verlet leapfrog on split state ----------------------------------------
x0, v0, t_span = get_initial_state_split()
prob_lf = DynamicalODEProblem(f_vel!, f_pos!, v0, x0, t_span)
sol_LF = solve(prob_lf, VerletLeapfrog(), dt = days_to_seconds(1))

# ---- Energy analysis -------------------------------------------------------
energy_flat(u) = 0.5*m_earth*(u[3]^2 + u[4]^2) -
                 G*m_sun*m_earth / sqrt(u[1]^2 + u[2]^2)

function energy_ap(u)
    v, x = u.x[1], u.x[2]
    0.5*m_earth*(v[1]^2 + v[2]^2) - G*m_sun*m_earth / sqrt(x[1]^2 + x[2]^2)
end

E_rk = [energy_flat(u) for u in sol_RK.u]
E_lf = [energy_ap(u)   for u in sol_LF.u]

println("=== Integration (10 years, dt = 1 day) ===")
println("RK4 steps      = ", length(sol_RK.t))
println("Leapfrog steps = ", length(sol_LF.t))
println()
println("Initial energy (J): ", E_rk[1])
println()
println("Final E / E0:")
println("  RK4       : ", E_rk[end] / E_rk[1])
println("  Leapfrog  : ", E_lf[end] / E_lf[1])
println()
println("Max |(E - E0)/E0| over run:")
println("  RK4       : ", maximum(abs.((E_rk .- E_rk[1]) ./ E_rk[1])))
println("  Leapfrog  : ", maximum(abs.((E_lf .- E_lf[1]) ./ E_lf[1])))
println()

rk_end = sol_RK.u[end]
lf_end = sol_LF.u[end]
r_rk = sqrt(rk_end[1]^2 + rk_end[2]^2) / AU
r_lf = sqrt(lf_end.x[2][1]^2 + lf_end.x[2][2]^2) / AU
println("Final orbital radius (AU, should stay ~1.0):")
println("  RK4       : ", r_rk)
println("  Leapfrog  : ", r_lf)
