#
# Copyright (c) 2026 Julian Trommer, Valentin Höpfner, Andreas Hofmann, Josef Kircher, Tobias Thummerer, and contributors
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

module OptunaDashboard

import PythonCall, CondaPkg
import DefaultApplication

const optuna_dashboard = PythonCall.pynew()

function __init__()
    # CondaPkg.add("optuna-dashboard")
    return PythonCall.pycopy!(optuna_dashboard, PythonCall.pyimport("optuna_dashboard"))
end

"""
    run_server(storage, host, port, artifact_store; kwargs...)

Spawns a local web service running the Optuna Dashboard.
See [run_server](https://optuna-dashboard.readthedocs.io/en/stable/_generated/optuna_dashboard.run_server.html#optuna-dashboard-run-server) in the Optuna documentation.

# Arguments 
- `storage` the Optuna storage to work with.
- `host::String` host address, defaults to `"localhost"`
- `port::Integer` port number
- `artifact_store` the artifact storage (default `nothing`)

# Keyword Arguments
- `artifact_backend` the artifact backend (default `nothing`)
- `llm_provider` the LLM provider (default `nothing`)
- `open_browser::Bool` if a browser window should be opened (default=`true`).
"""
function run_server(
    storage,
    host::String="localhost",
    port::Integer=8080,
    artifact_store=nothing;
    artifact_backend=nothing,
    llm_provider=nothing,
    open_browser::Bool=true,
)

    if open_browser
        DefaultApplication.open("http://$(host):$(port)/")
    end

    return optuna_dashboard.run_server(
        storage.storage,
        host,
        port,
        isnothing(artifact_store) ? PythonCall.pybuiltins.None :
        artifact_store.artifact_store;
        artifact_backend=isnothing(artifact_backend) ? PythonCall.pybuiltins.None :
                         artifact_backend.artifact_backend,
        llm_provider=isnothing(llm_provider) ? PythonCall.pybuiltins.None :
                     llm_provider.llm_provider,
    )
end

end # module OptunaDashboard
