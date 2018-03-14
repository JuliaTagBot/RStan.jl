

"""
This function calls rstan.
It can be used as follows:

    rstan(model_code, data, iter = 1000; pars = missing, qnchains = 4, adapt_delta = 0.8, max_treedepth = 10)

    Feel free to edit this function and submit a pull request to add more functionality.
    The function can be edited by calling

    @edit rstan("", Dict())
    
    and a text editor should open up, pointing to this function.
    You may want to set your editor first, eg:
    ENV["EDITOR"] = "code"
"""
function rstan(model_code, data, iter = 1000; pars = missing, nchains = 4, adapt_delta = 0.8, max_treedepth = 10)
    @rput model_code
    @rput data
    @rput nchains
    @rput iter
    @rput pars
    R"res <- stan(model_code = model_code, data = data, iter = iter, pars = pars, chains = nchains, control = list(adapt_delta = $adapt_delta, max_treedepth = $max_treedepth))"
    R"samples <- rstan::extract(res)"
    println(R"res")
    @rget samples
end