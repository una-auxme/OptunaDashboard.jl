#
# Copyright (c) 2026 Julian Trommer, Valentin Höpfner, Andreas Hofmann, Josef Kircher, Tobias Thummerer, and contributors
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

module OptunaDashboard

using Optuna: optuna
import PythonCall, CondaPkg
import DefaultApplication

const optuna_dashboard = PythonCall.pynew()

function __init__()
    # CondaPkg.add("optuna-dashboard")
    return PythonCall.pycopy!(optuna_dashboard, PythonCall.pyimport("optuna_dashboard"))
end

"""
    run(filpath)

Spawns a local web service running the Optuna Dashboard.

# Arguments 
- `filepath::String` a filepath for a database to open (default=`nothing`).

# Keyword Arguments
- `open_browser::Bool` if a browser window should be opened (default=`true`).
"""
function run(filepath::Union{String,Nothing} = nothing; open_browser::Bool = true)
    storage = optuna.storages.InMemoryStorage() # ToDo: allow for different storages

    if open_browser
        DefaultApplication.open("http://localhost:8080/")
    end

    return optuna_dashboard.run_server(storage)
end

end # module OptunaDashboard
