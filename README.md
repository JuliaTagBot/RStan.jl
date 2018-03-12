# RStan

[![Build Status](https://travis-ci.org/chriselrod/RStan.jl.svg?branch=master)](https://travis-ci.org/chriselrod/RStan.jl)

[![Coverage Status](https://coveralls.io/repos/chriselrod/RStan.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/chriselrod/RStan.jl?branch=master)

[![codecov.io](http://codecov.io/github/chriselrod/RStan.jl/coverage.svg?branch=master)](http://codecov.io/github/chriselrod/RStan.jl?branch=master)


This is a very light wrapper to "rstan", using RCall.
The only exported function is "rstan". Upon initializing, it will automatically turn on for you:
```R
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
```
but print the recomendation to do so anyway.

Write your model in a character string, and submit that with your data in a dictionary.
```julia
data = Dict("x" => x, "N" => length(x))
rstan(model_code, data)
```