module MTMaths

using Metatheory 
using Metatheory.EGraphs
using Metatheory.EGraphs.Schedulers
using Metatheory.Classic
using Metatheory.Library

@metatheory_init ()

include("basetheory.jl")
include("difftheory.jl")
include("simplify.jl")
export simplify
export @simplify

end # module
