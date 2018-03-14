using RStan
using Distributions
using Base.Test

# write your own tests here



function coveragetest()
    X = Normal()
    n = 50
    xs = rand(X, n)
    β0 = 2
    β1 = 0.75
    λ = exp.(2 + 0.75 * xs)
    ys = rand.(Poisson.(λ))
    model = "
    data {
        int n;
	    real x[n];
	    int y[n];
    }
    parameters {
        vector[2] beta;
    }
    model {
        beta ~ normal(0, 5);
        for (i in 1:n){
            y[i] ~ poisson(exp(beta[1] + beta[2] * x[i]));
        }
    }
    "
    data = Dict("n" => n, "x" => xs, "y" => ys)
    
    res = rstan(model, data, 1000, nchains = 4, pars = "beta")
    mat = res[:beta]
    quants0 = quantile(mat[:, 1], [0.25, 0.75])
    quants1 = quantile(mat[:, 2], [0.25, 0.75])

    test1 = β0 > quants0[1] && β0 < quants0[2]
    test2 = β1 > quants1[1] && β1 < quants1[2]
    test1, test2
end

function gencoverages()
    N = 100
    resmat = Matrix{Bool}(2, N)
    for i in 1:N
        resmat[:, i] .= coveragetest()
    end
    resmat
end

resmat = gencoverages()
coverage = mean(resmat, 2)

@testset "Poisson Interval Coverage Test" begin
    @test coverage[1] > 0.4 && coverage[1] < 0.6
    @test coverage[2] > 0.4 && coverage[2] < 0.6
end