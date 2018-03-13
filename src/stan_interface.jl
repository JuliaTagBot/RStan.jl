

"""
This function calls rstan. Arguments:
    model_code, a character string that contains your model.
    Data, a list.
    Keyword arguments:
        adapt_delta
        max_treedepth.
    Feel free to edit this function and submit a pull request to add more functionality.

    Note that you can call

    @edit rstan("", Dict())
    
    and a text editor should open up, pointing to this function.
    You may want to set your editor first, eg:
    ENV["EDITOR"] = "code"
"""
function rstan(model_code, data; adapt_delta = 0.8, max_treedepth = 10)
    @rput model_code
    @rput data
    R"res <- stan(model_code = model_code, data = data, chains = getOption('mc.cores', 1L), control = list(adapt_delta = $adapt_delta, max_treedepth = $max_treedepth))"
    R"samples <- rstan::extract(res)"
    println(R"res")
    @rget samples
end