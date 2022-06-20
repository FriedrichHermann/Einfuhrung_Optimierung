using JuMP, GLPK
using Printf

vars = Dict(
        "eins"=>Dict("obj"=>-1,"coeff1"=>1,"coeff2"=>-1,"coeff3"=>1, "coeff4"=>1),
        "zwei"=>Dict("obj"=>-1,"coeff1"=>1,"coeff2"=>1,"coeff3"=>0, "coeff4"=>1)
        )

constraints = Dict("coeff1"=>4,"coeff2"=>2,"coeff3"=>2,"coeff4"=>-4 )

model = Model(GLPK.Optimizer)
set_optimizer_attribute(model, "msg_lev", GLPK.GLP_MSG_ALL)

@variable(model, x[keys(vars)]>=0.0)

for (k,v) in constraints
    @constraint(model,sum([v2[k]*x[k2] for (k2,v2) in vars])<=v)
end

@objective(model, Min, sum([v["obj"]*x[k] for (k,v) in vars]))

JuMP.optimize!(model)

@printf("solution: %s",JuMP.value.(x))
