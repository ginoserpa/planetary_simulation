# First-order form for non-symplectic solvers (RK4, etc.)
function f!(du, u, p, t)
	x, y, vx, vy = u
	r = sqrt(x^2+y^2)
	du[1] = vx
	du[2] = vy
	du[3] = -G * m_sun * x / r^3
	du[4] = -G * m_sun * y / r^3
end

# Second-order split form for symplectic solvers (DynamicalODEProblem)
# f_vel! gives dv/dt (acceleration from gravity)
function f_vel!(dv, v, x, p, t)
	r = sqrt(x[1]^2 + x[2]^2)
	dv[1] = -G * m_sun * x[1] / r^3
	dv[2] = -G * m_sun * x[2] / r^3
end

# f_pos! gives dx/dt = v
function f_pos!(dx, v, x, p, t)
	dx[1] = v[1]
	dx[2] = v[2]
end

# Flat initial state for first-order solvers
function get_initial_state()
	v = sqrt(G*m_sun/r_earth)
	u0 = [r_earth, 0.0, 0.0, v]
	tspan = (0.0, years_to_seconds(10))
	return u0, tspan
end

# Split initial state for symplectic solvers
function get_initial_state_split()
	v_mag = sqrt(G*m_sun/r_earth)
	x0 = [r_earth, 0.0]
	v0 = [0.0, v_mag]
	tspan = (0.0, years_to_seconds(10))
	return x0, v0, tspan
end

years_to_seconds(years) = years * days_to_seconds(365)
days_to_seconds(days) = days * 24 * 60 * 60
