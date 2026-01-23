#
# Copyright (c) 2026 Julian Trommer, Valentin Höpfner, Andreas Hofman, Josef Kircher, Tobias Thummerer, and contributors
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

module OptunaDashboard

using Optuna: optuna
import PythonCall, CondaPkg

const optuna_dashboard = PythonCall.pynew()

function __init__()
    CondaPkg.add("optuna-dashboard")
    return PythonCall.pycopy!(optuna_dashboard, PythonCall.pyimport("optuna_dashboard"))
end

"""
    run(filpath)

Spawns a local web service running the Optuna Dashboard.

# Arguments 
- `filepath::String` a filepath for a database to open (default=nothing).
""" 
function run(filepath::Union{String, Nothing}=nothing)
    storage = optuna.storages.InMemoryStorage()
    optuna_dashboard.run_server(storage) # ToDo: add storage argument
    return odb
end

end # module OptunaDashboard
