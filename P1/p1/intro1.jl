#import Pkg
#Pkg.add("JuMP")
#Pkg.add("GLPK")

using JuMP, GLPK
using Printf

model = Model(GLPK.Optimizer)
set_optimizer_attribute(model, "msg_lev", GLPK.GLP_MSG_ALL)
@variable(model, 2.0 >= x >= 0.0)
@variable(model, 1.0 >= y >= 0.0)

@constraint(model, x + y <= 4.0)
@constraint(model, -x + y <= 2.0)

@objective(model, Min, -x -y)

JuMP.optimize!(model)

JuMP.value(x)

@printf("x=%s, y=%s",JuMP.value(x),JuMP.value(y))