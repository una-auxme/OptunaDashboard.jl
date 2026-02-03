#
# Copyright (c) 2026 Julian Trommer, Valentin Höpfner, Andreas Hofmann, Josef Kircher, Tobias Thummerer, and contributors
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

using OptunaDashboard
using Optuna
using Test

@testset "OptunaDashboard.jl" begin

    # we run the dashboard in a thread, because it's blocking, and kill it after a few seconds 
    t = Threads.@spawn begin

        # central database storage for all studies
        database_url = "test/storage"
        database_name = "test_db"

        # name and artifact path for the study
        study_name = "test-study"
        artifact_path = "test/artifacts"

        # Create/Load database storage for studies
        storage_url = create_sqlite_url(database_url, database_name)
        storage = RDBStorage(storage_url)

        OptunaDashboard.run(storage; open_browser = false)
    end

    sleep(10.0)
    Base.throwto(t, InterruptException())

end
