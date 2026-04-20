using GLMakie
using Printf

# Extract (x, y, vx, vy) from either a flat [x,y,vx,vy] state
# or an ArrayPartition((v, x)) produced by DynamicalODEProblem.
function _unpack(u)
    if hasproperty(u, :x) && u.x isa Tuple
        v, x = u.x[1], u.x[2]
        return x[1], x[2], v[1], v[2]
    else
        return u[1], u[2], u[3], u[4]
    end
end

function plot_orbit(sol)
    pts = [_unpack(u) for u in sol.u]
    x = [p[1]/AU for p in pts]
    y = [p[2]/AU for p in pts]
    fig, ax, _ = lines(x, y;
        label = "Orbit",
        axis = (xlabel = "x (AU)", ylabel = "y (AU)",
                title = "Sun Earth System",
                aspect = DataAspect()))
    axislegend(ax)
    return fig
end

function plot_energy(sol)
    t_years = sol.t ./ (60*60*24*365)
    pts = [_unpack(u) for u in sol.u]

    ke = [(p[3]^2 + p[4]^2) * (m_earth/2) for p in pts]
    pe = [-G * m_sun * m_earth / sqrt(p[1]^2 + p[2]^2) for p in pts]

    total_energy = ke .+ pe
    # Relative drift from initial energy: (E - E0) / |E0|
    rel_drift = (total_energy .- total_energy[1]) ./ abs(total_energy[1])

    fig, ax, _ = lines(t_years, rel_drift;
        label = "(E - E₀) / |E₀|",
        axis = (xlabel = "time (years)",
                ylabel = "relative energy drift",
                title = "Total Energy variation over time",
                ytickformat = vs -> [Printf.@sprintf("%.2e", v) for v in vs]))
    axislegend(ax)

    return fig
end

function show_windows(figs...)
    screens = [display(GLMakie.Screen(), f) for f in figs]
    foreach(wait, screens)
end