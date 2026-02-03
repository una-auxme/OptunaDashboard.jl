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
    run(filpath)

Spawns a local web service running the Optuna Dashboard.

# Arguments 
- `storage` the Optuna storage to work with.

# Keyword Arguments
- `open_browser::Bool` if a browser window should be opened (default=`true`).
"""
function run(storage; open_browser::Bool = true)

    if open_browser
        DefaultApplication.open("http://localhost:8080/")
    end

    return optuna_dashboard.run_server(storage.storage)
end

end # module OptunaDashboard
