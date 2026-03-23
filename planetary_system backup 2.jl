### A Pluto.jl notebook ###
# v0.20.24

using Markdown
using InteractiveUtils

# ╔═╡ 64b2e35a-9b37-456b-a8f2-4a1097a09cc2
using DifferentialEquations

# ╔═╡ 9d2c074d-3a3f-4ec5-8cde-5b6eab7a9d99
md"""
# The Earth sun system
"""

# ╔═╡ 510d9158-2574-11f1-998c-954ac65d7cdf
md"""
## The simplest version, version v.0

The force according to what we were told in primary school: $F = G \frac{m_1 m_2}{r^2}$

But we were also told $F=ma$ so in this case: $a=G \frac{m_2}{r^2}$ where conveniently the mass of the earth has dissapeared.

We know that for a particle in circular motion the acceleration has to be $a = \frac{v^2}{r}$

Putting the last two equations together we get: $v=\sqrt{\frac{G m_2}{r}}$

Finally from this we should get  $T =\frac{2\pi r}{v}$. So if given $m_2, r,$ and $ G$ we can calculate the time for one orbit that better be close to $365$ days 
"""

# ╔═╡ 75f96237-a5f3-4f95-afa2-e1139ad0afc7
begin
	# Physical constants
	m_sun = 1.989e30 
	G = 6.674e-11
	r = 149.6e9
	nothing
end

# ╔═╡ 264bb58e-74e2-4224-bdbc-f8351fc9512a
begin
	v = sqrt(G*m_sun/r)
	t = (2 * pi * r)/v
	nothing
end

# ╔═╡ da533c3c-881b-4404-af42-a88fe36671fb
println(t/(60*60*24))

# ╔═╡ 03793a53-4864-40f0-8c76-a789065920f0
md"""
## Success!! 
But this does not explain non circular orbits   
"""

# ╔═╡ 26380cc3-f445-45db-bde8-2dc128b14f59
md"""
## Next step in sophistication 
## version v.1.0
Assume the sun does not move but the earth does. So now the equation is not easy to solve exactly. It does have a close solution though (more later).
We will just write the equation and try to solve it numerically just for the heck of it.
"""

# ╔═╡ d3ac9188-0507-4baf-bed0-4966dc8d7707
md"""
So now the equation for the acceleration is $\frac{d^2r}{dt^2} = G \frac{m_{sun}}{r^2}$ but we are not assuming a circular orbit. The shape will be determined by the initial conditions for the position $r_0$ and velocity $v_0$, both vectors. 
"""

# ╔═╡ 89ac0a24-a533-474a-98c4-5f13c7bdaf38
md"""
This is a second order differential equation but we make the following change of variables:

$z_1= x, z_2 = y, z_3 = \frac{dx}{dt}, z_4 = \frac{dy}{dt}$

and it now looks like a first order differential equation of four variables variables

$
\frac{d}{dt}
\begin{pmatrix} z_1 \\ z_2 \\ z_3 \\ z_4 \end{pmatrix} =

\begin{pmatrix} z_3 \\ 
                z_4 \\ 
                G \frac{m_{sun}}{(z_1^2+z_2^2)^{3/2}} z_1\\ 
                G \frac{m_{sun}}{(z_1^2+z_2^2)^{3/2}} z_2 \end{pmatrix}$

where we need to provide 4 initial conditions $(x_0, y_0, v_{x_0}, v_{y_0})$ that are the initial values of the $z_i$

"""

# ╔═╡ 4f5bf48f-f387-43f4-984a-739bb7229dfd


# ╔═╡ Cell order:
# ╟─9d2c074d-3a3f-4ec5-8cde-5b6eab7a9d99
# ╟─510d9158-2574-11f1-998c-954ac65d7cdf
# ╠═75f96237-a5f3-4f95-afa2-e1139ad0afc7
# ╠═264bb58e-74e2-4224-bdbc-f8351fc9512a
# ╠═da533c3c-881b-4404-af42-a88fe36671fb
# ╟─03793a53-4864-40f0-8c76-a789065920f0
# ╟─26380cc3-f445-45db-bde8-2dc128b14f59
# ╟─d3ac9188-0507-4baf-bed0-4966dc8d7707
# ╠═89ac0a24-a533-474a-98c4-5f13c7bdaf38
# ╠═64b2e35a-9b37-456b-a8f2-4a1097a09cc2
# ╠═4f5bf48f-f387-43f4-984a-739bb7229dfd
