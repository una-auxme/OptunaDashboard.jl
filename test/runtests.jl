#
# Copyright (c) 2026 Julian Trommer, Valentin Höpfner, Andreas Hofmann, Josef Kircher, Tobias Thummerer, and contributors
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

using Distributed
addprocs(2)

@everywhere using Optuna, OptunaDashboard, Test, HTTP

@everywhere function run_test_server(args...; kwargs...)
    # central database storage for all studies
    tmp_dir = mktempdir()
    database_url = joinpath(tmp_dir, "storage")
    database_name = "test_db"

    # name and artifact path for the study
    study_name = "test-study"
    artifact_path = joinpath(tmp_dir, "artifacts")

    # Create/Load database storage for studies
    storage_url = create_sqlite_url(database_url, database_name)
    storage = RDBStorage(storage_url)

    return OptunaDashboard.run_server(storage, args...; kwargs...)
end

function test_server(pid, host::String="localhost", port::Integer=8080, args...; kwargs...)
    f = @spawnat pid run_test_server(args...; kwargs...)

    sleep(10.0)

    # check if server is running
    r = HTTP.request("GET", "http://$(host):$(port)/")
    @test r.status == 200

    # clean up
    return rmprocs(pid)
    #kill(pid, 2)
    #Distributed.interrupt(pid)
end

pids = workers()
@testset "OptunaDashboard.jl" begin
    test_server(pids[1]; open_browser=false)
    test_server(pids[2], "localhost", 8080; open_browser=false)
end
