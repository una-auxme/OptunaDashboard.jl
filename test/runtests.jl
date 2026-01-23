#
# Copyright (c) 2026 Julian Trommer, Valentin Höpfner, Andreas Hofman, Josef Kircher, Tobias Thummerer, and contributors
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

using OptunaDashboard
using Test

@testset "OptunaDashboard.jl" begin
    
    @test !isnothing(OptunaDashboard.run(; open_browser=false))

end
