using JuMP, GLPK
using Printf

model = Model(GLPK.Optimizer)
set_optimizer_attribute(model, "msg_lev", GLPK.GLP_MSG_ALL)

@variable(model, 2.0 >= x >= 0.0)
@variable(model, 2.0 >= x >= 0.0)
@variable(model, 2.0 >= x >= 0.0)
@variable(model, 2.0 >= x >= 0.0)
@variable(model, 2.0 >= x >= 0.0)
@variable(model, 2.0 >= x >= 0.0)
@variable(model, 2.0 >= x >= 0.0)
@variable(model, 2.0 >= x >= 0.0)