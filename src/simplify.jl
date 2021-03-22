using Metatheory.TermInterface

## Canonicalization


function customlt(x,y)
    if typeof(x) == Expr && Expr == typeof(y)
        false
    elseif typeof(x) == typeof(y)
        isless(x,y)
    elseif x isa Symbol && y isa Number
        false
    else
        true
    end
end

canonical_t = @theory begin
    # restore n-arity
    (x + (+)(ys...)) => +(x,ys...)
    ((+)(xs...) + y) => +(xs..., y)
    (x * (*)(ys...)) => *(x,ys...)
    ((*)(xs...) * y) => *(xs..., y)

    (*)(xs...)      |> Expr(:call, :*, sort!(xs; lt=customlt)...)
    (+)(xs...)      |> Expr(:call, :+, sort!(xs; lt=customlt)...)
end


function simplify(ex)
    # rep = @timev begin
        g = EGraph(ex)
        params = SaturationParams(
            scheduler=ScoredScheduler,
            timeout=7,
            schedulerparams=(8,2, Schedulers.exprsize),
            #stopwhen=stopwhen,
        )
        saturate!(g, cas, params)
        res = extract!(g, astsize)
        res = rewrite(res, canonical_t; clean=false, m=@__MODULE__)
    # end
    # rep
end

macro simplify(ex)
    Meta.quot(simplify(ex))
end
