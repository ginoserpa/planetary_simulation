using DifferentialEquations
#using Plots
using GLMakie


# 			Physical constants
m_sun = 1.989e30      # kg
m_earth = 5.972e24    # kg
G = 6.674e-11
r = 149.6e9
AU = 1.496e11

v = sqrt(G*m_sun/r)
t = (2 * π * r)/v

println(t/(60*60*24))

function f!(du, u, p, t)
	x, y, vx, vy = u
	r = sqrt(x^2+y^2)
	du[1] = vx
	du[2] = vy
	du[3] = -G * m_sun * x / r^3
	du[4] = -G * m_sun * y / r^3
end

u0 = [r, 0, 0, v] 
t_span = [0.0, 60*60*24*365*10]

prob = ODEProblem(f!, u0, t_span)
sol = solve(prob, RK4(), dt = 60*60*24)

x = [sol.u[i][1]/AU for i in 1:length(sol.t)]
y = [sol.u[i][2]/AU for i in 1:length(sol.t)]

fig = lines(0:0.01:2*π, sin;linewidth=2)
display(fig)


#plot(x, y, 
#	 label="Orbit", xlabel="x (AU)", ylabel="y (AU)", title="Sun Earth System",
#	 aspect_ratio=1)

time = sol.t/(60*60*24*365)
kinetic_energy = [sol.u[i][1]^2+sol.u[i][2]^2 for i in 1:length(sol.t)]
kinetic_energy = (1/2) * m_earth * kinetic_energy
kinetic_energy/= kinetic_energy[1]
#plot(time, kinetic_energy, 
#	 label="kinetic energy", xlabel="time (years)", ylabel="kinetic energy",
#	 title="RK solver")