# Planetary Simulation

A small Julia project that integrates the Sun–Earth two-body problem and
compares a non-symplectic integrator (classical Runge–Kutta 4) against a
symplectic one (Verlet leapfrog) using
[`DifferentialEquations.jl`](https://docs.sciml.ai/DiffEqDocs/stable/).

## Files

- `constants.jl` — physical constants (`G`, `m_sun`, `m_earth`, `r_earth`, `AU`).
- `dynamics.jl` — two forms of the equations of motion plus initial-state helpers.
- `plotting.jl` — GLMakie helpers: orbit trace and relative-energy-drift plot.
- `planetary.jl` — main entry point: solves the problem with both integrators and
  opens four GLMakie windows.
- `verify.jl` — non-interactive verification script that prints energy-drift
  statistics for both integrators.

## Running

```
julia --project=. planetary.jl
```

Four plot windows open: orbits and energy-drift plots for each integrator.

For a non-interactive sanity check (no GLMakie windows):

```
julia --project=. verify.jl
```

## Equations of motion

Two equivalent formulations live in `dynamics.jl`:

1. **Flat first-order form `f!`** — state `u = [x, y, vx, vy]`, suitable for any
   `ODEProblem` solver (e.g. `RK4`).
2. **Split second-order form `f_vel!` / `f_pos!`** — the velocity update
   (`dv/dt = -GM·x/r³`) and the trivial position update (`dx/dt = v`), suitable
   for a `DynamicalODEProblem` which symplectic integrators such as
   `VerletLeapfrog` require.

`get_initial_state()` returns the flat initial state for (1); `get_initial_state_split()`
returns separate `x0`, `v0` vectors for (2).

## Integrator comparison

Running the Earth orbit for 10 years with `dt = 1 day`:

- **RK4** (`OrdinaryDiffEq.RK4()`) — adaptive by default, ~200 steps over the
  interval. Energy drifts **monotonically** by roughly **8.5 × 10⁻³** (≈ 0.85 %)
  over 10 years, and the orbital radius shrinks from 1.0 AU to ~0.991 AU.
- **Verlet leapfrog** (`OrdinaryDiffEq.VerletLeapfrog()`) — fixed 1-day steps
  (3651 steps). Energy stays within a **bounded oscillation of ~2 × 10⁻⁸** with
  no secular drift, and the orbital radius stays at 1.0 AU to within ~6 × 10⁻⁸.

This is the textbook distinction between the two classes of integrator:
Runge–Kutta 4 is high-order and locally accurate but not symplectic, so for
long-duration Hamiltonian integration its energy error accumulates
monotonically. The Verlet leapfrog is only second-order locally, but because
it preserves the symplectic two-form it conserves a *modified* Hamiltonian
exactly, so the actual energy error stays bounded for all time. For periodic
problems like planetary orbits this is almost always what you want.

### Caveats

- `solve(prob, RK4(), dt = …)` uses `dt` only as the initial step — RK4 is
  adaptive by default. Pass `adaptive = false` for an apples-to-apples
  fixed-step comparison (its drift will look even worse).
- Symplectic integrators in `OrdinaryDiffEq.jl` require a `DynamicalODEProblem`
  (or `SecondOrderODEProblem`). A plain `ODEProblem` with a flat state vector
  will not work — the correct name is `VerletLeapfrog`, not `VelocityLeapfrog`.

## Plots

`plot_energy` plots the **relative energy drift** `(E − E₀) / |E₀|` rather than
`E / E₀`. The symplectic error is so small that a raw `E / E₀` plot renders
every y-tick as `1.00000`; plotting the drift centers the signal at zero and a
scientific-notation tick formatter keeps the magnitude readable for both
integrators (10⁻⁸ for leapfrog, 10⁻³ for RK4).
