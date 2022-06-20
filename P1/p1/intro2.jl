using JuMP, GLPK
using Printf

A = [1 1;-1 1;1 0;-1 0;0 -1]
b = [4, 2, 2, 0, 0]
c = [-1,-0.25]

model = Model(GLPK.Optimizer)
set_optimizer_attribute(model, "msg_lev", GLPK.GLP_MSG_ALL)

@variable(model, x[1:2])

@constraint(model,A*x .<= b)

@objective(model, Min, x'*c)

JuMP.optimize!(model)

@printf("solution: %s",JuMP.value.(x))
z=JuMP.value.(x)
z'*c