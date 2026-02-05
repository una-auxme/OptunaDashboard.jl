#
# Copyright (c) 2026 Julian Trommer, Valentin Höpfner, Andreas Hofmann, Josef Kircher, Tobias Thummerer, and contributors
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

using Distributed
addprocs(1)

@everywhere using Optuna, OptunaDashboard, Test, HTTP

@testset "OptunaDashboard.jl" begin

    # we run the dashboard in a dedicated process, because it's blocking, and kill it after a few seconds 
    f = @spawnat workers()[1] begin

        # central database storage for all studies
        database_url = "tmp/storage"
        database_name = "test_db"

        # name and artifact path for the study
        study_name = "test-study"
        artifact_path = "tmp/artifacts"

        # Create/Load database storage for studies
        storage_url = create_sqlite_url(database_url, database_name)
        storage = RDBStorage(storage_url)

        OptunaDashboard.run(storage; open_browser=false)
    end

    sleep(10.0)

    # check if server is running
    r = HTTP.request("GET", "http://localhost:8080/")
    @test r.status == 200

    # clean up
    rmprocs(workers())
end
