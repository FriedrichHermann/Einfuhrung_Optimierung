using NLPModels

mutable struct LinReg{T, S} <: AbstractNLPModel{T, S}
	meta :: NLPModelMeta{T, S}
	counters :: Counters
    input_x :: Vector{Float64}
    input_y :: Vector{Float64}
end

function LinReg(x,y)
	meta = NLPModelMeta(2, x0=[10.0;10.0], name="LinReg")
	return LinReg(meta,Counters(),x,y)
end

function NLPModels.obj(nlp :: LinReg, a :: AbstractVector)
    return sum([(yi-a[1]-a[2]*xi)^2 for (xi,yi) in zip(nlp.input_x,nlp.input_y)])
end

function NLPModels.grad(nlp :: LinReg, a :: AbstractVector)
    return [sum([ for (xi,yi) in zip(nlp.input_x,nlp.input_y)]); #...
            sum([ for (xi,yi) in zip(nlp.input_x,nlp.input_y)])] #...
end