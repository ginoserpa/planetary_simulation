using GLMakie

function plot_orbit(x, y)
    fig, ax, _ = lines(x, y;
        label = "Orbit",
        axis = (xlabel = "x (AU)", ylabel = "y (AU)",
                title = "Sun Earth System", aspect = DataAspect()))
    axislegend(ax)
    return fig
end

function plot_energy(t_years, ke)
    fig, ax, _ = lines(t_years, ke;
        label = "kinetic energy",
        axis = (xlabel = "time (years)", ylabel = "kinetic energy",
                title = "RK solver"))
    axislegend(ax)
    return fig
end

function show_windows(figs...)
    screens = [display(GLMakie.Screen(), f) for f in figs]
    foreach(wait, screens)
end