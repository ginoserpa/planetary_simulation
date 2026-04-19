using GLMakie

function plot_orbit(sol)
    x = [u[1]/AU for u in sol.u]
    y = [u[2]/AU for u in sol.u]
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
    ke = [u[3]^2 + u[4]^2 for u in sol.u] .* (m_earth/2)
    ke ./= ke[1]

    fig, ax, _ = lines(t_years, ke;
        label = "kinetic energy",
        axis = (xlabel = "time (years)", ylabel = "kinetic energy",
                title = "Kinetic Energy variation over time"))
    axislegend(ax)
    return fig
end

function show_windows(figs...)
    screens = [display(GLMakie.Screen(), f) for f in figs]
    foreach(wait, screens)
end