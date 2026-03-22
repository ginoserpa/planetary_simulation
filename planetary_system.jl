### A Pluto.jl notebook ###
# v0.20.24

using Markdown
using InteractiveUtils

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
Assume the sun does not move but the earth does. So now the equation is not easy to solve, it does have a close solution though (more later).
We will just write the equation and try to solve it numerically just for the heck of it.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.5"
manifest_format = "2.0"
project_hash = "71853c6197a6a7f222db0f1978c7cb232b87c5ee"

[deps]
"""

# ╔═╡ Cell order:
# ╟─9d2c074d-3a3f-4ec5-8cde-5b6eab7a9d99
# ╠═510d9158-2574-11f1-998c-954ac65d7cdf
# ╠═75f96237-a5f3-4f95-afa2-e1139ad0afc7
# ╠═264bb58e-74e2-4224-bdbc-f8351fc9512a
# ╠═da533c3c-881b-4404-af42-a88fe36671fb
# ╟─03793a53-4864-40f0-8c76-a789065920f0
# ╟─26380cc3-f445-45db-bde8-2dc128b14f59
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
