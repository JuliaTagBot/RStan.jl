__precompile__()

module RStan

using RCall
export rstan

include("init.jl")
include("stan_interface.jl")

end # module

