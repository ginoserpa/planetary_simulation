function f!(du, u, p, t)
	x, y, vx, vy = u
	r = sqrt(x^2+y^2)
	du[1] = vx
	du[2] = vy
	du[3] = -G * m_sun * x / r^3
	du[4] = -G * m_sun * y / r^3
end

initial_state(r, v)= [r, 0.0, 0.0 , v]
circular_speed(r) =  sqrt(G*m_sun / r)