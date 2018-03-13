

function __init__()
    R"options(width=100)"
    R"suppressWarnings(library('rstan'))"
    R"rstan_options(auto_write = TRUE)"
    R"options(mc.cores = parallel::detectCores())"
end