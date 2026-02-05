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
    run_server(storage::Union{String, Optuna.BaseStorage}, host::String="localhost", port::Integer=8080, artifact_store::Union{Optuna.ArtifactStore, Optuna.ArtifactBackend, Nothing}=nothing; artifact_backend::Union{Optuna.ArtifactBackend, Nothing}=nothing, llm_provider::Union{Optuna.LLMProvider, Nothing}=nothing, open_browser::Bool=true)

Spawns a local web service running the Optuna Dashboard.
See [run_server](https://optuna-dashboard.readthedocs.io/en/stable/_generated/optuna_dashboard.run_server.html#optuna-dashboard-run-server) in the Optuna documentation.

# Arguments 
- `storage::Union{String, Optuna.BaseStorage}` the Optuna storage to work with.
- `host::String="localhost"` host address, defaults to `"localhost"`
- `port::Integer=8080` port number
- `artifact_store::Union{Optuna.ArtifactStore, Optuna.ArtifactBackend, Nothing}=nothing` the artifact storage (default `nothing`)

# Keyword Arguments
- `artifact_backend::Union{Optuna.ArtifactBackend, Nothing}=nothing` the artifact backend (default `nothing`)
- `llm_provider::Union{Optuna.LLMProvider, Nothing}=nothing` the LLM provider (default `nothing`)
- `open_browser::Bool=true` if a browser window should be opened (default=`true`).
"""
function run_server(
    storage::Any,
    host::String = "localhost",
    port::Integer = 8080,
    artifact_store::Any = nothing;
    artifact_backend::Any = nothing,
    llm_provider::Any = nothing,
    open_browser::Bool = true,
)

    if open_browser
        DefaultApplication.open("http://$(host):$(port)/")
    end

    return optuna_dashboard.run_server(
        isa(storage, String) ? storage : storage.storage,
        host,
        port,
        isnothing(artifact_store) ? nothing : artifact_store.artifact_store;
        artifact_backend = isnothing(artifact_backend) ? nothing :
                           artifact_backend.artifact_backend,
        llm_provider = isnothing(llm_provider) ? nothing : llm_provider.llm_provider,
    )
end

end # module OptunaDashboard
