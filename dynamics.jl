function f!(du, u, p, t)
	x, y, vx, vy = u
	r = sqrt(x^2+y^2)
	du[1] = vx
	du[2] = vy
	du[3] = -G * m_sun * x / r^3
	du[4] = -G * m_sun * y / r^3
end

function get_initial_state()
	v = sqrt(G*m_sun/r_earth)
	u0 = [r_earth, 0.0, 0.0, v]
	tspan = (0.0, years_to_seconds(10))
	return u0, tspan
end

years_to_seconds(years) = years * days_to_seconds(365)
days_to_seconds(days) = days * 24 * 60 * 60
