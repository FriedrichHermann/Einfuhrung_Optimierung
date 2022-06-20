using NLPModels

mutable struct QuadReg{T, S} <: AbstractNLPModel{T, S}
	meta :: NLPModelMeta{T, S}
	counters :: Counters
    input_x :: Vector{Float64}
    input_y :: Vector{Float64}
end

function QuadReg(x,y)
	meta = NLPModelMeta(3, x0=[1.0,1.0,1.0], name="QuadReg")
	return QuadReg(meta,Counters(),x,y)
end

function NLPModels.obj(nlp :: QuadReg, a :: AbstractVector)
    return #...
end

function NLPModels.grad(nlp :: QuadReg, a :: AbstractVector)
    return #...
end